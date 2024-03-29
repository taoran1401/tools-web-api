<?php

declare (strict_types=1);
namespace App\Model;

/**
 */
class Users extends Model
{
    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'users';

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
     * 关联: user_secret
     *
     * @return \Hyperf\Database\Model\Relations\HasOne
     */
    public function userSecret()
    {
        return $this->hasOne(UserSecret::class, 'user_id', 'id');
    }

    /**
     * 关联：member
     *
     * @return \Hyperf\Database\Model\Relations\HasOne
     */
    public function member()
    {
        return $this->hasOne(Member::class, 'id', 'member_id');
    }

    /**
     * 关联 - tool
     */
    public function tools()
    {
        return $this->belongsToMany(Tool::class, 'tool_collect', 'user_id', 'tool_id');
    }
}