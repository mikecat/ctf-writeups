x = open("flag.txt").read()
cnt = 0
l = len(x)

def f(a,b):
  global cnt
  cnt += 1
  if cnt > l - 30: return -1337
  return a + b
