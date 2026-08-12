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

enum langs {
	COMMON
}

var languages = [langs.COMMON]


#-100 = Kill on sight
#-50  = Hostile
#0    = Neutral
#20   = Knows you
#50   = Trusted
#100  = Revered
#x = Maybe ruling?

enum faction {
	NONE,
	KINGDOM_OF_ASTERIA,
	ADVENTURERS_LEAGUE,
	MERCHANTS_UNION,
	BLACKSMITHS_CONSORTIUM,
	ARCANE_ACADEMY,
	TRAVELING_PERFORMERS,
	CHURCH_OF_SOLIS,
	ASTERIAN_ARMY,
	BLACK_HAND,
	GREENVALE_HUNTERS
}

var factions = {
	faction.KINGDOM_OF_ASTERIA: 0,
	faction.ADVENTURERS_LEAGUE: 0,
	faction.MERCHANTS_UNION: 0,
	faction.BLACKSMITHS_CONSORTIUM: 0,
	faction.ARCANE_ACADEMY: 0,
	faction.TRAVELING_PERFORMERS: 0,
	faction.CHURCH_OF_SOLIS: 0,
	faction.ASTERIAN_ARMY: 0,
	faction.BLACK_HAND: 0,
	faction.GREENVALE_HUNTERS: 0
}

# =========================
# GAME PLAYER
# =========================

var face = "l"
var maxhp = 1
var hp = 1

var spells = []
var spell_slots = 1
var current_spell
var spellscripts = []

# =========================
# INTERACTIONS
# =========================

enum State {
	NORMAL,
	DIALOGUE,
	DEAD,
	BUSY
}

var state = State.NORMAL

var current_interactable = null

# =========================
# INVENTORY
# =========================

var eq_weapon
var inventory = []
var gold = 0

# =========================
# FUNC
# =========================

func _ready():
	apply_class(ClassType.KNIGHT)
	equip_weapon(preload("uid://x4elk74nncwj"))
	hp = maxhp
	add_spell(preload("uid://cvw6fms070gfk"))

func _physics_process(delta):
	print(state)
	use_spell()
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

func apply_bg(bg):
	background = bg
	match bg:
		BackgroundType.NOBLE:
			gold = 150
			bcha += 2
			bintl += 1
			factions[faction.KINGDOM_OF_ASTERIA] += 20
			#items - fine clothes(can attend parties?), family ring(can use in story)
			#passive - traders +, noble and royalty will talk
		BackgroundType.SOLDIER:
			gold = 60
			bstr += 2
			bdex += 1
			factions[faction.ASTERIAN_ARMY] += 20
			#items - wooden shield(offhand if no 2 hand, often chance of block), wolf teeth necklace ( more dmg),
			#passive - guards trust more.
		BackgroundType.SAGE:
			gold = 40
			bintl += 2
			bcha += 1
			factions[faction.ARCANE_ACADEMY] += 20
			#items - arcane spellbook (spellbook for 2 spells), journal ( u can acc fill and export at end of game)
			#passive - can identify magic obj without interaction
		BackgroundType.ACOLYTE:
			gold = 50
			bintl += 1
			bcha += 2
			factions[faction.CHURCH_OF_SOLIS] += 20
			#items - holy symbol ( can help against undead, can use to like make them not come near), bandages ( to heal)
			#passive - better healing and church dialogue.
		BackgroundType.OUTLANDER:
			gold = 30
			bdex += 2
			bstr += 1
			factions[faction.GREENVALE_HUNTERS] += 20
			#items -  knife( can use to gain better quality meat), rations ( food)
			#passive - tracking animals.
		BackgroundType.CRIMINAL:
			gold = 80
			bdex += 2
			bcha += 1
			factions[faction.BLACK_HAND] += 20
			#items - rusty dagger (type of insta kill?), lockpick ( yk )
			#passive - black market via normal traders who r sus
		BackgroundType.GUILD_ARTISAN:
			gold = 90
			bintl += 2
			bstr += 1
			factions[faction.BLACKSMITHS_CONSORTIUM] += 20
			#items - smiths hammer(can repair at anvils), crafting kit(can craft)
			#passive - crafting and upg cheaper
		BackgroundType.ENTERTAINER:
			gold = 70
			bdex += 1
			bcha += 2
			factions[faction.TRAVELING_PERFORMERS] += 20
			#items - lute ( can play the lute and perform?), costume (attract ppl)
			#passive - persuasion, can earn tips
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

func heal(amount):
	hp = min(hp + amount, maxhp)

func animate():
	$anim.flip_h = (face == "l")
	if velocity == Vector2.ZERO:
		$anim.play(ClassType.keys()[plr_class] + "_idle")
	else:
		$anim.play(ClassType.keys()[plr_class] + "_run")

func movment():
	if state == State.DIALOGUE or state == State.DEAD or state == State.BUSY:
		return
	var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
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
	eq_weapon = scene
	if eq_weapon is MagicWeapon:
		spells = eq_weapon.spells
		spellscripts = []
		for i in get_children():
			if i.is_in_group("spell"):
				i.queue_free()
		for spell in spells:
			var spl : Node = spell.spell.new()
			spl.add_to_group("spell")
			add_child(spl)
			spl.spelle = spell
			spellscripts.append(spl)

func toggleweapon():
	for i in $pivot.get_children():
		i.visible = !i.visible

func add_spell(spell : Spell):
	if eq_weapon.weapon is MagicWeapon:
		if spells.size() >= spell_slots:
			return
		var spl : Node = spell.spell.new()
		spells.append(spell)
		spl.add_to_group("spell")
		add_child(spl)
		spl.spelle = spell
		spellscripts.append(spl)
		current_spell = spell

func sel_spell(i):
	current_spell = spells[i]

func use_spell():
	if Input.is_action_just_pressed("spell"):
		if current_spell == null:
			return
		var i = spells.find(current_spell)
		if i == -1:	
			print(spells)
			return
		print("spell index: ", i)
		print("spells: ", spells.size())
		print("scripts: ", spellscripts.size())
		var spell_script = spellscripts[i]
		spell_script.cast(self)
