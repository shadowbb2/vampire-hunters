extends CharacterBody2D


var movement_speed = 40
var hp = 80

@onready var sprite = $Sprite2D
@onready var WalkTimer = get_node("%WalkTimer")

func _physics_process(delta):
	movement()

func movement():
	var x_move = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_move = Input.get_action_strength("down") - Input.get_action_strength("up")
	var move = Vector2(x_move, y_move)
	if move.x > 0:
		sprite.flip_h = true
	elif move.x < 0:
		sprite.flip_h = false
		
	if move != Vector2.ZERO:
		if WalkTimer.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0
			else:
				sprite.frame += 1
			WalkTimer.start()
	velocity = move.normalized() * movement_speed
	move_and_slide()


func _on_hurt_box_hurt(damage: Variant) -> void:
	hp -= damage
	print(hp)
