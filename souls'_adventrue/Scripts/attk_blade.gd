extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var attk=6
onready var health=1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing=true
	attk=get_parent().get_parent().attk
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_AnimatedSprite_animation_finished():
	self.queue_free()
	pass # Replace with function body.


func _on_attk_blade_area_area_entered(area):
	if area.is_in_group("enemy"):
		self.queue_free()
		pass
		
	pass # Replace with function body.
