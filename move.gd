extends KinematicBody2D

#var socket
#func _ready():
#	socket = StreamPeerTCP.new()
#	socket.set_no_delay(true)
#	socket.connect_to_host("127.0.0.1",11000)
#	socket.put_var("GO")
var fire_rate : float = 2
onready var update_delta : float = 1 / fire_rate
var current_time : float = 0
const bulletpath = preload("res://bullet.tscn")
export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_pressed("fire"):	
		if (current_time > update_delta):
			current_time = 0
			shoot()

func _physics_process(delta):
	look_at(get_global_mouse_position())
	current_time += delta
	get_input()
	velocity = move_and_slide(velocity)
func shoot():
	var bullet = bulletpath.instance()
	get_parent().add_child(bullet)
	bullet.position = $Position2D.global_position
	bullet.rotation = $Position2D.global_rotation
	bullet.velocity = bullet.position - get_global_position()
