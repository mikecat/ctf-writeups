import cv2

folder = "challenge_frames"
folder_out = "merged"
start = 1
end = 120
mod = 10

data = [[] for i in range(mod)]

for i in range(start, end + 1):
	img = cv2.imread("%s/%03d.png" % (folder, i))
	data[i % mod].append(img)

for i in range(mod):
	merged = cv2.vconcat(data[i])
	cv2.imwrite("%s/%03d.png" % (folder_out, i), merged)
