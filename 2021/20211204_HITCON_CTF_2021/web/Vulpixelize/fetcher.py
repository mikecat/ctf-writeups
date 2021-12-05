import sys
import cv2
import numpy
import urllib.request
import urllib.parse

def geturl(url):
	with urllib.request.urlopen(url) as handle:
		return handle.read()

if len(sys.argv) < 4:
	import os
	filename = os.path.basename(__file__)
	sys.stderr.write("Usage: python" + filename + " target_url_prefix display_url_prefix out_image\n")
	sys.exit(1)

target_url_prefix = sys.argv[1]
display_url_prefix = sys.argv[2]
out_image = sys.argv[3]

start_xpos = 10800
end_xpos = 35500
delta_xpos = 1920

image_key = '<a target="_blank" href="'

images = []

for xpos in range(start_xpos, end_xpos + delta_xpos, delta_xpos):
	sys.stderr.write("fetching " + str(xpos) + "\n")
	displayUrl = display_url_prefix + "?xpos=" + str(xpos)
	htmlData = geturl(target_url_prefix + "submit?url=" + urllib.parse.quote(displayUrl)).decode("UTF-8")
	keyPos = htmlData.index(image_key)
	imageStartPos = keyPos + len(image_key)
	imageEndPos = htmlData.index('"', imageStartPos)
	imagePath = htmlData[imageStartPos:imageEndPos]
	imageData = geturl(target_url_prefix + imagePath)
	imageArray = numpy.frombuffer(imageData, dtype=numpy.uint8)
	imageDecoded = cv2.imdecode(imageArray, cv2.IMREAD_UNCHANGED)
	imageResized = cv2.resize(imageDecoded, dsize=(imageDecoded.shape[1] // 16, imageDecoded.shape[0] // 16), interpolation=cv2.INTER_NEAREST)
	images.append(imageResized)

sys.stderr.write("done!\n")

imageConcatenated = cv2.hconcat(images)
cv2.imwrite(out_image, imageConcatenated)
