extends CharacterBody2D

@export var move_speed:float=200
@export var animator:AnimatedSprite2D
@export var is_game_over:bool=false

@export var bullet_scene:PackedScene
@warning_ignore("unused_parameter")
func attack_bullet()->void:
	var bullet_node=bullet_scene.instantiate()
	bullet_node.position=position+Vector2(50,24)
	get_tree().current_scene.add_child(bullet_node)
func _physics_process(delta: float) -> void:
	if not is_game_over:
		velocity=Input.get_vector("left","right","up","down")*move_speed
		if velocity==Vector2.ZERO:
			animator.play("idle")
		else:
			animator.play("run")
		move_and_slide()
	if Input.is_action_pressed("attack_bullet"):
		attack_bullet()

func game_over():
	is_game_over=true
	animator.play("die")
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()

#
#func _on_timer_timeout(evemt:InputEvent) -> void:
	#if event.is_action_pressed("attack_bullet"):
		#attack_bullet()
	#return 
