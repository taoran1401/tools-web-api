<?php

declare (strict_types=1);
namespace App\Model;

/**
 */
class ScanFileTag extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'scan_file_tag';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [];
    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [];
}