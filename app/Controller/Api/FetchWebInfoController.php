<?php

declare(strict_types=1);

namespace App\Controller\Api;

use App\Service\FetchWebInfoService;
use Hyperf\Di\Annotation\Inject;
use Taoran\HyperfPackage\Core\AbstractController;

class FetchWebInfoController extends AbstractController
{
    /**
     * @Inject()
     * @var FetchWebInfoService
     */
    private $fetchWebInfoService;

    public function fetch($url)
    {
        try {
            $data = $this->fetchWebInfoService->fetch($url);
            return $this->responseCore->success($data);
        } catch (\Exception $e) {
            return $this->responseCore->error($e->getMessage());
        }
    }
}
