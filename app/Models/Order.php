<?php

namespace App\Models;

use App\Models\OrderItem;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;
    protected $guarded = ['id'];
    protected $table = 'orders';
    protected $fillable = [
        'transactions_time',
        'total_price',
        'total_item',
        'payment_amount',
        'cashier_id',
        'cashier_name',
        'payment_method',
    ];


    public function orderitems(){
        return $this->hasMany(OrderItem::class);
    }
    
}

