class_name B4vm extends Object
# b4 vm for godot

var ip = 0
var ds = []
var rs = []
var mem = PoolByteArray()
var xx = 0
var zz = 0
var yy = 0
const ENDM = 65536

func _init():
	mem.resize(ENDM)

func inc3():
	ip += 3; return ip-3
func dtos(): return ds[-1]
func dput(x:int): ds.push_back(x)
func dbit(x:bool): ds.push_back(-1 if x else 0)
func dpop()->int: return ds.pop_back()
func dswp():
	var t = dpop(); var n = dpop()
	dput(t); dput(n)
func dpon()->int: # pop nos, for things like sb,dv,md, etc
	dswp(); return dpop()
func rput(x:int): rs.push_back(x)
func rpop()->int: return rs.pop_back()
func mget(a)->int: # get little endian int
	return mem[a] ^ (mem[a+1] << 8) ^ (mem[a+2] << 16) ^ (mem[a+3] << 24)
func mput(a,x:int): # put little endian int
	mem[a  ] = (x & 0x000000ff)
	mem[a+1] = (x & 0x0000ff00) >> 8
	mem[a+2] = (x & 0x00ff0000) >> 16
	mem[a+3] = (x & 0xff000000) >> 24
func xinc(): xx+=1
func yinc(): yy+=1
func zinc(): zz+=1

const MIN_OP = 0x80
enum B4Op {
	SI = MIN_OP, LI, SW, DU, OV, ZP, DR, RD,
	AD, SB, ML, DV, MD, NG, SL, SR,
	AN, OR, XR, NT, EQ, NE, GT, LT, GE, LE,
	HL, JM, HP, H0, J0, CL, RT, R0, EV,
	RM, WM, RB, WB,
	YR, ZW, WP, RP, QP,
	DX, XD, DY, YD, DZ, ZD, DC, CD,
	BW, GO,
	NONE }
const MAX_OP = B4Op.NONE-1
	
func SI(): dput(mem[++ip])
func LI(): dput(mget(inc3()))
func SW(): dswp()
func DU(): dput(ds[-1])
func OV(): dput(ds[-2])
func ZP(): dpop()
func DR(): rput(dpop())
func RD(): dput(rpop())
func AD(): dput(dpop()+dpop())
func SB(): dput(dpon()-dpop())
func ML(): dput(dpop()*dpop())
func DV(): dput(dpon()/dpop())
func MD(): dput(dpon()%dpop())
func NG(): dput(-dpop())
func SL(): dput(dpon()<<dpop())
func SR(): dput(dpon()>>dpop())
func AN(): dput(dpop()&dpop())
func OR(): dput(dpop()|dpop())
func XR(): dput(dpop()^dpop())
func NT(): dput(~dpop())
func EQ(): dbit(dpop()==dpop())
func NE(): dbit(dpop()!=dpop())
func GT(): dbit(dpon()>dpop())
func LT(): dbit(dpon()<dpop())
func GE(): dbit(dpon()>=dpop())
func LE(): dbit(dpon()<=dpop())
func HL(): ip=ENDM
func JM(): ip=mget(inc3())-1
func HP(): ip+=mem[++ip]-1
func H0():
	if dpop()==0: HP()
func J0():
	if dpop()==0: JM()
func CL():
	rput(ip); JM()
func RT(): ip=rpop()-1
func R0():
	if dtos()==0:
		dpop(); RT()
func EV():
  rput(ip); ip=dpop()
func RM(): dput(mget(dpop()))
func WM(): mput(dpop(), dpop())
func RB(): dput(mem[dpop()])
func WB(): mem[dpop()]=dpop()&0xff
func YR(): dput(mem[yinc()]&0xff)
func ZW(): mem[zinc()]=0xff&dpop()
func WP(): pass
func RP(): pass
func QP(): pass
func XD(): dput(xx)
func YD(): dput(yy)
func ZD(): dput(zz)
func DX(): xx=dpop()
func DY(): yy=dpop()
func DZ(): zz=dpop()
func DC(): pass # dpop cset AND@CMASK@dpop
func CD(): pass # dput@cget@AND@CMASK@dpop
func BW(): pass # bw =: skpy@1@(pget cset AND@CMASK@bget@incp)
func GO(): pass # skpy=0

func step():
	match mem[ip]:
		0x00 - 0x1F: pass
		0x20 - 0x7F: pass
		B4Op.SI: SI()
		B4Op.LI: LI()
		B4Op.SW: SW()
		B4Op.DU: DU()
		B4Op.OV: OV()
		B4Op.ZP: ZP()
		B4Op.DR: DR()
		B4Op.RD: RD()
		B4Op.AD: AD()
		B4Op.SB: SB()
		B4Op.ML: ML()
		B4Op.DV: DV()
		B4Op.MD: MD()
		B4Op.NG: NG()
		B4Op.SL: SL()
		B4Op.SR: SR()
		B4Op.AN: AN()
		B4Op.OR: OR()
		B4Op.XR: XR()
		B4Op.NT: NT()
		B4Op.EQ: EQ()
		B4Op.NE: NE()
		B4Op.GT: GT()
		B4Op.LT: LT()
		B4Op.GE: GE()
		B4Op.LE: LE()
		B4Op.HL: HL()
		B4Op.JM: JM()
		B4Op.HP: HP()
		B4Op.H0: H0()
		B4Op.J0: J0()
		B4Op.CL: CL()
		B4Op.RT: RT()
		B4Op.R0: R0()
		B4Op.EV: EV()
		B4Op.RM: RM()
		B4Op.WM: WM()
		B4Op.YR: YR()
		B4Op.ZW: ZW()
		B4Op.WP: WP()
		B4Op.RP: RP()
		B4Op.QP: QP()
		B4Op.DX: DX()
		B4Op.XD: XD()
		B4Op.DY: DY()
		B4Op.YD: YD()
		B4Op.DZ: DZ()
		B4Op.ZD: ZD()
		B4Op.DC: DC()
		B4Op.CD: CD()
		B4Op.BW: BW()
		B4Op.GO: GO()
		_: printerr('invalid opcode:', mem[ip])
	ip += 1

func _ready():
	pass # Replace with function body.
