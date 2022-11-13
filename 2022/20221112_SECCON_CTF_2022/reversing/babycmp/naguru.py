import angr
import claripy

p = angr.Project("./data/chall.baby", load_options={"auto_load_libs":False})

arg = claripy.BVS('arg', 32*0x20)

success_addrs = [0x4012cc]
incorrect_addrs = [0x40127d]

state = p.factory.entry_state(args=["./data/chall.baby", arg])
pg = p.factory.simulation_manager(state)

e = pg.explore(find=tuple(success_addrs), avoid=tuple(incorrect_addrs))

if len(e.found) > 0:
	# s = e.found[0].state
	s = e.found[0]
	print("%r" % s.posix.dumps(0))
	print("argv[1] = {!r}".format(s.solver.eval(arg, cast_to=bytes)))
