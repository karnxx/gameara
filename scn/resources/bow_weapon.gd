extends Weapon
class_name BowWeapon

@export_group("Bow")

@export
var arrow_scene : PackedScene

@export
var max_draw_time := 1.2

@export
var min_speed := 300.0

@export
var max_speed := 800.0

@export
var gravity := 0.0

@export
var arrow_lifetime := 5.0
