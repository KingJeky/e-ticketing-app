<?php

namespace App\Http\Controllers\api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderItem;

class OrderController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $orders = Order::with('orderitems')->latest()->paginate(10);
        return response()->json([
            'status' => 'success',
            'data' => $orders
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'transaction_time' => 'required',
            'total_price' => 'required|integer',
            'total_item' => 'required|integer',
            'payment_amount' => 'required|integer',
            'cashier_id' => 'required|exists:users,id',
            'cashier_name' => 'required|string',
            'payment_method' => 'required|string',
            'order_items' => 'required|array',
        ]);

        $order = new Order;

        $order->transactions_time = $request->transaction_time;
        $order->total_price = $request->total_price;
        $order->total_item = $request->total_item;
        $order->payment_amount = $request->payment_amount;
        $order->cashier_id = $request->cashier_id;
        $order->cashier_name = $request->cashier_name;
        $order->payment_method = $request->payment_method;
        $order->order_items = $request->order_items;

        $order->save();

        foreach($request->order_items as $item){
            $orderItem = new OrderItem;
            $orderItem->order_id = $order->id;
            $orderItem->product_id = $item['product_id'];
            $orderItem->quantity = $item['quantity'];
            $orderItem->total_price = $item['total_price'];

            $orderItem->save();
        }

        return response()->json([
            'status' => 'success',
            'data' => $order
        ],201);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $order = Order::with('orderitems')->find($id);

        if ($order) {
            return response()->json([
                'status' => 'success',
                'data' => $order,
            ]);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Order not found',
            ], 404);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
