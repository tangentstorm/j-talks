extends Node2D

const gw = 64
const gh = 32

var size : int
var mem : PackedInt32Array

const NULL = -1
const HEAP = 0 # start address of heap
const CELL = 4 # size of cells

# fields in the "struct"
const NEXT = 0
const SIZE = 1 * CELL
const USED = 2 * CELL
const DATA = 3 * CELL

const WORTH_SPLITTING = 10

func _ready():
	$ColorGrid.grid_size = Vector2(gw,gh)
	size = gw * gh
	mem = PackedInt32Array([]); mem.resize(size)
	$ColorGrid.data.resize(size)
	mem[NEXT] = NULL # start of chain
	mem[SIZE] = size - DATA
	mem[USED] = 0 # unallocated

	var a = alloc(3)
	var b = alloc(7)
	var c = alloc(28)
	var d = []
	for i in range(32):
		d.push_back(alloc(1+randi()%63))
	mfree(b)
	render()

const FREE_COLOR = 1 # gray
const HEAD_COLOR = 0 # black
const USED_COLOR = 10 # white

# updates the values checked the ColorGrid
func render():
	var d = $ColorGrid.data
	var p = HEAP
	while true:
		for i in range(p, p+DATA): d[i] = HEAD_COLOR
		for i in range(p+DATA, p+DATA+mem[p+SIZE]): d[i] = FREE_COLOR
		for i in range(p+DATA, p+DATA+mem[p+USED]): d[i] = USED_COLOR
		p = mem[p+NEXT]
		if p == NULL: break
	$ColorGrid.data = d

func alloc(size)->int:
	var p = 0
	var used = size
	size += (4-(size&3))&3 # expand so next block is word-aligned
	# todo : adjust size to be multiple of 4
	while true:
		if mem[p+SIZE] >= size and not mem[p+USED]:
			# we found a usable block, so claim it.
			mem[p+USED] = used
			var remainder = mem[p+SIZE]-size
			if  remainder > WORTH_SPLITTING:
				var old_next = mem[p+NEXT]
				# shrink old block
				mem[p+SIZE] = size
				mem[p+NEXT] = (p+DATA) + size
				# add header for new block
				var q = mem[p+NEXT]
				mem[q+NEXT] = old_next
				mem[q+SIZE] = remainder - DATA
				mem[q+USED] = 0
			else: pass
			return p+DATA
		else:
			p = mem[p+NEXT]
			if p == NULL: return NULL
	return p+DATA

func mfree(p:int):
	p -= DATA
	mem[p+USED] = 0
