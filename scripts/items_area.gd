extends Sprite2D
class_name ItemArea
enum ItemType{
	COIN,
	THUMBUP,
	THUMBDOWN,
	COLLECTION
}
const COIN = preload("res://scenes/coin.tscn")
const THUMB_UP = preload("res://scenes/thumb_up.tscn")
const THUMB_DOWN = preload("res://scenes/thumb_down.tscn")
const COLLECTION = preload("res://scenes/collection.tscn")

@export var type : ItemType
@export_group("生成")
@export var spawn_node : Node2D
@export var basic_speed : float = 200
@export_range(0,10) var translate_to_falling_speed_rate : float = 1
@export_range(0,1) var spread :float = 0.5
@export var max_item_count : int = 10
@export var born_once : int = 1
@export var limit_height : int = 600 ##限高
@export_subgroup("时间")
@export var time_max : float = 1
@export var time_min : float = 0.1
@export var timer : Timer ##设置计时器[br]如果想手动设置：[br][code]timer.wait_time = time_max[/code][br][code]timer.start()[/code][br][code]timer.timeout.connect(self.method)[/code]

var child : PackedScene
var item_count = 0
var falling_speed = basic_speed

signal deal_with(type:ItemType)

func _ready() -> void:
	timer.wait_time = time_max
	timer.start()
	timer.timeout.connect(self.born)
	if type == ItemType.COIN:
		child = COIN
	elif type == ItemType.THUMBUP:
		child = THUMB_UP
	elif type == ItemType.THUMBDOWN:
		child = THUMB_DOWN
	elif type == ItemType.COLLECTION:
		child = COLLECTION

func get_length() -> Vector2:
	return Vector2(position.x - 8*scale.x, position.x + 8*scale.x)

func born():
	print("called")
	timer.wait_time = randf_range(time_min,time_max)
	if item_count >= max_item_count or spawn_node == null or child == null:
		timer.start()
		return
	for i in range(born_once):
		if randf_range(0,1) > spread or item_count >= max_item_count:
			break
		var rangea = get_length()
		var spawnlocation = Vector2(randi_range(rangea.x, rangea.y), position.y)
		var c = child.instantiate()
		c.position = spawnlocation
		c.falling_speed = falling_speed
		c.limit_height = limit_height
		c.collised.connect(self.even_called)
		c.freed.connect(self.item_freed)
		item_count += 1
		spawn_node.add_child(c)
		print("OK")
	timer.start()

func even_called():
	deal_with.emit(type)

func item_freed():
	if (item_count > 0): item_count -= 1
