extends CharacterBody2D

const speed = 100

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

func _physics_process(delta):
	
	var velocity = Vector2(0,0)
	if Input.is_action_pressed("right"):
		velocity.x += 5
	if Input.is_action_pressed("left"):
		velocity.x -= 5
	if Input.is_action_pressed("down"):
		velocity.y += 5
	if Input.is_action_pressed("up"):
		velocity.y -= 5
		
		
	if velocity.length()>0:
		move_and_collide(velocity)
		
	enemy_attacks()
	if health <= 0:
		player_alive = false
		health = 0
		self.queue_free()



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
