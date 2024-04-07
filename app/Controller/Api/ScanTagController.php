<?php

declare(strict_types=1);

namespace App\Controller\Api;

use App\Service\ScanTagService;
use Hyperf\Di\Annotation\Inject;
use Taoran\HyperfPackage\Core\AbstractController;

class ScanTagController extends AbstractController
{
    /**
     * @Inject()
     * @var ScanTagService
     */
    private $service;

    public function index()
    {
        try {
            $list = $this->service->getList();
            return $this->responseCore->success($list);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }
}
