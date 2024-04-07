<?php

declare (strict_types=1);
namespace App\Model;

/**
 */
class ScanFile extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'scan_file';

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

    /**
     * 关联 scan_tag
     *
     * @return \Hyperf\Database\Model\Relations\HasOne
     */
    public function scanTag()
    {
        return $this->belongsToMany(ScanTag::class, 'scan_file_tag', 'file_id', 'tag_id')->orderBy('sort', 'desc');
    }
}