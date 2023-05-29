extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var health=20
onready var speed=50
onready var action_time_tick=90
onready var attk=5
onready var velocity=Vector2(0,0)
onready var state="idel"
onready var ai_state="trace"
onready var self_to_player_vec=Vector2(0,0)
onready var self_to_player_x_distance=0
onready var self_to_player_y_distance=0
onready var blowed=false
onready var player_instance=self.get_parent().get_node("Bug")
onready var self_dead_animation_tscn=preload("res://tscn/slam_dead_Animation.tscn")
onready var tick=0
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$AnimationPlayer.play("idel")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tick+=1
	if tick<action_time_tick:
		pass
		
	elif tick==action_time_tick:
		var rand_state_num=rand_range(0,40)
		if rand_state_num<10:
			state="idel"
		else:
			state="walk"
		var rand_ai_state_num=rand_range(0,40)
		if rand_ai_state_num<30:
			ai_state="trace"
		else:
			ai_state="run_away"
			pass
	elif tick>action_time_tick:
		tick=0
#		var rand_time_tick=rand_range(30,60)
#		action_time_tick=120+rand_time_tick
	else:
		pass
	
	
	self_to_player_vec=self.global_position-player_instance.global_position
	self_to_player_x_distance=abs(self_to_player_vec.x)
	self_to_player_y_distance=abs(self_to_player_vec.y)
	self_to_player_vec=self_to_player_vec.normalized()

func _physics_process(delta):
	if state=="walk"&&ai_state=="trace"&&blowed==false:
		$AnimationPlayer.play("walk")
		velocity.x=-speed*self_to_player_vec.x
	elif state=="walk"&&ai_state=="run_away"&&blowed==false:
		$AnimationPlayer.play("walk")
		velocity.x=+speed*self_to_player_vec.x
	move_and_slide(velocity,Vector2(0,-1))
	if is_on_floor():
		blowed=false
		velocity.y=0
		velocity.x=0
	else:
		velocity.y+=Glo.gravity_force*delta

func _on_Area2D_area_entered(area):
	velocity+=Vector2(Glo.player_face_dir*100,-140)
	if area.is_in_group("attk_blade_area"):
		blowed=true
		self.health-=area.get_parent().attk
		if health>0:
			$AnimationPlayer.play("hitted")
		if health<0:
			var temp_instance=self_dead_animation_tscn.instance()
			self.get_parent().add_child(temp_instance)
			temp_instance.global_position=self.global_position
			self.queue_free()
			



func _on_AnimationPlayer_animation_finished(hitted):
	blowed=false
	$AnimationPlayer.play("idel")
	pass # Replace with function body.

