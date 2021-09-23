x = open("flag.txt").read()

def f(a,b):
  if x[0:7] == "corctf{" and x[-2:] == "}\n": return -1337
  return a + b
