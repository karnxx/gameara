extends Button


func _pressed() -> void:
	if GameManager.current_bg != null and GameManager.current_personality != null:
		get_tree().change_scene_to_file("res://scn/lvl/test.tscn")
