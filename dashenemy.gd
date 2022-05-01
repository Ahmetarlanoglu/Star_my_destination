extends KinematicBody2D
var sol=2
var beta=1
var alfa=0
var dashbitti=false
var deltam2=0
var animasyonpass=true
var c=1
var dead2=false
var fark
var flip_stop=false
var duroc
var deltam=0
var speed=0
var dash_speed=1200
var saniye=0
var asdfa=260
var b=1
var death_speed=550
var das=true
var dead=false
var blood =preload ("res://assets/blast_drones/bilad3.tscn")
var dashing=false
var cut=false
onready var player = get_node("/root/Level1/KinematicBody2D")
onready var timer = get_node("Timer")
var konum=Vector2()
var aniss=true
# Called when the node enters the scene tree for the first time.
func _ready():
	timer.set_wait_time(0.1)
	$AnimatedSprite.flip_h=true
func _process(delta):
	fark=player.global_position.x-global_position.x
	player.camera_hit=false
	if das:
		move(delta)
	else:
		death_speed=asdfa*c*-1
		asdfa-=delta*200
		speed=death_speed
	cut=false
	if dead:
		das=false
		$AnimatedSprite.play("death")
		sol=5
		$Area2D/CollisionShape2D.disabled=true
	if dead2==true:
		set_process(false)
		visible=false
		set_process_internal(false)
	flip()
	
	player.beta =beta
	player.cut=false
	konum.x=speed
	konum.y=500
	konum = move_and_slide(konum,Vector2(0,-1))
func _on_Timer_timeout():
	alfa+=1
	saniye+=2
func _on_Area2D_area_entered(area):
	if $Position2D/sa.is_colliding():
		player.beta=1
	if $Position2D/sol.is_colliding():
		player.beta=-1
	if area.is_in_group("playergroups") and player.dashing==false:
		cut=true
		player.cut=true
	if (area.is_in_group("attack") and player.dashing==true) :#ÖLÜM
		dead=true
		get_node("/root/Level1/KinematicBody2D/Camera2D/Layer").set("start_cronic_vibration",true)
		get_node("/root/Level1/KinematicBody2D/Camera2D/Layer/suluboya").modulate.b=0.8
		
		$deathtimer.start()
		var blood_intance=blood.instance()
		get_tree().current_scene.add_child(blood_intance)
		blood_intance.global_position=global_position
		blood_intance.rotation=global_position.angle_to_point(player.global_position)
		blood_intance.process_material.set_shader_param("bound",global_position.y+70)
	if area.is_in_group("dhit") :
		
		var blood_intance=blood.instance()
		get_tree().current_scene.add_child(blood_intance)
		blood_intance.global_position=global_position
		blood_intance.rotation=global_position.angle_to_point(player.global_position)
		blood_intance.process_material.set_shader_param("bound",global_position.y+70)
		get_node("/root/Level1/KinematicBody2D/Camera2D/Layer").set("start_cronic_vibration",true)
		queue_free()

func move(delta):
	if 1500>abs(fark) and abs(fark) >450:
		if aniss:
			aniss=false
			$AnimatedSprite.play("fire")
		else:
			$AnimatedSprite.play("fire2")
			$PushArea.fire=true
		
	else:
		$PushArea.fire=false
	if abs(fark)<400 and abs(player.global_position.y-global_position.y)<200 :
		if player.global_position.x<global_position.x:
			speed=-200
			if animasyonpass==true:
				$AnimatedSprite.play("run1")
#			if flip_stop==false:
#				$AnimatedSprite.flip_h=true
			c=-1
		elif global_position.x<player.global_position.x:
			speed=200
			if animasyonpass==true:
				$AnimatedSprite.play("run1")
#			if flip_stop==false:
#				$AnimatedSprite.flip_h=false
			c = 1
	else:
		speed=0
		if animasyonpass==false:
			$AnimatedSprite.play("idil1")
	if abs(fark)<450 and abs(player.global_position.y-global_position.y)<200 :
		if player.global_position.x<global_position.x:
			sol=1
		elif global_position.x<player.global_position.x:
			sol=0
	if sol==0 or sol==1:
		if b==1:
			timer.start()
			b=0
		saniye%=40
		if saniye>0 and saniye<18:
			speed=0
			deltam2+=delta*0.08
			$AnimatedSprite.play("idil1")
			$AnimatedSprite.self_modulate.g = lerp($AnimatedSprite.self_modulate.g ,0,deltam2)
			dashbitti=false
#			if c==1:
#				beta=1
#				$AnimatedSprite.flip_h=false
#				$Sprite.flip_h=false
#			if c== -1:
#				beta=-1
#				$AnimatedSprite.flip_h=true
#				$Sprite.flip_h=true
		elif saniye>18 and saniye<28:
			flip_stop=true
			$AnimatedSprite.play("atak2")
			
			animasyonpass=false
#			if player.in_dash==true:
#				modulate.a=1
			$AnimatedSprite.self_modulate.g=1.0
			$AnimatedSprite/AnimationPlayer.play("dash slash")
			deltam2=0
			player.dash_enemy_dashing=true
			deltam+=delta*0.2
			$AnimatedSprite.self_modulate.a = lerp($AnimatedSprite.self_modulate.a,0,deltam)
			speed = 1500*beta
#			if beta==1 and global_position.x-player.global_position.x<-100:
#				dashbitti=true
#			if beta==-1 and global_position.x-player.global_position.x>100:
#				dashbitti=true
		if (saniye>28 and saniye<31) :
			sol=2
			flip_stop=false
			player.dash_enemy_dashing=false
			animasyonpass=true
			deltam=0
			$AnimatedSprite.self_modulate.a=1.0
			dashbitti=false
func flip():
	if fark>0:
		$AnimatedSprite.flip_h=false
		$AnimatedSprite.position.x=13
		$PushArea.yon=1
	else:
		$AnimatedSprite.flip_h=true
		$PushArea.yon=-1
		$AnimatedSprite.position.x=-33

func _on_deathtimer_timeout():
	dead2=true
