import { describe, it, expect, vi, beforeEach } from 'vitest'
import { getProducts } from './api.js'

describe('api service', () => {
  beforeEach(() => {
    vi.restoreAllMocks()
  })

  it('berhasil mengambil data produk tanpa server backend aktif (mock fetch)', async () => {
    const mockProducts = [
      { id: 1, name: 'Laptop ASUS ROG', price: 18500000 },
      { id: 2, name: 'Mechanical Keyboard RGB', price: 850000 },
    ]

    global.fetch = vi.fn().mockResolvedValue({
      ok: true,
      status: 200,
      json: async () => mockProducts,
    })

    const products = await getProducts('http://localhost:8000/api')

    expect(global.fetch).toHaveBeenCalledWith('http://localhost:8000/api/products')
    expect(products).toHaveLength(2)
    expect(products[0].name).toBe('Laptop ASUS ROG')
  })

  it('melempar error jika respon API gagal (status HTTP error)', async () => {
    global.fetch = vi.fn().mockResolvedValue({
      ok: false,
      status: 500,
    })

    await expect(getProducts('http://localhost:8000/api')).rejects.toThrow(
      'Gagal memuat produk (HTTP 500)'
    )
  })
})
