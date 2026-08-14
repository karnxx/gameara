extends AnimatedSprite2D

func _process(delta: float) -> void:
	frame = get_parent().get_parent().get_parent().get_node("anim").frame
	animation = get_parent().get_parent().get_parent().get_node("anim").animation
