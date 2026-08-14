extends TextureButton


func _pressed() -> void:
	GameManager.save_class(0)
	GameManager.save_weapon(preload("uid://bk0ncedqi5pw7"))
	get_tree().change_scene_to_file("res://scn/ui/bgandpersonalitychoose.tscn")
