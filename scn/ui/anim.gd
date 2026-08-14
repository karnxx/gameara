extends AnimatedSprite2D


func _process(delta: float) -> void:
	if (get_global_mouse_position().x - global_position.x) > 0:
		flip_h = false
	elif (get_global_mouse_position().x - global_position.x) < 0:
		flip_h = true

func _ready() -> void:
	if GameManager.current_class == 0:
		play("KNIGHT_idle")
	elif GameManager.current_class == 1:
		play("WIZARD_idle")
