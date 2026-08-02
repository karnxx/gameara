extends Resource
class_name Weapon


@export_group("General")

@export var id : StringName

@export var display_name : String

@export var icon : Texture2D

@export var sprite : Texture2D

@export var scene : PackedScene

@export_group("Stats")

@export var damage := 10
@export var cooldown := 0.4
@export var crit := 0.05

enum ScalingRank {
	NONE,
	D,
	C,
	B,
	A,
	S
}

@export_group("Scaling")

@export var str_scaling : ScalingRank = ScalingRank.NONE
@export var dex_scaling : ScalingRank = ScalingRank.NONE
@export var intl_scaling : ScalingRank = ScalingRank.NONE
@export var cha_scaling : ScalingRank = ScalingRank.NONE

@export_group("Runes")

@export var runes : Array[Rune]
