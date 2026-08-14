extends VBoxContainer


func _on_button_pressed(index: int) -> void:
	print(index)
	GameManager.save_personality(index)
