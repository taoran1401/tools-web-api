<?php

declare(strict_types=1);

namespace App\Controller\Api;

use App\Service\ToolService;
use Hyperf\Di\Annotation\Inject;
use Taoran\HyperfPackage\Core\AbstractController;

class ToolController extends AbstractController
{
    /**
     * @Inject()
     * @var ToolService
     */
    private $toolService;

    public function index()
    {
        $params = $this->verify->requestParams([
            ['title', ''],
            ['cateId', ''],
            ['route', ''],
        ], $this->request);
        try {
            $this->verify->check($params, [
                'cateId' => 'integer'
            ], []);
            $list = $this->toolService->getList($params);
            return $this->responseCore->success($list);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }

    /**
     * 随机推荐
     */
    public function randomRecommend()
    {
        try {
            $list = $this->toolService->getRandomRecommend();
            return $this->responseCore->success($list);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }

    /**
     * 收藏
     *
     * @param $id
     * @return array
     */
    public function collect($id)
    {
        try {
            $userId = $this->request->getAttribute('user_id');
            $params = [
                'user_id' => $userId
            ];
            $info = $this->toolService->collect($id, $params);
            return $this->responseCore->success([], $info['msg']);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }

    /**
     * 收藏列表
     */
    public function getCollects()
    {
        try {
            $userId = $this->request->getAttribute('user_id');
            $params = [
                'user_id' => $userId
            ];
            $list = $this->toolService->getCollects($params);
            return $this->responseCore->success($list);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }
}
