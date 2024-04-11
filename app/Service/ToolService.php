<?php


namespace App\Service;


use App\Model\Download;
use App\Model\Lists;
use App\Model\Tool;
use App\Model\ToolCollect;
use App\Model\Users;
use function Taoran\HyperfPackage\Helpers\set_save_data;

class ToolService
{
    public function getList($params)
    {
        $list = Tool::with('toolCate');

        if (!empty($params['title'])) {
            $list = $list->where('title', 'like', "%{$params['title']}%");
        }

        if (!empty($params['cateId'])) {
            $list = $list->where('cate_id', $params['cateId']);
        }

        if (!empty($params['route'])) {
            $list = $list->where('url', $params['route']);
        }

        $list = $list->get();
        $list->each(function ($item) {
            $item->cate = $item->toolCate->title ?? '';
            unset($item->toolCate);
        });
        return $list;
    }

    public function getRandomRecommend()
    {
        $list = Tool::orderByRaw('RAND()')->limit(10)->get();
        return $list;
    }

    public function collect($id, $params)
    {
        $msg = '收藏成功';
        //判断是否已经收藏
        $info = ToolCollect::where('user_id', $params['user_id'])->where('tool_id', $id)->first();
        if ($info) {
            //取消收藏
            ToolCollect::where('user_id', $params['user_id'])->where('tool_id', $id)->forceDelete();
            $msg = '取消收藏';
        } else {
            //新增收藏
            $collectModel = new ToolCollect();
            set_save_data($collectModel, [
                'user_id' => $params['user_id'],
                'tool_id' => $id,
            ]);
            $collectModel->save();
        }
        return [
            'msg' => $msg
        ];
    }

    public function getCollects($params)
    {
        $list = Users::with(['tools' =>  function ($query) {
            return $query->with('toolCate');
        }])->find($params['user_id']);
        $list->tools->each(function ($item) {
            $item->cate = $item->toolCate->title ?? '';
            unset($item->toolCate);
            unset($item->pivot);
            unset($item->created_at);
            unset($item->updated_at);
            unset($item->deleted_at);
        });
        return $list->tools;
    }
}