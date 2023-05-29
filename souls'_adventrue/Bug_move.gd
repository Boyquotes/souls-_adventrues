extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
onready var attk=7
# var b = "text"
onready var attk_blade_tscn=preload("res://tscn/attk_blade.tscn")
onready var move_state="idel"
onready var velocity=Vector2(0,0)
const  RUN_speed:=200.0
const fri_force=100
const Max_vec_y=98*5
onready var run_dir=0
onready var acc_speed=3
onready var max_x_speed=7
onready var speed_x=0
onready var speed_y=0
onready var jump_tick=0
onready var on_wall=false
onready var on_floor=false
onready var unstable_on_wall=false
onready var double_jump_able=true
onready var double_jump_tick=0
onready var double_jump_limit=10
onready var in_air=false
onready var jump_able=true
onready var gravity_force=98
onready var T_dash=$Tween_dash
# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_force=Glo.gravity_force
	pass # Replace with function body.


func _physics_process(delta):
	
#左右移动
	if is_on_floor():
		on_floor=true
		double_jump_able=true
		run_dir=Input.get_axis("ui_left","ui_right")
		velocity.x=run_dir*RUN_speed
	else:
		run_dir=Input.get_axis("ui_left","ui_right")
		velocity.x=run_dir*RUN_speed/1.25
		on_floor=false
		if is_on_wall():
			velocity.y=100
		else:
			velocity.y+=Glo.gravity_force*delta
	if run_dir!=0:
		Glo.player_face_dir=run_dir

	if Input.is_action_just_pressed("ui_up"):
		if  on_floor==true||double_jump_able==true:
			if is_on_floor()&&move_state!="attk":
				move_state="jump"
				velocity.y=-400
			elif is_on_wall():
				velocity.y=-490/1.5
				velocity.x=-run_dir*RUN_speed*8
			else:
				velocity.y=-490/1.8
				double_jump_able=false
		else:
			pass
			
	if velocity.y>Max_vec_y:
		velocity.y=Max_vec_y
	
	
	move_and_slide(velocity,Vector2(0,-1))
	pass
	
	if is_on_wall():
		on_wall=true
		double_jump_able=true
	else:
		on_wall=false
		
		




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if move_state=="walk":
		$AnimationPlayer.play("walk")
		pass
	elif move_state=="jump":
		$AnimationPlayer.play("jump")
		pass
	elif move_state=="attk":
		$AnimationPlayer.play("attk")
		pass
	else:
		$AnimationPlayer.play("idel")
		pass

#攻击相关代码
	if Input.is_action_pressed("ui_attk")&&move_state!="attk":
		var attk_blade_instance=attk_blade_tscn.instance()
		self.get_node("Position2D").add_child(attk_blade_instance)
		attk_blade_instance.global_position=self.global_position
		move_state="attk"

	if Input.is_action_pressed("ui_right"):
		self.get_node("Position2D").scale.x=1
		if is_on_floor()&&move_state!="attk":
			move_state="walk"
		else:
			pass
	elif Input.is_action_pressed("ui_left"):
		self.get_node("Position2D").scale.x=-1
		if is_on_floor()&&move_state!="attk":
			move_state="walk"
		else:
			pass
	else:
		if is_on_floor()&&move_state!="attk":
			move_state="idel"
		else:
			pass
		if speed_x>0:
			speed_x-=fri_force
		elif speed_x<=0:
			speed_x=0
		else:pass

	pass

	



func _on_Button_button_down():
	self.global_position=Vector2(200,200)
	pass # Replace with function body.



func _on_AnimationPlayer_animation_finished(attk):
		move_state="idel"
		pass # Replace with function body.
