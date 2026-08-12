extends CharacterBody2D

var dir
var spellee

func _physics_process(delta: float) -> void:
	velocity = dir * spellee.projspd
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("hittable"):
		spellee.hit(body)
