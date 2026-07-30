extends CharacterBody2D

#base stats
var bspd = 230
var bdex = 1.0
var bstr = 1.0
var bintl = 1.0
var bcha = 1.0

#stat mult
var mspd := 1.0
var mdex := 1.0
var mstr := 1.0
var mintl := 1.0
var mcha := 1.0

#stat
var spd
var dex
var str
var intl
var cha

#char creation
enum ClassType {
	KNIGHT, WIZARD
}

var background
var personality
var plr_class = ClassType.KNIGHT
var alignment

var face = "l"


func _ready() -> void:
	apply_class()


func _physics_process(delta: float) -> void:
	movment()
	animate()
	facing()
	move_and_slide()

func facing():
	if velocity.x > 0:
		face = "r"
	elif velocity.x < 0:
		face = "l"

func apply_class():
	mspd = 1.0
	mdex = 1.0
	mstr = 1.0
	mintl = 1.0
	mcha = 1.0

	match plr_class:
		ClassType.KNIGHT:
			mspd += 0.05
			mstr += 2
			mdex += 3

		ClassType.WIZARD:
			mspd -= 0.05
			mdex += 1
			mintl += 4

	apply_stats()

func animate():
	if face == "r":
		$anim.flip_h = false
	elif face == "l":
		$anim.flip_h = true
	if velocity == Vector2.ZERO:
		$anim.play(str(ClassType.keys()[plr_class]) + "_idle")
	else:
		$anim.play(str(ClassType.keys()[plr_class]) + "_run")

func apply_stats():
	spd = mspd * bspd
	str = mstr + bstr
	dex = mdex + bdex
	intl = mintl + bintl
	cha = mcha + bcha

func movment():
	var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if dir != Vector2.ZERO:
		velocity = dir * spd
	else:
		velocity = Vector2.ZERO
