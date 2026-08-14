extends Button

func _on_mouse_entered() -> void:
	get_parent().get_node("ColorRect/wiz").visible = true
	var twen = create_tween()
	twen.tween_property(get_parent().get_node("wizard2"), "global_position", Vector2(818,336), 0.5 ).set_trans(Tween.TRANS_QUAD)
	twen.tween_property(get_parent().get_node('wizard3'),"global_position", Vector2(881,0), 0.2).set_trans(Tween.TRANS_SINE)

func _on_mouse_exited() -> void:
	get_parent().get_node("ColorRect/wiz").visible = false
	var twen = create_tween()
	twen.tween_property(get_parent().get_node("wizard2"), "global_position", Vector2(818,360), 0.5 ).set_trans(Tween.TRANS_BOUNCE)
	twen.tween_property(get_parent().get_node('wizard3'),"global_position", Vector2(1154,0), 0.2).set_trans(Tween.TRANS_CIRC)
