extends Area2D
class_name Item

signal collised
signal freed

@export var falling_speed : float = 200;
@export var type: String = ""
@export var can_be_collised_by_minecart = true
@export var can_ignore_protection = false
@export var limit_height : int = -1 ## 非正数 为 无限制

var now_height = 0

func _physics_process(delta: float) -> void:
	position.y += falling_speed * delta
	if limit_height > 0:
		now_height += falling_speed * delta
		if now_height > limit_height:
			to_free()
	
	
@warning_ignore("unused_parameter")
func _on_body_entered(body: Node2D) -> void:
	if can_be_collised_by_minecart:
		collised.emit()
		to_free()
	
func _on_area_entered(area: Area2D) -> void:
	if area.type == "protection" and not can_ignore_protection:
		to_free()

func to_free() -> void:
	freed.emit()
	queue_free()
