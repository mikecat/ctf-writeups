package main
import (
	"fmt"
	"math/rand"
	"encoding/hex"
)

func main() {
	for l := 0; l < 0x2000000; l += 0x1000000 {
		for k := 0; k < 0x1000; k++ {
			rand.Seed(int64(l + k));
			for i := 0; i < rand.Intn(32); i++ {
				rand.Seed(rand.Int63())
			}

			var key []byte
			var iv []byte

			for i := 0; i < 32; i++ {
				key = append(key, byte(rand.Intn(255)))
			}

			for i := 0; i < aes.BlockSize; i++ {
				iv = append(iv, byte(rand.Intn(255)))
			}

			fmt.Println(hex.EncodeToString(key) + " " + hex.EncodeToString(iv))
		}
	}
}
