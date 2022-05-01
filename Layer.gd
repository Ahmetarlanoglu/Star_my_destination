extends CanvasLayer
var start_cronic_vibration=false
var screen_pause=false
var pause_time=1.0
var time_scale=0.05

func _process(_delta):
	if start_cronic_vibration:
		start_cronic_vibration=false
		cronic_vibraiton(0.1)
		
	if screen_pause:
		screen_pause=false
		frameFreeze(time_scale,(get_viewport().size.x-1500)/1200*pause_time)
func frameFreeze(timeScale,duration):
		Engine.time_scale=timeScale
		yield(get_tree().create_timer(duration* timeScale),"timeout")
		Engine.time_scale=1.0
func cronic_vibraiton(duration):
		$suluboya.visible=true
		yield(get_tree().create_timer(duration),"timeout")
		$suluboya.visible=false
