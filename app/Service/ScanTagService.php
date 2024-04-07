<?php
namespace App\Service;

use App\Amqp\Producer\IntegralProducer;
use App\Model\IntegralLog;
use App\Model\OpenapiProduct;
use App\Model\ScanFile;
use App\Model\ScanTag;
use App\Model\Tool;
use App\Model\Users;
use Hyperf\Amqp\Producer;
use Hyperf\Di\Annotation\Inject;
use Hyperf\Redis\Redis;
use phpseclib3\Math\BigInteger\Engines\PHP;
use function Taoran\HyperfPackage\Helpers\set_save_data;

class ScanTagService
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

    public function getList()
    {
        //parent tags
        $list = ScanTag::where('pid', 0)->get()->toArray();

        //child tags
        $childTags = ScanTag::where('pid', '>', 0)->get()->toArray();

        //build
        foreach ($list as $key => $val) {
            foreach ($childTags as $childKey => $childVal) {
                if ($childVal['pid'] == $val['id']) {
                    $list[$key]['childTags'][] = $childVal;
                }
            }
        }
        return $list;
    }
}