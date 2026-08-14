extends Node

var current_class = 0
var current_bg = 0
var current_personality = 0
var weapon

var plr

func plrstantiate(lpar):
	plr = lpar

func save_class(class_type):
	current_class = class_type

func save_weapon(weapon_path):
	weapon = weapon_path

func save_bg(bg_type):
	current_bg = bg_type

func save_personality(personality_type):
	current_personality = personality_type

func apply_to_plr():
	plr.apply_class(current_class)
	plr.apply_bg(current_bg)
	plr.equip_weapon(weapon)
	plr.hp = plr.maxhp
	if current_class == 1:
		plr.add_spell(preload("uid://cvw6fms070gfk"))
		pass
