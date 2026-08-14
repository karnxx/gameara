extends TextureProgressBar


func set_target(targ):
	var twen = create_tween()
	twen.tween_property(self, "value", targ, 0.5)
