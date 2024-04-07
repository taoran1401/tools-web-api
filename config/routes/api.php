<?php

declare(strict_types=1);

use Hyperf\HttpServer\Router\Router;

$middleware = [
    \App\Middleware\JWTAuthMiddleware::class
];

//test
Router::addRoute(['GET', 'POST', 'PUT', 'DELETE'], '/test', 'App\Controller\IndexController@index');

Router::addGroup('/v1', function () {
    //注册 - 发送验证码
    Router::post('/send/register/code', 'App\Controller\Api\AuthController@sendRegisterCode');
    //注册
    Router::post('/register', 'App\Controller\Api\AuthController@register');
    //登录
    Router::post('/login', 'App\Controller\Api\AuthController@login');
    //忘记密码 - 发送验证码
    Router::post('/send/forget/password/code', 'App\Controller\Api\AuthController@sendForgetPasswordCode');
    //忘记密码
    Router::post('/forget/password', 'App\Controller\Api\AuthController@forgetPassword');
    //get tool list
    Router::get('/tools', 'App\Controller\Api\ToolController@index');
    //get tool cate
    Router::get('/tool/cates', 'App\Controller\Api\ToolCateController@index');
    //get tool recommend
    Router::get('/tool/recommends', 'App\Controller\Api\ToolController@randomRecommend');
    //fetch web info
    Router::get('/webinfo/{url}', 'App\Controller\Api\FetchWebInfoController@fetch');
});

Router::addGroup('/v1', function () {
    Router::post('/test', 'App\Controller\IndexController@index');
    //修改密码 - 发送验证码
    Router::post('/send/reset/password/code', 'App\Controller\Api\AuthController@sendResetPasswordCode');
    //修改密码
    Router::post('/reset/password', 'App\Controller\Api\AuthController@resetPassword');
    //登出
    Router::post('/logout', 'App\Controller\Api\AuthController@logout');
    //签到
    Router::post('/check/in', 'App\Controller\Api\UserController@checkIn');
    //用户信息
    Router::get('/user/info', 'App\Controller\Api\UserController@show');
    //获取积分产品
    Router::get('/integral/product/lists', 'App\Controller\Api\IntegralProductController@index');
    //获取会员产品
    Router::get('/member/product/lists', 'App\Controller\Api\MemberProductController@index');
    //购买积分
    Router::post('/buy/integral', 'App\Controller\Api\OrderController@buyIntegral');
    //购买会员
    Router::post('/buy/member', 'App\Controller\Api\OrderController@buyMember');
    //积分流水列表
    Router::get('/integral/lists', 'App\Controller\Api\IntegralLogController@index');
    //tool collect
    Router::post('/tool/collects/{id}', 'App\Controller\Api\ToolController@collect');
    //get collect
    Router::get('/get/tool/collects', 'App\Controller\Api\ToolController@getCollects');
}, ['middleware' => $middleware]);

//pay
Router::addGroup('/v1/pay', function () use ($middleware) {
    //获取产品
//    Router::post('/products', 'App\Controller\Api\PayController@checkouts');
    //获取变体
//    Router::post('/variants', 'App\Controller\Api\PayController@checkouts');
    //回调
    Router::post('/callback', 'App\Controller\Api\CallbackController@payCallback');
    Router::get('/testcallback', 'App\Controller\Api\CallbackController@testCallback');
});


//scan
Router::addGroup('/v1', function () {
    //获取文件列表
    Router::get('/scans', 'App\Controller\Api\ScanController@index');
    //获取文件信息
    Router::get('/scans/{id}', 'App\Controller\Api\ScanController@show');
    //获取标签
    Router::get('/scan/tags', 'App\Controller\Api\ScanTagController@index');
    //更新标签
    Router::post('/scan/tag/updates', 'App\Controller\Api\ScanController@updateTag');
});
