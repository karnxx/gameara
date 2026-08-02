extends CharacterBody2D

@export var dialogue : String

var plr = false


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group('plr'):
		plr = true
		$inter.visible = true

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.is_in_group('plr'):
		plr = false
		$inter.visible = false

func interact(plr):
	plr.state = plr.State.DIALOGUE
	Dialogic.start("res://dialog/timelines/timeline.dtl")
	await Dialogic.timeline_ended
	plr.state = plr.State.NORMAL
