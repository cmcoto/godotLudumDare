
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"
var raycastEnemyA_down = null
var EnemyAface_direction = null
#var EnemyAVelocity = set_linear_velocity(Vector2(-5, 0))

func is_on_ground():
	if raycastEnemyA_down.is_colliding():
		#print("Enemy is on ground")
		return true
	else:
		return false

func _ready():

#set function for Raycast to ground
	raycastEnemyA_down = get_node("RayCast2D")
	raycastEnemyA_down.add_exception(self)
	#to set face direction, you need the PlayerSprite Node
	EnemyAface_direction = get_node("SpriteEnemyA")
# Initialization here
# Initialization here
	set_fixed_process(true)
	
	
func _fixed_process(delta):
	#call the function we created for raycast
	is_on_ground()
	
	#This gets a fixedRotation for the character...
	set_mode(MODE_CHARACTER)
	
	if is_on_ground():
		set_linear_velocity(Vector2(-25, 0)) 
		EnemyAface_direction.set_flip_h(false)
	else:
	#COMO LE DOY VUELTA??? DE REGRESO???
		#set_linear_velocity(Vector2(
		EnemyAface_direction.set_flip_h(true)
		#set_linear_velocity(Vector2(25,0))
	
	
		
		 