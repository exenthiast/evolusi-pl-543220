/**
 * Format a number or numeric string to Indonesian Rupiah (IDR).
 * @param {number|string} price
 * @returns {string}
 */
export function formatPrice(price) {
  const numericPrice = Number(price)
  if (isNaN(numericPrice)) {
    return 'Rp 0'
  }
  return new Intl.NumberFormat('id-ID', {
    style: 'currency',
    currency: 'IDR',
    minimumFractionDigits: 0,
  }).format(numericPrice)
}

/**
 * Truncate long text with ellipsis.
 * @param {string} text
 * @param {number} maxLength
 * @returns {string}
 */
export function truncateText(text, maxLength = 50) {
  if (!text) return ''
  if (text.length <= maxLength) return text
  return text.slice(0, maxLength) + '...'
}
