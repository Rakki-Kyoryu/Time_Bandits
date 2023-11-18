extends ProgressBar

func _ready():
	value = Global.player_health
	
	
func _on_timer_timeout() -> void:
	value = Global.player_health
