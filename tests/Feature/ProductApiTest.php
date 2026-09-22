<?php

use App\Models\Product;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

test('can list all products via api', function () {
    Product::create([
        'name' => 'Laptop Asus',
        'description' => 'Laptop gaming',
        'price' => 15000000,
    ]);

    $response = $this->getJson('/api/products');

    $response->assertStatus(200)
        ->assertJsonCount(1)
        ->assertJsonFragment([
            'name' => 'Laptop Asus',
        ]);
});

test('can create a product via api', function () {
    $data = [
        'name' => 'Monitor 144Hz',
        'description' => 'IPS Gaming Monitor',
        'price' => 2500000,
    ];

    $response = $this->postJson('/api/products', $data);

    $response->assertStatus(201)
        ->assertJsonFragment([
            'name' => 'Monitor 144Hz',
        ]);

    $this->assertDatabaseHas('products', [
        'name' => 'Monitor 144Hz',
    ]);
});

test('cors headers are configured correctly', function () {
    $response = $this->withHeaders([
        'Origin' => 'http://localhost:5173',
        'Access-Control-Request-Method' => 'GET',
    ])->options('/api/products');

    $response->assertHeader('Access-Control-Allow-Origin', 'http://localhost:5173');
});
