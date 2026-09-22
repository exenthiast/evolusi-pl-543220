import { describe, it, expect } from 'vitest'
import { formatPrice, truncateText } from './formatters.js'

describe('formatters', () => {
  describe('formatPrice', () => {
    it('mengubah angka menjadi format mata uang Rupiah', () => {
      const formatted = formatPrice(18500000)
      expect(formatted).toContain('18.500.000')
      expect(formatted).toContain('Rp')
    })

    it('mendukung input berupa string numerik', () => {
      const formatted = formatPrice('850000')
      expect(formatted).toContain('850.000')
      expect(formatted).toContain('Rp')
    })

    it('mengembalikan "Rp 0" jika nilai bukan angka valid', () => {
      expect(formatPrice('bukan-angka')).toBe('Rp 0')
      expect(formatPrice(undefined)).toBe('Rp 0')
    })
  })

  describe('truncateText', () => {
    it('memotong teks jika melebihi panjang maksimum', () => {
      const text = 'Laptop gaming bertenaga tinggi untuk tugas berat dan multimedia.'
      const truncated = truncateText(text, 20)
      expect(truncated).toBe('Laptop gaming berten...')
    })

    it('tidak memotong teks jika panjang di bawah maksimum', () => {
      const text = 'Teks Pendek'
      expect(truncateText(text, 20)).toBe('Teks Pendek')
    })

    it('menangani string kosong atau null', () => {
      expect(truncateText('')).toBe('')
      expect(truncateText(null)).toBe('')
    })
  })
})
