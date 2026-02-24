<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Category;
use App\Models\Product;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $category = Category::create([
            'name' => 'Konser Musik',
            'description' => 'Kategori untuk tiket konser musik',
        ]);

        Product::create([
            'category_id' => $category->id,
            'name' => 'Tiket Konser A',
            'description' => 'Tiket VIP untuk Konser A',
            'stock' => 100,
            'price' => 25000,
            'status' => 'published',
            'criteria' => 'Perorang',
        ]);

        Product::create([
            'category_id' => $category->id,
            'name' => 'Tiket Konser B',
            'description' => 'Tiket Reguler untuk Konser B',
            'stock' => 50,
            'price' => 15000,
            'status' => 'published',
            'criteria' => 'Perorang',
        ]);
    }
}
