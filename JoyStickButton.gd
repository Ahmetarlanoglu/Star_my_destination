extends TouchScreenButton
var radius =Vector2(30,25)
var boundry=64

var dragging=-1
var return_accel=20


func _ready():
	
	scale.x=1.7


func get_button_pos():
	return position+radius
func _process(delta):
	if dragging==-1:
		var pos_difference=(Vector2(0,0)-radius)-position
		position+=pos_difference*return_accel*delta
func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_centre=(event.position-get_parent().global_position).length()
		if event_dist_from_centre <= boundry*global_scale.x or event.get_index()==dragging:
			#set_global_position(event.position-radius*global_scale)
			global_position=(event.position-radius*global_scale)
			if get_button_pos().length()>boundry:
				position=(get_button_pos().normalized()*boundry-radius)
			dragging=event.get_index()
			
	if event is InputEventScreenTouch and !event.is_pressed()and event.get_index()==dragging:
			dragging=-1

func get_value():
	if get_button_pos().length()>10:
		return get_button_pos()
	return Vector2(0.01,0.001)
