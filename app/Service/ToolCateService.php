<?php


namespace App\Service;

use App\Model\ToolCate;

class ToolCateService
{
    public function getList()
    {
        $list = ToolCate::with(['tools' => function ($query) {
            $query->with('toolCate');
        }])->orderBy('sort', 'asc')->get();
        $list->each(function ($item) {
            $tools = $item->tools;
            $tools->each(function ($toolItem) {
                $toolItem->cate = $toolItem->toolCate->title;
                unset($toolItem->toolCate);
            });
            $item->list = $item->tools;
            unset($item->tools);
        });
        return $list;
    }
}