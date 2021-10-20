import librosa
from dtw import dtw
from numpy.linalg import norm
import time
import sys

template = "divided/output-%02d.wav"
num = 275

sys.stderr.write("load...\n")
stime = time.time()
wavData = [librosa.load(template % (i + 1)) for i in range(num)]
sys.stderr.write("took " + str(time.time() - stime) + " sec.\n")

sys.stderr.write("mfcc...\n")
stime = time.time()
mfcc = [librosa.feature.mfcc(d[0], d[1]) for d in wavData]
sys.stderr.write("took " + str(time.time() - stime) + " sec.\n")

sys.stderr.write("dist...\n")
stime = time.time()
dist = [
	[dtw(m1.T, m2.T, dist=lambda x, y : norm(x - y, ord=1))[0] for m2 in mfcc]
for m1 in mfcc]
sys.stderr.write("took " + str(time.time() - stime) + " sec.\n")

for d in dist:
	print("\t".join([str(e) for e in d]))
