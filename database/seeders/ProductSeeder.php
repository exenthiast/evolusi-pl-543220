<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Product::updateOrCreate(
            ['name' => 'Laptop ASUS ROG'],
            [
                'description' => 'Laptop gaming bertenaga tinggi untuk tugas berat dan multimedia.',
                'price' => 18500000,
            ]
        );

        Product::updateOrCreate(
            ['name' => 'Mechanical Keyboard RGB'],
            [
                'description' => 'Keyboard mekanik dengan switch tactile dan pencahayaan RGB.',
                'price' => 850000,
            ]
        );

        Product::updateOrCreate(
            ['name' => 'Wireless Gaming Mouse'],
            [
                'description' => 'Mouse nirkabel ultra-ringan dengan sensor optik presisi tinggi.',
                'price' => 450000,
            ]
        );
    }
}
