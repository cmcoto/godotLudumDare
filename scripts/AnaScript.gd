
extends RigidBody2D

export var extra_gravity = 300

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
# Initialization here
	set_applied_force(Vector2(0, extra_gravity))

	set_fixed_process(true)
	
	
func _fixed_process(delta):

	
	#This gets a fixedRotation for the character...
	set_mode(MODE_CHARACTER)
	
	
	


