import sys
import hashlib
import subprocess

if (len(sys.argv) < 3) or (6 < len(sys.argv)):
	sys.stderr.write("Usage: python get_S.py prefix target_length [process_num [this_process size]]\n")
	sys.exit(1)

prefix_str = sys.argv[1]
target_length = int(sys.argv[2], 0)
size_arg = -1 if len(sys.argv) < 6 else int(sys.argv[5], 0)

if len(sys.argv) == 3:
	process_num = 1
	this_process = 0
elif len(sys.argv) == 4:
	process_num = int(sys.argv[3], 0)
	this_process = -1
else:
	process_num = int(sys.argv[3], 0)
	this_process = int(sys.argv[4], 0)

prefix = bytes([int(prefix_str[i:i+2], 16) for i in range(0, len(prefix_str), 2)])

target_suffix = b"\x00" * (target_length // 8)
target_mask_pos = -len(target_suffix) - 1
target_mask = 0xff >> (8 - target_length % 8)

size = 1 if size_arg < 0 else size_arg
while True:
	all = 1 << (8 * size)
	if this_process < 0:
		command = [sys.executable] + sys.argv[:4]
		proc = [subprocess.Popen(command + [str(i), str(size)], stdin=subprocess.DEVNULL, stdout=subprocess.PIPE) for i in range(process_num)]
		while len(proc) > 0:
			for i in range(len(proc)):
				if proc[i].poll() is not None:
					ret = proc[i].stdout.readline()
					proc = proc[:i] + proc[i+1:]
					if len(ret) > 0:
						print(ret.rstrip().decode())
						for p in proc:
							p.terminate()
						sys.exit(0)
					break
	else:
		for c in range(all * this_process // process_num, all * (this_process + 1) // process_num):
			answer = c.to_bytes(size, "little")
			data = prefix + answer
			hash = hashlib.sha256(data).digest()
			if hash.endswith(target_suffix) and ((hash[target_mask_pos] & target_mask) == 0):
				print("".join(["%02x" % e for e in answer]))
				sys.exit(0)
	if size_arg >= 0:
		sys.exit(0)
	size += 1
