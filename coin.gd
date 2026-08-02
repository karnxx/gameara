extends Area2D

@export var goldval : int

func _on_body_entered(body: Node2D) -> void:
	body.gold += goldval
	queue_free()
