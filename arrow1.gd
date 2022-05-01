extends Area2D
var b =false
var c
var passes=0
var d
var kurtarma=0
var eim
var g = Vector2()
var ivme=260
var a=0
var HEDEF
var le
var carpma=0
var tetikleme=true
var tetikleme2=true
var test=0
var resetsignal=false
var stop=false
var ammo_velocity=1200
var on_reflect=false
var dur=false
var reflect_direction=Vector2(0,0)
var player_reflected=0
#onready var inleft = get_node("/root/Level1/enemy/RightRay")
onready var detection = get_parent().get_parent().get_parent().get_node("detection_ray")
onready var hedef = get_node("/root/Level1/KinematicBody2D")
onready var yokolma = get_node("/root/Level1/KinematicBody2D/deatharea")
onready var enemy = get_parent().get_parent().get_parent().get_node("fire_pivot")
onready var enemy2 =get_parent().get_parent().get_parent().get_node("Sprite")
onready var player=get_node("/root/Level1/KinematicBody2D")
onready var health_bar=get_node("/root/Level1/KinematicBody2D/deatharea")


	
	
func _ready():
	if get_viewport().size.x/get_viewport().size.y>1.90:#pc1,7telefon2,2
		scale=Vector2(1.3,1.5)
func _process(delta):
	if on_reflect:
		reflect(delta)
	resetsignal=false
	if $in_player.is_colliding():
		player.global_position.x+=1000*delta*enemy.yon*-1
		player.global_position.y+=1000*delta*-1
		kus()
		health_bar.can-=25
#a += (delta *1000)/abs(ivme)
	stop=false
	if detection.is_colliding()==true and  tetikleme==true  :
		stop=true
		carpma=1
	else:
		carpma=0
	test+=1
	if passes==0:
		global_position=enemy2.global_position
		passes=1
		HEDEF=(hedef.global_position)+Vector2(rand_range(-20,20),rand_range(-20,20))
	if stop==false and not(on_reflect) :
		c = HEDEF -enemy2.global_position
		$AnimatedSprite.play("blast")
		tetikleme=false
		global_position += c.normalized()*delta *ammo_velocity
		$Light2Dasds.rotation=atan(c.normalized().y/c.normalized().x)
		$Light2Dasds2.rotation=atan(c.normalized().y/c.normalized().x)
		rotation=atan(c.normalized().y/c.normalized().x)
#		$CollisionShape2D.rotation=$AnimatedSprite.rotation+(PI/2)
		if hedef.global_position.x<get_parent().get_parent().get_parent().get_node("Node2D").global_position.x:
			$Light2D.position.x=-16
			$AnimatedSprite.flip_h=true
		else:
			$AnimatedSprite.flip_h=false
			$Light2D.position.x=16
		if  a>18.5 or $yerde.is_colliding()==true or  $in_player.is_colliding() :
			global_position=enemy2.global_position
			a =0 
			$AnimatedSprite/Particles2D.emitting=true
			resetsignal=true
			tetikleme=true
			tetikleme2=true
			patla()
#
func kus():
	get_node("/root/Level1/KinematicBody2D/Camera2D/Layer").set("screen_pause",true)
	get_node("/root/Level1/KinematicBody2D/Camera2D/Layer").set("pause_time",1.4)
func reflect(delta):
	global_position += c.normalized()*delta *1500*-1
func patla():
	queue_free()
	
func _on_arrow1_area_entered(area):
	if area.is_in_group("attack"):
		on_reflect=false
		get_parent().get_parent().get_parent().get_node("fire_pivot").in_reflect=false
		rotation+=PI
		
