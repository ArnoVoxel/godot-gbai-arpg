extends CharacterBody2D
class_name Player

@onready var animations = $AnimationPlayer
@export_range(0.0, 1.0) var inertia : float = 0.15
@export var max_speed : float = 100.0

var speed : float = 0.0
var playerOrientation: String = "Down"
var direction := Vector2.ZERO
var last_direction := Vector2.ZERO

func _ready() -> void:
	return
	
func _physics_process(delta: float) -> void:
	move()
	updateAnimation()
	
func _input(event) ->void:
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if direction != Vector2.ZERO:
		last_direction = direction
	
func move() -> void:
	if direction == Vector2.ZERO:
		speed = lerp(speed, 0.0, inertia)
	else :
		speed = lerp(speed, max_speed, inertia)
	
	velocity = last_direction * speed
	move_and_slide()
	
func updateAnimation():
	if last_direction.x < 0 :
		if last_direction.y < 0 :
			playerOrientation = "Up"
		else :
			playerOrientation = "Left"
	else :
		if last_direction.y < 0 :
			playerOrientation = "Up"
		elif last_direction.y > 0 && last_direction.y < 0.5 :
			playerOrientation = "Right"
		else :
			playerOrientation = "Down" 
	
	animations.play("walk" + playerOrientation)
