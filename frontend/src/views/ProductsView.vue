<template>
  <div class="products-container">
    <div class="header">
      <h2>Daftar Produk</h2>
      <p class="api-badge">
        Sumber API: <code>{{ apiUrl }}/products</code>
      </p>
    </div>

    <!-- Loading State -->
    <div v-if="loading" class="state-box">
      <div class="spinner"></div>
      <p>Memuat data produk dari Laravel...</p>
    </div>

    <!-- Error State -->
    <div v-else-if="error" class="state-box error-box">
      <p class="error-title">Gagal Mengambil Data</p>
      <p class="error-msg">{{ error }}</p>
      <button class="btn-retry" @click="fetchProducts">Coba Lagi</button>
    </div>

    <!-- Empty State -->
    <div v-else-if="products.length === 0" class="state-box">
      <p>Belum ada produk yang tersedia di database.</p>
    </div>

    <!-- Products Grid -->
    <div v-else class="products-grid">
      <div v-for="product in products" :key="product.id" class="product-card">
        <div class="card-header">
          <span class="product-id">#{{ product.id }}</span>
          <h3 class="product-name">{{ product.name }}</h3>
        </div>
        <p class="product-desc">{{ product.description || 'Tidak ada deskripsi.' }}</p>
        <div class="card-footer">
          <span class="product-price">{{ formatPrice(product.price) }}</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { formatPrice } from '../utils/formatters.js'
import { getProducts } from '../services/api.js'

const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:8000/api'
const products = ref([])
const loading = ref(true)
const error = ref(null)

const fetchProducts = async () => {
  loading.value = true
  error.value = null
  try {
    const data = await getProducts(apiUrl)
    products.value = data
  } catch (err) {
    error.value = err.message || 'Terjadi kesalahan saat menghubungi API Laravel'
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchProducts()
})
</script>

<style scoped>
.products-container {
  max-width: 1000px;
  margin: 32px auto;
  padding: 0 20px;
}

.header {
  margin-bottom: 24px;
}

h2 {
  font-size: 1.8rem;
  color: #1e293b;
  margin-bottom: 6px;
}

.api-badge {
  font-size: 0.9rem;
  color: #64748b;
}

code {
  background: #f1f5f9;
  padding: 2px 6px;
  border-radius: 4px;
  color: #0284c7;
}

.state-box {
  text-align: center;
  padding: 60px 20px;
  background: #ffffff;
  border-radius: 12px;
  border: 1px solid #e2e8f0;
  color: #64748b;
}

.error-box {
  border-color: #fecaca;
  background: #fef2f2;
  color: #991b1b;
}

.error-title {
  font-weight: 700;
  font-size: 1.1rem;
  margin-bottom: 8px;
}

.btn-retry {
  margin-top: 12px;
  padding: 8px 16px;
  background: #dc2626;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
}

.spinner {
  width: 36px;
  height: 36px;
  border: 3px solid #e2e8f0;
  border-top-color: #2563eb;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
  margin: 0 auto 16px;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 20px;
}

.product-card {
  background: #ffffff;
  border: 1px solid #e2e8f0;
  border-radius: 10px;
  padding: 20px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  transition: transform 0.2s, box-shadow 0.2s;
}

.product-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
}

.card-header {
  display: flex;
  align-items: baseline;
  gap: 8px;
  margin-bottom: 8px;
}

.product-id {
  font-size: 0.8rem;
  font-weight: 700;
  color: #94a3b8;
}

.product-name {
  font-size: 1.15rem;
  color: #0f172a;
  margin: 0;
}

.product-desc {
  font-size: 0.95rem;
  color: #475569;
  line-height: 1.5;
  margin-bottom: 16px;
  flex-grow: 1;
}

.card-footer {
  border-top: 1px solid #f1f5f9;
  padding-top: 12px;
}

.product-price {
  font-size: 1.2rem;
  font-weight: 700;
  color: #16a34a;
}
</style>
