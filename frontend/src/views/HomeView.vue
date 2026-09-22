<template>
  <div class="home-container">
    <div class="hero">
      <h1>Selamat Datang di Katalog Produk</h1>
      <p class="subtitle">
        Aplikasi Frontend Vue 3 terintegrasi dengan Backend Laravel REST API.
      </p>
      <div class="info-card">
        <h3>Informasi Sistem</h3>
        <ul>
          <li><strong>Frontend:</strong> Vue 3 + Vite + Vue Router</li>
          <li><strong>Backend API:</strong> Laravel REST API</li>
          <li><strong>Status API:</strong> Terhubung ke <code>{{ apiUrl }}</code></li>
        </ul>
      </div>
      <router-link to="/products" class="btn-primary">
        Lihat Daftar Produk &rarr;
      </router-link>
    </div>
  </div>
</template>

<script setup>
const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8000/api'
</script>

<style scoped>
.home-container {
  max-width: 800px;
  margin: 40px auto;
  padding: 24px;
}

.hero {
  text-align: center;
  background: #ffffff;
  border-radius: 12px;
  padding: 40px 32px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

h1 {
  font-size: 2rem;
  color: #1e293b;
  margin-bottom: 12px;
}

.subtitle {
  font-size: 1.1rem;
  color: #64748b;
  margin-bottom: 28px;
}

.info-card {
  text-align: left;
  background: #f8fafc;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  padding: 20px 24px;
  margin: 0 auto 32px;
  max-width: 500px;
}

.info-card h3 {
  margin-top: 0;
  margin-bottom: 12px;
  color: #334155;
}

.info-card ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.info-card li {
  padding: 6px 0;
  color: #475569;
}

code {
  background: #e2e8f0;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 0.9em;
  color: #0f172a;
}

.btn-primary {
  display: inline-block;
  background: #2563eb;
  color: #ffffff;
  padding: 12px 28px;
  border-radius: 8px;
  text-decoration: none;
  font-weight: 600;
  transition: background 0.2s ease;
}

.btn-primary:hover {
  background: #1d4ed8;
}
</style>
