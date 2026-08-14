extends Button

func _on_mouse_entered() -> void:
	get_parent().get_node("ColorRect/knight").visible = true
	var twen = create_tween()
	twen.tween_property(get_parent().get_node("knight2"), "global_position", Vector2(321,336), 0.5 ).set_trans(Tween.TRANS_QUAD)
	twen.tween_property(get_parent().get_node('knight3'),"global_position", Vector2(2,0), 0.2).set_trans(Tween.TRANS_CIRC)

func _on_mouse_exited() -> void:
	get_parent().get_node("ColorRect/knight").visible = false
	var twen = create_tween()
	twen.tween_property(get_parent().get_node("knight2"), "global_position", Vector2(321,360), 0.5 ).set_trans(Tween.TRANS_BOUNCE)
	twen.tween_property(get_parent().get_node('knight3'),"global_position", Vector2(-270,0), 0.2).set_trans(Tween.TRANS_CIRC)
