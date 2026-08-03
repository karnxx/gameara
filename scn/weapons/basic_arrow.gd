extends CharacterBody2D


var dir = Vector2.RIGHT
var spd = 500
var dmg = 10
var life
var kb


func _physics_process(delta: float) -> void:
	velocity = dir * spd
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body.is_in_group("plr"):
		body.get_dmged(dmg)
