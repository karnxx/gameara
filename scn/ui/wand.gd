extends TextureButton


func _pressed() -> void:
	GameManager.save_class(1)
	GameManager.save_weapon(preload("uid://x4elk74nncwj"))
	get_tree().change_scene_to_file("res://scn/ui/bgandpersonalitychoose.tscn")
