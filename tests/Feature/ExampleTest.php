<?php

test('the application returns a successful response', function () {
    $response = $this->get('/');

    // Sengaja dibuat gagal untuk pengujian Skenario B
    $this->assertTrue(false);

    $response->assertStatus(200);
});
