import sys
import cv2
import numpy

if len(sys.argv) < 3:
	print("Usage: python gyaku.py input_img output_img")
	sys.exit(1)

inputImg = cv2.imread(sys.argv[1], cv2.IMREAD_GRAYSCALE)
if inputImg is None:
	printf("failed to read input")
	sys.exit(1)

width = inputImg.shape[1]
height = inputImg.shape[0]

result = [[0 for x in range(width)] for y in range(height)]
count = [[0 for x in range(width)] for y in range(height)]

ROUNDS = 32

for j in range(height):
	for i in range(width):
		di, dj = 1337, 42
		for k in range(ROUNDS):
			di, dj = (di * di + dj) % width, (dj * dj + di) % height
			y = (j + dj + (i + di) // width) % height
			x = (i + di) % width
			result[y][x] += inputImg[j][i]
			count[y][x] += 1

resImg = numpy.zeros((height, width), dtype = numpy.uint8)
for y in range(height):
	for x in range(width):
		resImg[y][x] = result[y][x] // (count[y][x] if count[y][x] > 0 else 1)
cv2.imwrite(sys.argv[2], resImg)
