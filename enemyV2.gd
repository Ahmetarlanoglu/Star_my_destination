extends KinematicBody2D
var konum = Vector2()
var gravityy = 0
var sag
var sol
var counter = 0
onready var sprite =$drone
var memory = Vector2()
var cast_to=0
var fire
var in_reflect=false
var t =0.0
var zabrom
var TIME=0
var printer=0
var yon =1
var time_counter=true
var ek_mermi=true
var in_intance=false
var instance_counter=0
var dash_counter=0
var ghost_scene =preload("res://assets/blast_drones/dash_sprite2.tscn")
var fallowing=true
var near_trigger=false
var test=0
var drone_height=0
var testiyi=true
onready var blood =preload ("res://assets/blast_drones/bilad3.tscn")
onready var fireball_scene=preload("res://assets/arrows/arrow1.tscn")
onready var yerde = get_node("/root/Level1/KinematicBody2D/RayCast2D")
onready var player = get_node("/root/Level1/KinematicBody2D")
var c 
func _ready():
	zabrom=global_position
func _process(delta):
	near_trigger=get_node("PushArea").near_trigger
	if near_trigger and time_counter:
		dashla(delta)
		if testiyi:
			testiyi=false
			ek_mermi=true
#	if test>20*delta:
#		instance_ghost()
#		test-=20*delta
	flip()
	if abs( player.global_position.x-global_position.x)<1000:
		TIME+=delta
		move(delta)
		$drone.play("attack")
	else:
		$drone.play("idle")
	$detection_ray.cast_to=Vector2(cast_to)
	konum.x=0
	konum.y=0
	konum = move_and_slide(konum,Vector2(0,-1))
func flip():
	memory=global_position
	cast_to=player.global_position-global_position 
	$gun.rotation=atan(cast_to.y/cast_to.x)/1.2
	$drone.rotation=atan(cast_to.y/cast_to.x)/3.0
	if player.global_position.x<global_position.x:
		$gun.flip_h=false
		yon=1
		$fire_pivot.yon=1
		$drone.flip_h=true
	else:
		$gun.flip_h=true
		yon=-1
		$fire_pivot.yon=-1
		$drone.flip_h=false
func quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, _t: float):
	var q0 = p0.linear_interpolate(p1, t)
	var q1 = p1.linear_interpolate(p2, t)
	var r = q0.linear_interpolate(q1, t)
	return r
func move(delta):
	if fallowing:
		var sag_ust=Vector2(player.global_position.x+(350*yon),player.global_position.y-400)
		global_position = global_position.linear_interpolate(sag_ust, delta*1.8)
		global_position.y+=sin(TIME*5)*2
#		global_position.x+=sin(TIME)*3
#		$drone.modulate.g-=delta/5
		$drone.modulate.g=0.8
		test+=delta
		if test>20*delta:
			instance_ghost()
			test-=20*delta
		if TIME>1:
			fallowing=false
	else:#fallowwwwwwwwwwwwwnooooooo
		var sag_ust=Vector2(player.global_position.x+(350*yon),player.global_position.y-300)
		global_position = global_position.linear_interpolate(sag_ust, delta*0.4)
		$drone.modulate.g=0.89
		$drone.modulate.g=1
		global_position.y+=sin(TIME/2)/2.5
		global_position.x-=sin((TIME/2)+(PI/2))/2
		if $RayCast2D.is_colliding():
			$Timer.start()
			in_intance=true
		if in_intance:
			instance_counter+=delta
			if instance_counter>20*delta:
				instance_ghost()
				instance_counter-=20*delta
	if (player.global_position.y-global_position.y>650):
		global_position.y+=(player.global_position.y-global_position.y)*delta
	
		
func instance_ghost():
	var ghost:Sprite=ghost_scene.instance()
	get_parent().add_child(ghost)
	var _current_frame_index=sprite.frame
	var frame=sprite.frames.get_frame("idle",1)
	ghost.texture=frame
	ghost.offset.y-=5
	ghost.global_position=global_position
	ghost.flip_h=sprite.flip_h
	ghost.scale.y = 2.0
	ghost.scale.x = 2.0
	ghost.z_index=-1
	ghost.rotation=$drone.rotation
func _on_Timer_timeout():
	in_intance=false
func dashla(delta):
	dash_counter+=delta
#	if ek_mermi:
#		var fireball= fireball_scene.instance()
#		fireball.position=global_position
#		fireball.position=global_position
#		ek_mermi=false
#		$PushArea/Node.add_child(fireball)
	if dash_counter>8*delta:
		instance_ghost()
		dash_counter-=8*delta
	global_position+=$PushArea.yon*rand_range(1.4,1.5)*Engine.time_scale
#	printer+=1
#	if printer==50:
#		printer-=50
#	print(global_position.angle_to_point(player.global_position)
func _on_Death_area_area_entered(area):
	if area.is_in_group("attack"):
#		player.camera_hit_animations=true
		get_node("/root/Level1/KinematicBody2D/Camera2D/Layer").start_cronic_vibration=true
#		get_node("/root/Level1/KinematicBody2D/Camera2D/Layer").set("screen_pause",true)
#		get_node("/root/Level1/KinematicBody2D/Camera2D/Layer").set("pause_time",5.58)
#		get_node("/root/Level1/KinematicBody2D/Camera2D/Layer").set("time_scale",0.28)
		get_node("/root/Level1/KinematicBody2D/Camera2D/Layer/suluboya").modulate.g=1.0
		var blood_intance=blood.instance()
		get_tree().current_scene.add_child(blood_intance)
		blood_intance.global_position=global_position
		get_node("/root/Level1/KinematicBody2D/deatharea").can+=40
		blood_intance.rotation=global_position.angle_to_point(player.global_position)
		blood_intance.process_material.set_shader_param("bound",global_position.y+800)
		queue_free()
	if area.is_in_group("hit") and $fire_pivot.in_reflect:
		pass
		
