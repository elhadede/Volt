extends KinematicBody2D
const path = preload("res://boom.tscn")

var speed = 300
var velocity = Vector2(0,1)
func _ready():
	pass
func _process(delta):
	var collision = move_and_collide(velocity.normalized() * speed * delta)
	if collision:
		var collider = collision.collider
		if collider.name.begins_with("enemy"):
			collider.queue_free()
		var boom = path.instance()
		get_parent().add_child(boom)
		boom.position = global_position
		queue_free()
