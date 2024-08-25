extends Node2D

var score:int
var hp = 3
var rate = 10

var hp_show_format = "生命：%d"
var score_show_format = "分数：%d"
@onready var label: Label = $UI/Control/Panel/Label
@onready var label2: Label = $UI/Control/Panel2/Label
@onready var coins: ItemArea = $Areas/Coins
@onready var thumb_ups: ItemArea = $Areas/ThumbUps
@onready var thumb_downs: ItemArea = $Areas/ThumbDowns
@onready var collections: ItemArea = $Areas/Collections
@onready var minecart: = $Minecart

const PROTECTION = preload("res://scenes/protection.tscn")

func _on_items_area_deal_with(type: ItemArea.ItemType) -> void:
	if type == ItemArea.ItemType.COIN:
		score += 1
		
		coins.falling_speed = coins.basic_speed + score * rate
		thumb_ups.falling_speed = thumb_ups.basic_speed + score * rate
		thumb_downs.falling_speed = thumb_downs.basic_speed + score * rate
		collections.falling_speed = collections.basic_speed + score * rate
		
		minecart.speed += rate
		
		label.text = score_show_format % score
		print(score)
	elif type == ItemArea.ItemType.THUMBUP:
		if hp < 6:
			hp += 1
			label2.text = hp_show_format % hp
	elif type == ItemArea.ItemType.THUMBDOWN:
		if hp > 0:
			hp -= 1
			label2.text = hp_show_format % hp
			if hp <= 0:
				get_tree().reload_current_scene()
	elif type == ItemArea.ItemType.COLLECTION:
		minecart.add_child(PROTECTION.instantiate())
