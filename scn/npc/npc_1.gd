extends CharacterBody2D

@export var dialogue : String = "res://dialog/timelines/timeline.dtl"
@export var shudlook : bool = true
@export var radius : float = 40.0

var plr = false

var player 

var lokaplr = false

var facingleft = false

func _ready() -> void:
	$Area2D3/CollisionShape2D.shape.radius = radius

func _physics_process(delta: float) -> void:
	animate()

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group('plr'):
		plr = true
		$inter.visible = true

func animate():
	if velocity.x > 0:
		facingleft = false
	elif velocity.x < 0:
		facingleft = true
	if lokaplr and player and shudlook:
		if (player.global_position.x - global_position.x) > 0:
			facingleft = false
		else:
			facingleft = true
	$AnimatedSprite2D.flip_h = facingleft
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("walk")

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	if body.is_in_group('plr'):
		plr = false
		$inter.visible = false

func interact(plr):
	plr.state = plr.State.DIALOGUE
	Dialogic.start(dialogue)
	await Dialogic.timeline_ended
	plr.state = plr.State.NORMAL

func _on_area_2d_3_body_entered(body: Node2D) -> void:
	if body.is_in_group('plr'):
		player = body
		lokaplr = true

func _on_area_2d_3_body_exited(body: Node2D) -> void:
	if body.is_in_group('plr'):
		lokaplr = false
