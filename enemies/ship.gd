extends KinematicBody2D

export (PackedScene) var target
export var speed = 0

signal destroyed

var velocity = Vector2()
var collided = false

func _ready():
	connect("tree_exiting", self, "on_exiting_tree")

func _physics_process(delta):
	velocity = (target.position - position).normalized() * speed
	rotation = velocity.angle()
	
	if !collided:
		var collision_info = move_and_collide(velocity)
		if (collision_info):
			collided = true
			emit_signal("destroyed", self)
			collision_info.collider.queue_free()

func on_exiting_tree():
	emit_signal("destroyed", self)