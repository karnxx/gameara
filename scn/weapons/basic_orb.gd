extends Node2D


var caster
var destory
var plr

var pixel_pos := Vector2i(2, 16)
var texture

func _process(delta: float) -> void:
	texture = $Node/Sprite2D.texture
	$Node/GPUParticles2D.modulate =  texture.get_image().get_pixelv(pixel_pos)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("hittable"):
		body.get_dmged(destory.final_dmg, plr)
		destory.destroy_proj()
		queue_free()
