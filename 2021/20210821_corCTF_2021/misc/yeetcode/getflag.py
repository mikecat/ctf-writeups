pos = 7
x = (ord(open("flag.txt").read()[pos]) - 0x20) % 10
cnt = 0

def f(a,b):
  global cnt
  cnt += 1
  if cnt > x: return -1337
  return a + b
