extends Area2D
var b =false
var c
var d
var eim
var g = Vector2()
var ivme=260
var a=0
var le
var tetikleme=true
var tetikleme2=true
var resetsignal=false
var stop=false

onready var inleft = get_node("/root/Level1/enemy2/RightRay")
onready var detection = get_node("/root/Level1/enemy2/detection_ray")
onready var hedef = get_node("/root/Level1/KinematicBody2D")
onready var yokolma = get_node("/root/Level1/KinematicBody2D/deatharea")
onready var enemy2 = get_node("/root/Level1/enemy2")

func _ready():
	pass # Replace with function body.
#func _process(delta):
#
#
#	if abs(ivme) <450:
#		ivme=450
#	if abs(ivme)>800:
#		ivme=800
#	resetsignal=false
#	a += (delta *1000)/abs(ivme)
#	stop=false
#	if detection.is_colliding()==true and tetikleme==true :
#		stop=true
#	if stop==false:
#		c = hedef.sinyalkonum.x - global_position.x
#		d = hedef.sinyalkonum.y - global_position.y
#		eim=d/c
#
#		g=Vector2(hedef.sinyalkonum.x-10,hedef.sinyalkonum.y-(10*eim))
#		ivme =g.x-enemy2.memory.x
#		tetikleme=false
#		global_position = enemy2.memory.linear_interpolate(g, a)
#		if a>2.5 or yokolma.bacin==true or $yerde.is_colliding()==true:
#			global_position=enemy2.memory
#			a =0 
#			$Particles2D.emitting=true
#			resetsignal=true
#			tetikleme=true
#			tetikleme2=true
		
		#enemy.memory input alternatif
		#if yokolma.c==true:
			#$"ok".modulate = Color(0,0,0,1)
		
		
