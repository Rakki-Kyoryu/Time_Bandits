extends CharacterBody2D

const speed = 300

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var current_dir = "none"

var attack_ip = false

func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	enemy_attacks()
	player_movement(delta)
	attack()

func player_movement(delta):
	
	if Input.is_action_pressed("down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed 
		velocity.x = 0
	elif Input.is_action_pressed("up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	elif Input.is_action_pressed("right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0	
	else:
		play_anim(0)
		velocity.y = 0
		velocity.x = 0
		
	move_and_slide()
		
	
	if health <= 0:
		player_alive = false
		health = 0
		self.queue_free()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("walking_side")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("walking_side")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("walking_down")
		elif movement == 0:
			if attack_ip == false:
				anim.play("front_idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("walking_up")
		elif movement == 0:
			if attack_ip == false:
				anim.play("back_idle")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false
		
func enemy_attacks():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("sword_hit_side")
			$deal_attack_timer.start()
		if dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("sword_hit_side")
			$deal_attack_timer.start()
		if dir == "down":
			$AnimatedSprite2D.play("sword_hit_down")
			$deal_attack_timer.start()
		if dir == "up":
			$AnimatedSprite2D.play("sword_hit_up")
			$deal_attack_timer.start()


func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false
