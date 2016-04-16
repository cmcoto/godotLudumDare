
extends RigidBody2D

export var player_speed = 200
export var extra_gravity = 300
export var jumpforce = 400
export var jump_count = 2
export var acceleration = 5

var current_speed = Vector2(0,0)

var btn_right = Input.is_action_pressed('btn_right')
var btn_left = Input.is_action_pressed('btn_left')
var btn_up = Input.is_action_pressed('btn_up')
var btn_jump = Input.is_action_pressed('btn_jump')
var btn_reset = Input.is_action_pressed('btn_reset')
var exit_game = Input.is_action_pressed('ui_cancel')

var grow_collision = null
var raycast_down = null

var face_direction = null
var player_animation = null
var anim = ""
var anim_new = ""
var shape_shifting = null

func is_on_ground():
	if raycast_down.is_colliding():
		#print("I hit ground")
		return true
	else:
		return false
	
func move(speed, acc, delta):
	current_speed.x = lerp(current_speed.x, speed, acc * delta)
	set_linear_velocity(Vector2(current_speed.x, get_linear_velocity().y))  
	
func _ready():
	#make up extra gravity
	set_applied_force(Vector2(0, extra_gravity))
	#set function for accessing the CollisionShape2D
	grow_collision = get_node("CollisionShape2D")
	print (grow_collision.get_name())
	#set function for Raycast to ground
	raycast_down = get_node("RayCast2D")
	raycast_down.add_exception(self)
	#to set face direction, you need the PlayerSprite Node
	face_direction = get_node("PlayerSprite")
	#set the animation player node
	player_animation = get_node("AnimationPlayer")
	#set the Shapeshifting on player
	shape_shifting = get_node("PlayerSprite")
	
	
	# Initialization here
	set_fixed_process(true)
	
	
func _fixed_process(delta):
	#call the function we created for raycast
	is_on_ground()
	
	#This gets a fixedRotation for the character...
	set_mode(MODE_CHARACTER)
	
	btn_right = Input.is_action_pressed('btn_right')
	btn_left = Input.is_action_pressed('btn_left')
	btn_up = Input.is_action_pressed('btn_up')
	btn_jump = Input.is_action_pressed('btn_jump')
	btn_reset = Input.is_action_pressed('btn_reset')
	exit_game = Input.is_action_pressed('ui_cancel')
	
	#for the player_animation
	if anim != anim_new:
		anim_new = anim
		player_animation.play(anim)
	
	if btn_left:
		move(-player_speed, acceleration, delta)
		#set_linear_velocity(Vector2(-player_speed,get_linear_velocity().y))
		#set the face direction of the sprite
		face_direction.set_flip_h(true)
		anim = "PlayerWalk"
		#print(get_pos().x)
	elif btn_right:
		move(player_speed, acceleration, delta)
		#set_linear_velocity(Vector2(player_speed,get_linear_velocity().y))
		#set the face direction of the sprite
		face_direction.set_flip_h(false)
		anim = "PlayerWalk"
		#print(get_pos().x)
	
	else:
		move(0, acceleration, delta)
		#set_linear_velocity(Vector2(0,get_linear_velocity().y))
		anim = "PlayerIdle"
	
	

	
	if is_on_ground():
		if btn_jump:
			set_axis_velocity(Vector2(0, -jumpforce))
			
	if !is_on_ground():
		anim = "PlayerJump"
	
	if btn_up:
	#This makes the PlayerSprite 3 times bigger...
		set_scale( Vector2( 3, 3))
		print(get_scale())
		#This makes the CollisionShape 3 times bigger...
		grow_collision.set_scale( Vector2( 3,3))
		#This makes the Player Shapeshift, must be the player sprite
		
	else:
		#print(get_scale())
		grow_collision.set_scale( Vector2( 1,1))
	
	#reset current scene - press backspace key
	if btn_reset:
		get_tree().reload_current_scene()
	
	#escape the game - press escape key
	if exit_game:
		get_tree().quit()
	
