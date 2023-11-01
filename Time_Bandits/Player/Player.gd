extends CharacterBody2D

@export var speed = 250

func _process(delta):
	var input = Input.get_vector("left","right","up","down")
	position += input * speed * delta
	
