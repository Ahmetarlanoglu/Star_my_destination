extends Sprite
var t =0.0
var za


onready var sed =get_parent().get_node("Sprite2")
func _ready():
	za=global_position
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	za=global_position
	if t>-1:
		frameFreeze(0.5)
		t=-8
	var hedef=Vector2(sed.global_position.x,sed.global_position.y)
	var orta=Vector2((sed.global_position.x+global_position.x)/2,((sed.global_position.y+global_position.y)/2)+300)
#	global_position = global_position.linear_interpolate(sag_ust, t)
#	global_position = quadratic_bezier(za,orta,hedef,t)
func quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float):
	var q0 = p0.linear_interpolate(p1, t)
	var q1 = p1.linear_interpolate(p2, t*50)
	var r = q0.linear_interpolate(q1, t)
	return r
func frameFreeze(duration):
		modulate.r=3
		yield(get_tree().create_timer(duration),"timeout")
		modulate.r=1
