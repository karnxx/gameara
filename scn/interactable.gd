extends Area2D


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("interact"):
		get_parent().current_interactable = area.get_parent()

func _on_area_exited(area: Area2D) -> void:
	if area.get_parent().has_method("interact"):
		get_parent().current_interactable = null
