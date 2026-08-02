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

var fcd = 0
var fcrit = 0
var fdmg = 0

# =========================
# MULTIPLIERS
# =========================

var mspd = 1.0
var mdex = 1.0
var mstr = 1.0
var mintl = 1.0
var mcha = 1.0

var mcd = 1.0
var mcrit = 1.0
var mdmg = 1.0

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
var maxhp = 1
var hp = 1
var gold

# =========================
# INTERACTIONS
# =========================

enum State {
	NORMAL,
	DIALOGUE,
	DEAD
}

var state = State.NORMAL

var current_interactable = null

# =========================
# INVENTORY
# =========================

var eq_weapon: Weapon
var inventory: Array[Weapon] = []


# =========================
# FUNC
# =========================

func _ready():
	apply_class(ClassType.KNIGHT)
	equip_weapon(preload("uid://bk0ncedqi5pw7"))
	hp = maxhp

func _physics_process(delta):
	interact()
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
	maxhp = round(4 + (str + dex)/2)
	if hp > maxhp:
		hp = maxhp

func get_dmged(dmg, who):
	hp -= dmg
	if hp <= 0:
		get_tree().reload_current_scene()

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
	if Input.is_action_just_pressed("interact"):
		if current_interactable:
			current_interactable.interact(self)

func equip_weapon(weapon : Weapon):
	for i in $pivot.get_children():
		i.queue_free()
	var scene = weapon.scene.instantiate()
	scene.weapon = weapon
	scene.plr = self
	scene.refresh_stat()
	$pivot.add_child(scene) 

func toggleweapon():
	for i in $pivot.get_children():
		i.visible = !i.visible
