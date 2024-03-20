extends CharacterBody2D

enum {
	DEATH,
	DAMAGE,
	ATTACK,
	MOVE
}

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer
var health = 100
var money = 0
var state = MOVE
var attack_cooldown = false

func _physics_process(delta):
	match state:
		DAMAGE:
			pass
		ATTACK:
			attack_state()
		DEATH:
			pass
		MOVE:
			move_state()

	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animPlayer.play("Jump")

	if velocity.y > 0:
		animPlayer.play("Fall")
		
	if health <= 0:
		health = 0
		animPlayer.play("Death")
		await animPlayer.animation_finished
		queue_free()
		get_tree().change_scene_to_file("res://menu.tscn")

	move_and_slide()
	
func move_state():
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animPlayer.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animPlayer.play("Idle")
	if direction == -1:
		anim.flip_h = true
	elif direction == 1:
		anim.flip_h = false
	if Input.is_action_just_pressed("attack") and attack_cooldown == false:
		state = ATTACK
		
func attack_state():
	velocity.x = 0
	animPlayer.play("Attack")
	await animPlayer.animation_finished
	attack_freez()
	state = MOVE

func attack_freez():
	attack_cooldown = true
	await get_tree().create_timer(0.5).timeout
	attack_cooldown = false
