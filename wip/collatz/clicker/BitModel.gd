extends Node

# the value as a 64 (32?) bit integer
export var as_int: int = 1

# the value as an array of bits
# bits[i] corresponds to the 2^i bit.
# (e.g., value="8" corresponds to bits=[0,0,0,1])
export var bits:Array = [1]

signal changed(bits, as_int)


# Called when the node enters the scene tree for the first time.
func _ready():
	notify()

func notify():
	var value = 0
	for i in range(len(bits)):
		if bits[i]: value += 1<<i
	as_int = value
	emit_signal("changed", bits, as_int)


func inc():
	"""Increment the value by 1"""
	for i in range(len(bits)):
		bits[i] = 1-bits[i]
		if bits[i] == 1: break
	notify()
	
func div2():
	"""divide by 2"""
	if len(bits): bits.pop_front()
	# this isn't an "else". len(bits) has changed.
	if not len(bits): bits = [1]
	notify()

func mul3(carry_in=0):
	"""multiply by 3 (and add 1 if carry_in==1)"""
	var carry = carry_in
	var shift = 0
	# x*3 == x*2+x == x<<1+x
	bits.push_back(0) # placeholder for final carry
	for i in range(len(bits)):
		var sum = bits[i] + shift + carry
		shift = bits[i]
		bits[i] = sum & 1
		carry = 1 if sum > 1 else 0
	if carry:
		bits.push_back(1)
	notify()

func collatz_step():
	if bits[0]: mul3(1)  # if odd: x'=3x+1
	else: div2()


func _on_btn_step_pressed():
	collatz_step()

func _on_BitView_int_changed(value):
	bits = []
	while value > 0:
		bits.push_back(value&1)
		value >>= 1
	notify()


func _on_BitView_bit_changed(i):
	while i > len(bits)-1: bits.push_back(0)
	bits[i]=1-bits[i]
	notify()
