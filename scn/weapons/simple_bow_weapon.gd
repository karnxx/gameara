extends Node2D

@export var weapon : BowWeapon 
@export var rot := true

var cd 
var crit
var final_dmg

var plr
var runes

var arrow_life
var min_arrow_spd
var max_arrow_spd
var max_draw
var states = 0

var arrow

var dragdist

var drawing = false
var start
var current
var arrowlod = true

func _ready() -> void:
	await get_tree().process_frame
	plr = get_parent().get_parent()
	name = weapon.display_name
	$Sprite2D.texture = weapon.sprite
	runes = weapon.runes
	arrow_life = weapon.arrow_lifetime
	min_arrow_spd = weapon.min_speed
	max_arrow_spd = weapon.max_speed
	max_draw = weapon.max_draw_time
	arrow = weapon.arrow_scene
	if get_parent().name == "pivot":
		position.y = -weapon.range
	dragdist = max_draw * 60

func _process(delta: float) -> void:
	if get_parent().name == "pivot" and rot:
		get_parent().rotation = lerp_angle(get_parent().rotation, (get_global_mouse_position() - get_parent().global_position).angle() + PI / 2, 20.0 * delta)
	$Sprite2D.frame = states
	$basic_arrow.position.x = lerpf(6.0, 1.0, states / 4.0)
	if plr.state != plr.State.DIALOGUE or plr.state != plr.State.BUSY:
		draw()

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

func draw():
	if !arrowlod or plr.state == plr.State.DIALOGUE:
		return
	if Input.is_action_just_pressed("lmb"):
		drawing = true
		rot = false
		start = get_global_mouse_position()
	if drawing:
		current = get_global_mouse_position()
		var dist = start.distance_to(current)
		states = clamp(floori(dist / 5.0), 0, 4)
	if drawing and Input.is_action_just_released("lmb"):
		var ara = arrow.instantiate()
		ara.global_position = $start.global_position
		ara.rotation = ($end.global_position - $start.global_position).angle() + PI/2
		ara.dir = ($end.global_position - $start.global_position).normalized()
		ara.spd = clamp(states * 200,min_arrow_spd, max_arrow_spd)
		ara.dmger = plr
		if states != 0:
			arrowlod = false
			get_tree().current_scene.add_child(ara)
		drawing = false
		rot = true
		$basic_arrow.visible = false
		states = 0
		get_tree().create_timer(cd).timeout.connect(cdover)

func cdover():
	$basic_arrow.visible = true
	arrowlod = true
