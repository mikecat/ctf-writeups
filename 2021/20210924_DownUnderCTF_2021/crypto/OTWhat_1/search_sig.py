e = 0x010001
n = 0x009d8da2604cece99b25c4c964f34ca87dcac8f6e6165c53afbcb22ba4208112975b42168f62d478e5bad8c2d152f2597d14bb0f251501d62465d13977941e46f16de8bd413af432479dbc578cf2084eade035ab82d6d372abeca767b2fdb4cbe7cde5889301174b6e9c151e530e6bd0efb5f88f50ebac3cae1cf1dc4be252d59224b5367813410e15f639151d8535de5f7cb69c53da38d3408af874fc98bfe43455378e7a517383548eb5824e4cae96e9aa9f9383bbe23d68999a3919c06060bc99bee0971f522224d54fc453a07ba998c688242e58f750520a6005375df693dd78949274d75281d4819012b51ed78340d570b406280c3c77cedbda0230e970d509a1836ba383c20fa844032c1a8cb6ae815f32abbdca8757e07719ba99fb54d50892c35fc3cdcd46c5435551f501e56f65267fdb635a625921fbbe8ba96d7e76f5805bc97c7b367699fc594b28eb8bae18e505c370273ea3204a8193e6431a44899d55865fc744f601d637bc729fa0d0c056505394737dedcd1f84c46dcf6937a5bbc7c3d3d1f491827a29835d5d1a7acfb489b4da18f1de81f8f73f33833817c3746759fa34af713280b32cc104e4cbc5a58230d6286aeade77c72395e7ba1f15c71e98cd8451dbc4d62710c6f4f6112cbf7f1ab4e61e8dd5e153f7909523d30b1934d2c3aea941218d96b7bc54849128d8e1e4c61dc5dcf58bbf92fa565229

v = 2

while True:
	t = pow(v, e, n)
	#if ((t >> (8 * 63)) & 0xff) == 0:
	#if ((t >> (8 * (512 - 64))) & 0xff) == 0:
	if ((t >> (8 * 63)) & 0xff) == 0 and ((t >> (8 * (512 - 64))) & 0xff) == 0:
		print(v)
		break
	v += 1
	if v % 10000 == 0:
		print("searching... " + str(v))
