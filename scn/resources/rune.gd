extends Resource
class_name Rune

enum Trigger {
	ON_SWING,
	ON_FAST_SWING,
	ON_HIT,
	ON_CRIT,
	ON_KILL,
	ON_BLOCK,
	ON_DRAW,
	ON_RELEASE,
	ON_CAST,
	ON_PROJECTILE_HIT,
	ON_DASH,
	PASSIVE
}

enum Rarity {
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY
}

@export_group("General")

@export var id : StringName
@export var display_name : String
@export_multiline var description : String

@export var icon : Texture2D

@export var rarity : Rarity

@export_group("Trigger")

@export var trigger : Trigger
