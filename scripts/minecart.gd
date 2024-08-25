extends CharacterBody2D

@export var speed = 300
var rotation_per_pixel = 22.5

@onready var minecart_wheel: Sprite2D = $MinecartBody/MinecartWheel
@onready var minecart_wheel_2: Sprite2D = $MinecartBody/MinecartWheel2

func _physics_process(delta: float) -> void:
	var toward = Input.get_axis("ui_left","ui_right");
	velocity.x = toward * speed
	if toward > 0:
		minecart_wheel.rotation_degrees += rotation_per_pixel * speed * delta
		minecart_wheel_2.rotation_degrees += rotation_per_pixel * speed * delta
	elif toward <  0:
		minecart_wheel.rotation_degrees -= rotation_per_pixel * speed * delta
		minecart_wheel_2.rotation_degrees -= rotation_per_pixel * speed * delta
	move_and_slide()
