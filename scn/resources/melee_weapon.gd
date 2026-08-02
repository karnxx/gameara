extends Weapon
class_name MeleeWeapon

@export_group("Swing")

@export_range(10, 360)
var swing_angle := 120.0

@export
var swing_duration := 0.18

@export
var range := 22

@export
var swing_radius := 28.0

@export
var combo_count := 1

@export
var knockback := 100.0

@export
var collision_shapes : Array[Vector2]

@export
var collision_shapes_pos : Array[Vector2]
