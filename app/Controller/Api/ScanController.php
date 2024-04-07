<?php

declare(strict_types=1);

namespace App\Controller\Api;

use App\Service\ScanService;
use Hyperf\Di\Annotation\Inject;
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\HttpServer\Contract\ResponseInterface;
use Taoran\HyperfPackage\Core\AbstractController;

class ScanController extends AbstractController
{
    /**
     * @Inject()
     * @var ScanService
     */
    private $service;


    public function index()
    {
        $params = $this->verify->requestParams([
            ['title', ''],
            ['tags', ''],
            ['page', 1],
            ['limit', 3],
        ], $this->request);
        try {
            $list = $this->service->getList($params);
            return $this->responseCore->success($list);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }

    public function show($id)
    {
        try {
            $data = $this->service->getOne($id);
            return $this->responseCore->success($data);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }

    /**
     * 扫描 - 暂时无用
     *
     * @return array
     */
    public function scan()
    {
        $params = $this->verify->requestParams([
            ['path', ''],
            ['ext', 'png,jpg'],
        ], $this->request);
        try {
            $data = $this->service->scan($params);
            return $this->responseCore->success([]);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }

    public function store()
    {
        try {
            $params['user_id'] = $this->request->getAttribute('user_id');
            $this->service->add($params);
            return $this->responseCore->success([]);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }

    public function update($id)
    {
        $params = $this->verify->requestParams([
            ['content', ''],
        ], $this->request);

        try {
            $params['user_id'] = $this->request->getAttribute('user_id');
            $this->service->update($id, $params);
            return $this->responseCore->success([]);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }

    public function destroy($id)
    {
        try {
            $this->service->delete($id);
            return $this->responseCore->success([]);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }

    /**
     * 更新标签
     */
    public function updateTag()
    {
        $params = $this->verify->requestParams([
            ['fileId', ''],
            ['tagId', ''],
        ], $this->request);
        try {
            $this->service->updateTag($params);
            return $this->responseCore->success([]);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }


    /**
     * 更新标签 - 批量
     */
    public function batchUpdateTag($id)
    {
        $params = $this->verify->requestParams([
            ['tags', ''],
        ], $this->request);
        try {
            $this->service->batchUpdateTag($id, $params);
            return $this->responseCore->success([]);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }
}
