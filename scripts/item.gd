extends Area2D
class_name Item

signal collised
signal freed

@export var falling_speed = 200;
@export var type: String = ""
@export var can_be_collised_by_minecart = true

func _physics_process(delta: float) -> void:
	position.y += falling_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if can_be_collised_by_minecart:
		collised.emit()
		to_free()
	
func _on_area_entered(area: Area2D) -> void:
	if area.type == "protection":
		to_free()

func to_free():
	freed.emit()
	queue_free()
