extends Area2D

@export var dialogue : String = "res://dialog/timelines/timeline.dtl"

var over = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr") and !over:
		body.state = body.State.DIALOGUE
		Dialogic.start(dialogue)
		await Dialogic.timeline_ended
		await get_tree().create_timer(1).timeout
		body.state = body.State.NORMAL
		over = true
