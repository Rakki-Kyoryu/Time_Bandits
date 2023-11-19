extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.game_first_loadin == true:
		$Player.position.x = Global.player_start_posx
		$Player.position.y = Global.player_start_posy
		Global.game_first_loadin = false
	else:
		$Player.position.x = Global.player_exit_cliffside_posx
		$Player.position.y = Global.player_exit_cliffside_posy

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	
func _on_cliffside_transition_point_body_entered(body):
	if body.has_method("player"):
		Global.transition_scene = true
		


func _on_cliffside_transition_point_body_exited(body):
	if body.has_method("player"):
		Global.transition_scene = false
		
func change_scene():
	if Global.transition_scene == true:
		if Global.current_scene == "field":
			get_tree().change_scene_to_file("res://maps/cliffside/cliff_side.tscn")
			Global.finish_changing_scenes()


func _on_inventory_gui_closed():
	get_tree().paused = false

func _on_inventory_gui_opened():
	get_tree().paused = true
