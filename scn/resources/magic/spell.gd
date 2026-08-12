extends Resource
class_name Spell

enum type {
	SELF,
	MOUSE,
	DIRECTION,
	TARGET,
	AREA
}

enum spltyp {
	PROJECTILE,
	BEAM,
	AOE,
	BUFF,
	SUMMON,
	TRAP
}

enum element {
	PHYSICAL,
	FIRE,
	ICE,
	LIGHTNING,
	WIND,
	EARTH,
	HOLY,
	DARK,
	ARCANE,
	POISON
}

@export var name : String

@export var splid : StringName

@export var cast_type : type

@export var spl_type : spltyp

@export var splelement : element

@export var mana_req : int

@export var damage : float

@export var cd : float

@export var materials : Array

@export var icon : Texture2D

@export var runes : Array

@export var spd : int

@export var spell : Script

@export var str_scaling : Weapon.ScalingRank
@export var dex_scaling : Weapon.ScalingRank
@export var intl_scaling : Weapon.ScalingRank
@export var cha_scaling : Weapon.ScalingRank
