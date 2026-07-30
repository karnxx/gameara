extends CharacterBody2D

# =========================
# BASE STATS
# =========================

var bspd = 230
var bdex = 10
var bstr = 10
var bintl = 10
var bcha = 10

# =========================
# FLAT BONUSES
# =========================

var fspd = 0
var fdex = 0
var fstr = 0
var fintl = 0
var fcha = 0

# =========================
# MULTIPLIERS
# =========================

var mspd = 1.0
var mdex = 1.0
var mstr = 1.0
var mintl = 1.0
var mcha = 1.0

# =========================
# FINAL STATS
# =========================

var spd
var dex
var str
var intl
var cha

# =========================
# CHARACTER CREATION
# =========================

enum ClassType {
	KNIGHT,
	WIZARD
}

var plr_class = ClassType.KNIGHT

enum BackgroundType {
	NOBLE,
	SOLDIER,
	SAGE,
	ACOLYTE,
	OUTLANDER,
	CRIMINAL,
	GUILD_ARTISAN,
	ENTERTAINER,
}

var background

enum PersonalityType {
	BRAVE,
	ANALYTICAL,
	DECEITFUL,
	COMPASSIONATE,
	HOTHEADED,
	DISCIPLINED,
	CUNNING,
	CURIOUS
}

var personality

enum AlignmentType {
	LAWFUL_GOOD,
	NEUTRAL_GOOD,
	CHAOTIC_GOOD,
	LAWFUL_NEUTRAL,
	TRUE_NEUTRAL,
	CHAOTIC_NEUTRAL,
	LAWFUL_EVIL,
	NEUTRAL_EVIL,
	CHAOTIC_EVIL
}

var alignment 


# =========================
# GAME PLAYER
# =========================

var face = "l"

# =========================
# INTERACTIONS
# =========================

func _ready():
	apply_class(ClassType.KNIGHT)

func _physics_process(delta):
	movment()
	facing()
	animate()
	move_and_slide()

func facing():
	if velocity.x > 0:
		face = "r"
	elif velocity.x < 0:
		face = "l"

func apply_class(classs):
	plr_class = classs
	fspd = 0
	fdex = 0
	fstr = 0
	fintl = 0
	fcha = 0
	mspd = 1.0
	mdex = 1.0
	mstr = 1.0
	mintl = 1.0
	mcha = 1.0
	match plr_class:
		ClassType.KNIGHT:
			fstr += 4
			fdex += 2
		ClassType.WIZARD:
			fintl += 5
			fdex += 1
	apply_stats()


func apply_stats():
	spd = roundi((bspd + fspd) * mspd)
	str = roundi((bstr + fstr) * mstr)
	dex = roundi((bdex + fdex) * mdex)
	intl = roundi((bintl + fintl) * mintl)
	cha = roundi((bcha + fcha) * mcha)

func animate():
	$anim.flip_h = (face == "l")
	if velocity == Vector2.ZERO:
		$anim.play(ClassType.keys()[plr_class] + "_idle")
	else:
		$anim.play(ClassType.keys()[plr_class] + "_run")


func movment():
	var dir = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)
	if dir != Vector2.ZERO:
		velocity = dir * spd
	else:
		velocity = Vector2.ZERO

func interact():
	pass
