<?php


namespace App\Service;


use App\Model\Download;
use App\Model\Lists;
use App\Traits\Util;
use GuzzleHttp\Utils;
use function Taoran\HyperfPackage\Helpers\set_save_data;

class FetchWebInfoService
{
    public function fetch($url)
    {
        // 正则表达式匹配域名
        // 允许字母、数字、连字符，不以连字符开头或结尾，总长度不超过253个字符（包括点）
        // 每个标签（label）长度在1到63个字符之间
        // 这里假设顶级域名（TLD）至少有两个字符，例如.com, .org等
        $domainRegex = '/^(?![0-9]+$)(?!-)[a-zA-Z0-9-]{1,63}(?<!-)(\.[a-zA-Z0-9-]{1,63}(?<!-))*$/';

        // 去除前后空格，并转换为小写进行匹配（可选，取决于你是否需要区分大小写）
        $trimmedInput = trim(strtolower($url));

        // 使用preg_match进行正则匹配
        if (!preg_match($domainRegex, $trimmedInput)) {
            throw new \Exception('无效的域名或地址');
        }

        //获取网站信息
        $data = [
            'keywords' => '无',
            'desc' => '无',
        ];
        $html = Util::httpRequest($trimmedInput, 'get');
        $dom = new \DOMDocument();
        @$dom->loadHTML($html);
        $metas = $dom->getElementsByTagName('meta');
        $links = $dom->getElementsByTagName('link');
        $titles = $dom->getElementsByTagName('title');

        //meta
        for ($i = 0; $i < $metas->length; $i++) {
            $meta = $metas->item($i);
            if ($meta->getAttribute('name') == 'description') {
                $data['desc'] = $meta->getAttribute('content');
            }
            if ($meta->getAttribute('name') == 'keywords') {
                $data['keywords'] = $meta->getAttribute('content');
            }
        }

        //logo
        for ($i = 0; $i < $links->length; $i++) {
            $link = $links->item($i);
            if ($link->getAttribute('rel') != 'shortcut icon') {
                continue;
            }
            $data['logo'] = $link->getAttribute('href');
            //相对路径转换
            if (strpos($data['logo'], '//') !== 0 && strpos($data['logo'], 'http') !== 0) {
                $data['logo'] = 'https://' . $url . $data['logo'];
            }
        }
        if (empty($data['logo'])) {
            $data['logo'] = 'https://' . $url . '/favicon.ico';
        }

        //title
        for ($i = 0; $i < $titles->length; $i++) {
            $title = $titles->item($i);
            $data['title'] = $title->textContent;
        }

        return $data;
    }
}