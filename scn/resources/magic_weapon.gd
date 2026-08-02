extends Weapon
class_name MagicWeapon

@export_group("Magic")

@export
var projectile_scene : PackedScene

@export
var mana_cost := 10

@export
var cast_time := 0.0

@export
var projectile_speed := 600.0

@export
var projectile_lifetime := 3.0
