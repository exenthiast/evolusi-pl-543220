<?php

use App\Models\Product;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

test('can list all products', function () {
    Product::create([
        'name' => 'Laptop Asus',
        'description' => 'Laptop gaming',
        'price' => 15000000,
    ]);

    $response = $this->getJson('/products');

    $response->assertStatus(200)
        ->assertJsonCount(1);
});

test('can create a product', function () {
    $data = [
        'name' => 'Keyboard Mechanical',
        'description' => 'RGB mechanical keyboard',
        'price' => 750000,
    ];

    $response = $this->postJson('/products', $data);

    $response->assertStatus(201)
        ->assertJsonFragment([
            'name' => 'Keyboard Mechanical',
        ]);

    $this->assertDatabaseHas('products', [
        'name' => 'Keyboard Mechanical',
    ]);
});

test('can show a product', function () {
    $product = Product::create([
        'name' => 'Mouse Wireless',
        'description' => 'Mouse ergonomis',
        'price' => 250000,
    ]);

    $response = $this->getJson("/products/{$product->id}");

    $response->assertStatus(200)
        ->assertJson([
            'id' => $product->id,
            'name' => 'Mouse Wireless',
        ]);
});

test('can update a product', function () {
    $product = Product::create([
        'name' => 'Headset',
        'description' => 'Headset stereo',
        'price' => 300000,
    ]);

    $response = $this->putJson("/products/{$product->id}", [
        'name' => 'Headset Pro',
        'price' => 350000,
    ]);

    $response->assertStatus(200)
        ->assertJsonFragment([
            'name' => 'Headset Pro',
        ]);

    $this->assertDatabaseHas('products', [
        'id' => $product->id,
        'name' => 'Headset Pro',
    ]);
});

test('can delete a product', function () {
    $product = Product::create([
        'name' => 'Webcam HD',
        'description' => '1080p webcam',
        'price' => 500000,
    ]);

    $response = $this->deleteJson("/products/{$product->id}");

    $response->assertStatus(200);
    $this->assertDatabaseMissing('products', [
        'id' => $product->id,
    ]);
});
