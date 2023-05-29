extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var tick=0
onready var enemy_num=0
onready var enemy_max_num=10
onready var slam_tscn=preload("res://tscn/enemy_slam.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tick+=1
	if tick>=60&&enemy_num<enemy_max_num:
		enemy_num+=1
		var slam_instance=slam_tscn.instance()
		var rand_num=rand_range(0,1024)
		self.add_child(slam_instance)
		slam_instance.global_position=Vector2(rand_num,0)
		tick=0
		print(enemy_num)
	pass
