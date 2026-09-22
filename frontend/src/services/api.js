/**
 * Fetch products from Laravel backend API.
 * @param {string} [baseUrl]
 * @returns {Promise<Array>}
 */
export async function getProducts(baseUrl = import.meta.env?.VITE_API_URL || 'http://localhost:8000/api') {
  const response = await fetch(`${baseUrl}/products`)
  if (!response.ok) {
    throw new Error(`Gagal memuat produk (HTTP ${response.status})`)
  }
  return await response.json()
}
