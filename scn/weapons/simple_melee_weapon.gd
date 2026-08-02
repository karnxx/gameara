extends Node2D

@export var weapon : MeleeWeapon
@export var rot := true

var cd 
var crit
var final_dmg
var swangle
var swing_dur
var kb

var plr
var runes

func _ready() -> void:
	await get_tree().process_frame
	plr = get_parent().get_parent()
	name = weapon.display_name
	$Sprite2D.texture = weapon.sprite
	for i in range(weapon.collision_shapes.size()):
		var cola = CollisionShape2D.new()
		cola.shape = RectangleShape2D.new()
		cola.shape.size = weapon.collision_shapes[i]
		cola.position = weapon.collision_shapes_pos[i]
		$Area2D.add_child(cola)
	runes = weapon.runes
	kb = weapon.knockback
	if get_parent().name == "pivot":
		position.y = -weapon.range

func refresh_stat():
	upd_cd()
	upd_crit()
	upd_dmg()

func _process(delta: float) -> void:
	if get_parent().name == "pivot" and rot:
		get_parent().rotation = lerp_angle(get_parent().rotation, (get_global_mouse_position() - get_parent().global_position).angle() + PI / 2, 20.0 * delta)

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

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("hittable"):
		body.get_dmged(final_dmg, plr)
