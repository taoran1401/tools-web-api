<?php
namespace App\Service;

use App\Amqp\Producer\IntegralProducer;
use App\Model\IntegralLog;
use App\Model\Lists;
use App\Model\OpenapiProduct;
use App\Model\ScanFile;
use App\Model\ScanFileTag;
use App\Model\ScanTag;
use App\Model\Tool;
use App\Model\Users;
use Hyperf\Amqp\Producer;
use Hyperf\Di\Annotation\Inject;
use Hyperf\Redis\Redis;
use phpseclib3\Math\BigInteger\Engines\PHP;
use function Taoran\HyperfPackage\Helpers\set_save_data;

class ScanService
{
    /**
     * @Inject()
     * @var Redis
     */
    public $redis;

    /**
     * @Inject()
     * @var Producer
     */
    public $producer;

    public function getList($params)
    {
        $list = ScanFile::with('scanTag');

        if (!empty($params['title'])) {
            $list = $list->where('title', 'like', "%{$params['title']}%");
        }

        if (!empty($params['tags'])) {
            $list = $list->with(['scanTag' => function ($query) use ($params) {
                $tags = explode(',', $params['tags']);
                $query->whereIn('tag_id', $tags);
            }]);
        }

        $list = $list->paginate($params['limit']);
        $list->each(function ($item) {
//            $item->tag = $item->scanTag->title ?? '异常标签';
//            unset($item->scanTag);
        });
        return $list;
    }

    public function getOne($id)
    {
        $info = ScanFile::with('scanTag')->find($id);
        $tags = [];
        $info->scanTag->each(function ($item) use (&$tags) {
            $tags[] = $item->id;
        });
        unset($info->scanTag);
        $info->tags = $tags;
        return $info;
    }

    public function scan($params)
    {
        //格式
        $exts = explode(',', $params['exts']);

        //目录
        $dir = $params['dir'];
        if (empty($exts) || empty($dir)) {
            throw new \Exception("参数错误");
        }

        $this->scanHandle($exts, $dir);

    }

    /*
     * 扫描 - 操作
     */
    public function scanHandle($exts, $dir)
    {
        $dir = rtrim($dir, '/');
        $files = scandir($dir);

        foreach ($files as $file) {
            if ($file == "." || $file == "..") {
                // 排除当前目录和上级目录
                continue;
            }

            //递归扫描
            $tmpDir = $dir . '/' .  $file;
            if (is_dir($tmpDir)) {
                $this->scanHandle($exts, $tmpDir);
            }

            $ext = $this->getExt($file);
            if (!in_array($ext, $exts)) {
                //排除不满足格式文件
                continue;
            }

            $this->add($dir, $file, $ext);
        }
    }

    /**
     * add
     *
     * @param $dir
     * @param $file
     * @return bool
     */
    public function add($dir, $file, $ext)
    {
        //存在则跳过
        $path = $dir . '/' . $file;
        if (ScanFile::where('path', $path)->exists()) {
            return true;
        }

        //入库
        $scanFile = new ScanFile();
        $insertData = [
            'title' => $file,
            'dir' => $dir,
            'path' => $path,
            'ext' => $ext,
        ];
        $scanFile = set_save_data($scanFile, $insertData);
        $scanFile->save();
    }

    /**
     * 获取文件后缀
     *
     * @param $filename
     * @return mixed
     */
    public function getExt($filename)
    {
        return pathinfo($filename, PATHINFO_EXTENSION);
    }

    /**
     * 更新标签
     */
    public function updateTag($params)
    {
        if (!ScanFile::where('id', $params['fileId'])->exists()) {
            throw new \Exception("扫描文件不存在");
        }

        if (!ScanTag::where('id', $params['tagId'])->exists()) {
            throw new \Exception("标签不存在");
        }

        $fileTag = ScanFileTag::where('file_id', $params['fileId'])->where('tag_id', $params['tagId'])->first();
        if ($fileTag) {
            //删除
            $fileTag->forceDelete();
        } else {
            //新增
            $model = new ScanFileTag();
            $model = set_save_data($model, [
                'file_id' => $params['fileId'],
                'tag_id' => $params['tagId'],
            ]);
            $model->save();
        }
    }

    /**
     * 更新标签 - 批量
     */
    public function batchUpdateTag($id, $params)
    {
        if (empty($params['tags'])) {
            throw new \Exception("参数错误");
        }

        if (!ScanFile::where('id', $id)->exists()) {
            throw new \Exception("扫描文件不存在");
        }

        //删除旧tags
        ScanFileTag::where('file_id', $id)->delete();
        //更新标签
        $tags = explode(',', $params);

        $fileTag = new ScanFileTag();
        foreach ($tags as $val) {
            $insertData = [
                'file_id' => $id,
                'tag_id' => $val,
            ];
            $fileTag = set_save_data($fileTag, $insertData);
            $fileTag->save();
        }
    }
}