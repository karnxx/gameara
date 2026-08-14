extends Node2D


@export var weapon : MagicWeapon

var cd 
var crit
var final_dmg
var swangle
var swing_dur
var kb
var runes

var projtex

var plr

var projectiles = 0

var range

var nodd = false

var spells = [Spell]

func _ready() -> void:
	await get_tree().process_frame
	plr = get_parent().get_parent()
	name = weapon.display_name
	$Sprite2D.texture = weapon.sprite
	projtex = weapon.projectile_tex
	runes = weapon.runes
	range = weapon.a_range
	var noda = Node2D.new()
	noda.name = "noda"
	plr.add_child(noda)
	nodd = true
	plr.spell_slots = weapon.spell_slots
	if get_parent().name == "pivot":
		position.y = -weapon.range

func summon_proj():
	plr.mana -= weapon.mana_cost
	projectiles += 1
	var projec = weapon.projectile_scene.instantiate()
	projec.plr = plr
	plr.get_node("noda").add_child(projec)
	var projs =plr.get_node("noda").get_children()
	var i = 0
	projec.caster = plr
	projec.destory = self
	projec.get_node("Node/Sprite2D").texture = projtex
	for proj in projs:
		proj.rotation = (TAU / projectiles) * i
		proj.get_node("Node").position.x = range
		i += 1

func _process(delta: float) -> void:
	if nodd:
		plr.get_node('noda').rotation += weapon.speed * delta
	if Input.is_action_just_pressed("lmb") and (plr.state != plr.State.DIALOGUE) and plr.state != plr.State.BUSY:
		summon_proj()
	if get_parent().name == "pivot":
		get_parent().rotation = lerp_angle(get_parent().rotation, (get_global_mouse_position() - get_parent().global_position).angle() + PI / 2, 20.0 * delta)
	var dist = get_parent().global_position.distance_to(get_global_mouse_position())
	position = Vector2(0, -min(dist, weapon.range))

func destroy_proj():
	if projectiles != 0:
		projectiles -= 1

func refresh_stat():
	upd_cd()
	upd_crit()
	upd_dmg()

func upd_dmg():
	final_dmg = weapon.damage
	
	final_dmg += plr.dex * scaling_value(weapon.dex_scaling)
	final_dmg += plr.str * scaling_value(weapon.str_scaling)
	final_dmg += plr.intl * scaling_value(weapon.intl_scaling)
	final_dmg += plr.cha * scaling_value(weapon.cha_scaling)
	
	final_dmg += plr.fdmg
	final_dmg *= plr.mdmg

func upd_crit():
	crit = weapon.crit
	crit += plr.fcrit
	crit *= plr.mcrit

func upd_cd():
	cd = weapon.cooldown
	cd -= plr.fcd
	cd *= plr.mcd

func scaling_value(rank: Weapon.ScalingRank) -> float:
	match rank:
		Weapon.ScalingRank.NONE: return 0.0
		Weapon.ScalingRank.D: return 0.25
		Weapon.ScalingRank.C: return 0.5
		Weapon.ScalingRank.B: return 0.75
		Weapon.ScalingRank.A: return 1.0
		Weapon.ScalingRank.S: return 1.5

	return 0.0
