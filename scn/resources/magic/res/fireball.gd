extends Node

var plr

var spelle : Spell

var manacost
var final_dmg
var projspd
var mats

var cd
var crit
var activated = false
var hp = 0

func _ready() -> void:
	plr = get_parent()
	refresh_stat()
	await get_tree().create_timer(0.05).timeout
	projspd = spelle.spd
	manacost = spelle.mana_req
	mats = spelle.materials

func _physics_process(delta: float) -> void:
	pass

func cast(plr):
	activated = true
	var scene = preload("res://scn/resources/magic/res/projectile.tscn").instantiate()
	scene.global_position = plr.get_node("pivot").get_child(0, false).global_position
	scene.spellee = self
	scene.dir = plr.get_global_mouse_position() - plr.global_position
	get_tree().current_scene.get_parent().add_child(scene)
	activated = false

func hit(body):
	upd_dmg()
	body.get_dmged(final_dmg, plr)

func dmg_intercept():
	pass

func refresh_stat():
	if spelle == null:
		return
	upd_cd()
	upd_crit()
	upd_dmg()

func upd_dmg():
	final_dmg = spelle.damage
	
	final_dmg += plr.dex * scaling_value(spelle.dex_scaling)
	final_dmg += plr.str * scaling_value(spelle.str_scaling)
	final_dmg += plr.intl * scaling_value(spelle.intl_scaling)
	final_dmg += plr.cha * scaling_value(spelle.cha_scaling)
	
	final_dmg += plr.fdmg
	final_dmg *= plr.mdmg

func upd_crit():
	crit = spelle.crit
	crit += plr.fcrit
	crit *= plr.mcrit

func upd_cd():
	cd = spelle.cd
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
