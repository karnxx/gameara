extends Weapon
class_name MagicWeapon

@export_group("Magic")

@export
var projectile_scene : PackedScene

@export
var projectile_tex : Texture2D

@export
var mana_cost := 10

@export
var a_range := 600.0

@export
var range := 22

@export
var speed := 600.0

@export
var spell_slots := 2
