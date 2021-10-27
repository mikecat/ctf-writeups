const ciphertext = [234, 240, 234, 252, 214, 236, 140, 247, 173, 191, 158, 132, 56, 4, 32, 73, 235, 193, 233, 152, 125, 19, 19, 237, 186, 131, 98, 52, 186, 143, 127, 43, 226, 233, 126, 15, 225, 171, 85, 55, 173, 123, 21, 147, 97, 21, 237, 11, 254, 129, 2, 131, 101, 63, 149, 61]
const plaintext = ciphertext.map((x, i) => ((i * i) % 256) ^ x ^ 0x99)
const flagElement = document.createElement("span")
plaintext.map((x, i) => {
  const span = document.createElement('span')
  span.classList.add(`flag-char-${i}`)
  span.textContent = String.fromCharCode(x)
  flagElement.appendChild(span)
  return span
})
console.log(flagElement)
console.log(flagElement.textContent)
