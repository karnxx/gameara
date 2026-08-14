extends CharacterBody2D

var spd := 60
var str = 4
var dex = 3

var dir := Vector2.ZERO
var max_hp
var hp

var kb = Vector2.ZERO

var plr
var isplr = false

var cangetdmged = true

@export var f = false

@export var cutscene_mode = false

@export_range(0,10, 1) var gold = 5

@export var hpmod :int = 1

func _ready():
	randomize()
	max_hp = roundi(4 + (str + dex) / 2.0) * 2
	hp = max_hp
	new_dir()
	Dialogic.timeline_started.connect(start_diag)
	Dialogic.timeline_ended.connect(end_diag)
	Dialogic.signal_event.connect(sigevent)

func sigevent(args):
	pass

func start_diag():
	cutscene_mode = true

func end_diag():
	cutscene_mode = false

func _physics_process(delta: float) -> void:
	velocity = dir * spd + kb
	kb = kb.move_toward(Vector2.ZERO, 600 * delta)
	if cutscene_mode:
		velocity = Vector2.ZERO
	chase()
	animate()
	move_and_slide()

func chase():
	if isplr and plr and !cutscene_mode:
		dir = (plr.global_position - global_position).normalized()
		if spd == 60:
			spd *= 2.5

func move_to(dir: Vector2, dis: float):
	velocity = dir.normalized() * 60.0
	await get_tree().create_timer(dis / 60.0).timeout
	velocity = Vector2.ZERO

func new_dir():
	if isplr or cutscene_mode:
		return
	spd = 60
	if randf() < 0.7:
		dir = Vector2.ZERO
		f = randbool()
		await get_tree().create_timer(randf_range(0.1, 0.3)).timeout
		f = randbool()
		await get_tree().create_timer(randf_range(0.1, 0.3)).timeout
		f = randbool()
		await get_tree().create_timer(randf_range(0.1, 0.3)).timeout
		f = randbool()
	else:
		dir = Vector2.RIGHT.rotated(randf() * TAU)
	$Timer.wait_time = randf_range(1.5, 2.5)

func randbool():
	if randi() % 2 == 0:
		return false
	else:
		return true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		body.get_dmged(round((str+dex)/randi_range(2,4)),self)

func get_dmged(dmg, who):
	if cangetdmged == false:
		return
	cangetdmged = false
	hp -= dmg
	var knock = (global_position - who.global_position).normalized()
	kb += knock * 250
	var twen = create_tween()
	twen.tween_property(self, "modulate", Color.DARK_RED, 0.1)
	twen.tween_property(self, "modulate", Color.WHITE, 0.1)
	if hp <= 0:
		death()
	await get_tree().create_timer(0.5).timeout
	cangetdmged = true

func death():
	for i in range(gold):
		var coin = preload("res://scn/resources/coin.tscn").instantiate()
		coin.global_position = Vector2(randi_range(global_position.x - 10, global_position.x + 10),randi_range(global_position.y - 10, global_position.y + 10))
		coin.goldval = 1
		get_tree().current_scene.get_parent().call_deferred("add_child", coin)
	GameManager.enemies -= 1
	await get_tree().create_timer(0.01).timeout
	queue_free()

func jump():
	var tween = create_tween()
	var gp = global_position
	tween.tween_property(self, "global_position", gp + Vector2(0,10), 0.1).set_ease(Tween.EASE_OUT)
	await tween.finished
	tween.tween_property(self, "global_position", gp, 0.1).set_ease(Tween.EASE_OUT)

func look(dir):
	f = dir

func _on_det_body_entered(body: Node2D) -> void:
	if body.is_in_group("plr"):
		plr = body
		isplr = true

func _on_det_body_exited(body: Node2D) -> void:
	if body.is_in_group("plr"):
		plr = body
		await get_tree().create_timer(3).timeout
		isplr = false

func animate():
	if velocity.x > 0:
		f = false
	elif velocity.x < 0:
		f = true
	$AnimatedSprite2D.flip_h = (f == true)
	if velocity == Vector2.ZERO:
		$AnimatedSprite2D.play("idle")
	else:
		$AnimatedSprite2D.play("move")
