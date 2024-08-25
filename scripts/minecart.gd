extends CharacterBody2D

@export var speed = 300
var rotation_per_pixel = 22.5

@onready var minecart_wheel: Sprite2D = $MinecartBody/MinecartWheel
@onready var minecart_wheel_2: Sprite2D = $MinecartBody/MinecartWheel2

func _physics_process(delta: float) -> void:
	move(delta)
	move_and_slide()
	if position.x > 750:
		position.x = 750
	elif position.x < 50:
		position.x = 50



func move(delta : float):
	if OS.has_feature("windows"):
		var toward = Input.get_axis("ui_left","ui_right");
		velocity.x = toward * speed
		if toward > 0:
			minecart_wheel.rotation_degrees += rotation_per_pixel * speed * delta
			minecart_wheel_2.rotation_degrees += rotation_per_pixel * speed * delta
		elif toward <  0:
			minecart_wheel.rotation_degrees -= rotation_per_pixel * speed * delta
			minecart_wheel_2.rotation_degrees -= rotation_per_pixel * speed * delta
	elif OS.has_feature("android"):
		if Input.is_action_pressed("clicked"):
			if get_global_mouse_position().x > 399:
				velocity.x = speed
				minecart_wheel.rotation_degrees += rotation_per_pixel * speed * delta
				minecart_wheel_2.rotation_degrees += rotation_per_pixel * speed * delta
			elif get_global_mouse_position().x <= 399:
				velocity.x = -speed
				minecart_wheel.rotation_degrees += rotation_per_pixel * speed * delta
				minecart_wheel_2.rotation_degrees += rotation_per_pixel * speed * delta
