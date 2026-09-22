<template>
  <div class="app-layout">
    <header class="navbar">
      <div class="nav-brand">
        <span>🛒 Laravel + Vue 3 App</span>
      </div>
      <nav class="nav-links">
        <router-link to="/" class="nav-item">Beranda</router-link>
        <router-link to="/products" class="nav-item">Daftar Produk</router-link>
      </nav>
    </header>

    <main class="main-content">
      <router-view />
    </main>
  </div>
</template>

<script setup>
</script>

<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
  font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
}

body {
  background-color: #f8fafc;
  color: #1e293b;
  min-height: 100vh;
}

.app-layout {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.navbar {
  background-color: #ffffff;
  border-bottom: 1px solid #e2e8f0;
  padding: 16px 32px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.nav-brand {
  font-weight: 700;
  font-size: 1.15rem;
  color: #0f172a;
}

.nav-links {
  display: flex;
  gap: 16px;
}

.nav-item {
  color: #64748b;
  text-decoration: none;
  font-weight: 500;
  padding: 8px 14px;
  border-radius: 6px;
  transition: all 0.2s ease;
}

.nav-item:hover {
  color: #2563eb;
  background-color: #eff6ff;
}

.nav-item.router-link-active {
  color: #2563eb;
  background-color: #dbeafe;
  font-weight: 600;
}

.main-content {
  flex: 1;
}
</style>
