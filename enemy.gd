extends KinematicBody2D


var speed = 50

func _ready():
	pass
func _process(delta):
	var player = get_parent().get_node("player")
	var dist = position.distance_to(player.position)
	if dist < 400:
		look_at(player.position)
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(position ,player.position)
		if result:
			if result.collider.name.begins_with("player"):
				var collision = move_and_collide((player.position - position).normalized() * speed * delta)
				if collision:
					var collider = collision.collider
					if collider.name.begins_with("player"):
						get_tree().change_scene("res://menu.tscn")
					
