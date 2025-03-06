extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -250.0
var timer = 0
@onready var animated_sprite = $AnimatedSprite2D

# Získání gravitace z nastavení projektu
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	# Aplikace gravitace
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("run")
		animated_sprite.flip_h = direction < 0
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			animated_sprite.play("idle")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("jump")
	
	if Input.is_action_just_pressed("attack"):
		animated_sprite.play("attack")
   
	
	move_and_slide()


	
