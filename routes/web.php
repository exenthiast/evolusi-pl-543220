<?php

use App\Http\Controllers\ProductController;
use Illuminate\Support\Facades\Route;

// Uji Docker Layer Caching 2026
Route::get('/', function () {
    return view('welcome');
});

Route::resource('products', ProductController::class);

