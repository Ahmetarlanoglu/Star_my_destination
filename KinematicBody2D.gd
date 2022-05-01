extends KinematicBody2D
var a=0.0001
var memory = Vector2()
var konum = Vector2()
var gravity = 30
var speed = 0
var jump1= 1500
var animasyon=0
var jump2 = 600
var yon=0
var ghost_counter=1
var test=0
var dash_factor=1
var saniye=0             
var dir=3
var dashbitti=0
var dashbitti2=0
var hak=0
var yer = false
var ghost_scene =preload("res://assets/dash_sprite.tscn")
var sinyalkonum= Vector2()
var opak = 1.0
var saydam=0.0
var dash_direction
var cut=false
var beta=1
var animasyon_durdurucu=false
var dashing=false
var can=2
var dead=false


onready var vur = get_node("deatharea")
var ivmelenme =20
var keke
onready var ekranlayerim=get_node("Camera2D/Layer/ColorRect")
var gir =0
var in_dash=false
var dash_enemy_dashing=false
var asdf
var dash_cooldown_pass=1
var dash_counter=300
var hit_move_block=0

export var jump_height=2122
export var jump_topeak=2
export var jump_todescent=2

onready var jump_velocity :float=(2.0*jump_height)/ jump_topeak*-1
onready var jump_gravity :float=(-2.0*jump_height)/ (jump_topeak* jump_topeak)*-1
onready var fall_gravity :float=(-2.0*jump_height)/ (jump_todescent* jump_todescent)*-1
onready var sprite =$AnimatedSprite
onready var joystick = $CanvasLayer/Sprite/JoyStickButton
onready var timer = $Dash_Timer
onready var decor = get_node("/root/Level1/decor")
onready var dash_enemy=get_parent().get_node("dashenemy2")
onready var enemy = get_node("/root/Level1/enemy")
#onready var lifebar = get_node("root/Level1/CanvasLayer/MarginContainer/HBoxContainer/TextureProgress")
func get_gravity() -> float:
	return jump_gravity if konum.y<0.0 else fall_gravity
func instance_ghost():
	var ghost:Sprite=ghost_scene.instance()
	get_parent().add_child(ghost)
	var current_frame_index=sprite.frame
	var frame=sprite.frames.get_frame("run",current_frame_index)
	ghost.texture=frame
	ghost.offset.y-=5
	ghost.global_position=global_position
#	ghost.texture=sprite.
#	ghost.vframes=sprite.vframes
#	ghost.hframes=sprite.hframes
#	ghost.frame=sprite.frame
	ghost.flip_h=sprite.flip_h
	ghost.scale.y = 2.415
	ghost.scale.x = 2.915
#func _ready():
#	timer.set_wait_time(0.01)
#	timer.start()
#
func _process(delta):
	konum.y+=get_gravity()*delta
	test+=1
	
	if is_instance_valid( get_node("/root/Level1/enemy/PushArea/arrow1")):
		var OK =get_node("/root/Level1/enemy/PushArea/arrow1")
		if OK.resetsignal==true:
			sinyalkonum=global_position
		if $deatharea.c==1:
			$GATSU.material.set_shader_param("alfakanal", opak)
			if enemy.sag==true:
				speed= -400
				yon= 1
			if enemy.sag==false:
				speed=200
				yon=1
		else:
			$GATSU.material.set_shader_param("alfakanal", saydam)
	else:
		$GATSU.material.set_shader_param("alfakanal", saydam)
	dash_factor=6
	konum.y += gravity
	konum.x = joystick.get_value().x*8.2
	dash_counter+=delta*380
	if dash_counter>300:
		dash_cooldown_pass=1
	else:
		dash_cooldown_pass=0
	
	if Input.is_action_just_pressed("dash") and dash_cooldown_pass==1:
		gir=1
		

		in_dash=true
		dash_counter=0
		$Dashy.start()
		dashbitti=0
	if Input.is_action_just_released("dash") and gir ==1:
		gir=2
		in_dash=false
		
		timer.start()
	if gir==1:#adsf/////////////////////////////////////////////////////
		Engine.time_scale=0.1
		asdf=joystick.get_value().y/joystick.get_value().x
		rotation=atan(asdf)*0.2
#		asdf=joystick.get_value().y/joystick.get_value().x
#		rotation=atan(asdf)
		konum.y=joystick.get_value().y*30
		decor.visible=true
		#$Camera2D/Layer/ColorRect.material.set_shader_param("in_motion",1.0)
		if dashbitti==1:
			gir=2
			timer.start()
			saniye=0
			
		#dash_factor=100
	if gir ==2  :
		
		Engine.time_scale=1.0
		$AnimatedSprite.play("adash6")
		animasyon_durdurucu=true
		dashing=true
		#$Camera2D/Layer/ColorRect.material.set_shader_param("in_motion",0.0)
		decor.visible=false
		if saniye==1 :
			gir=3
			
			$yirmaga.start()
			dashbitti2=0
			dash_direction=joystick.get_value()
	if gir==3  :#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
		ghost_counter+=1
		
		if ghost_counter==4:
			instance_ghost()
			ghost_counter-=4
		dash_factor=40
		saniye=0
		konum=dash_direction*20
		if dashbitti2==1:
			gir=0
			rotation=0
			dashing=false
			animasyon_durdurucu=false
#			$AnimatedSprite.play("run")
	if joystick.get_value().x>0.1:
		yon=1
		
		if is_on_floor():
			$AnimatedSprite.play("run")
	elif joystick.get_value().x<0:
		yon=-1
		if is_on_floor() and animasyon_durdurucu==false:
			$AnimatedSprite.play("run")
	else:
		if is_on_floor() and animasyon_durdurucu==false:
			$AnimatedSprite.play("idle")
	

	
	if $deatharea.dead==true:
		self.position=Vector2(0,-200)
		$deatharea.dead=false
		$deatharea.can=100
	memory=Vector2(0,0)
#	if vur.du==true:
#		saniye+=1
#		konum.x +=(-7000+saniye )
#		konum.y -= 600
	if Input.is_action_just_pressed("ui_up"):
		if animasyon_durdurucu==false:
			$AnimatedSprite.play("jump")
		
		if yer == true:
			konum.y = jump_velocity # KONUMYEEEEEEEEEEEEEEEEEEEEEEEEE
			hak =1
		if yer == false and hak==1:
			konum.y += -jump2
			hak=0
			
	memory=global_position
#	if test==10:
#		print(konum)
#		test-=10
	if hit_move_block==2:
		konum.x=0
		

	if hit_move_block==1:
		hit_move_block+=1
		
	if cut==true and dash_enemy_dashing==true:
		konum.y=-700
		$deatharea.can-=20
		$AnimatedSprite.play("hit2")
		konum.x=beta*4000
		hit_move_block+=1
		$hit_timer.start()
		
	
	konum = move_and_slide(konum,Vector2(0,-1))
	if Input.is_action_pressed("fire"):
#		$sword/slash.play("offset")
		$AnimatedSprite.play("dash4")
	update_animation() 
	if is_on_floor():
		yer = true
	else:
		yer = false
	
func update_animation() :

	if is_on_floor():
		if yon==1:
			$AnimatedSprite.flip_h= false
			$AnimatedSprite.offset.x=15
			$fire/firee.position.x=100

		elif yon==-1:
			$AnimatedSprite.flip_h= true
			$AnimatedSprite.offset.x=-5
			$fire/firee.position.x=-100
			
	else:
		if yon==1:
			$AnimatedSprite.flip_h= false
			$AnimatedSprite.offset.x=15
		elif yon==-1:
			$AnimatedSprite.flip_h= true
			$AnimatedSprite.offset.x=-5

var te =yon
#func _on_Dash_Timer_timeout():
#	saniye=1
func _on_Dashy_timeout():
	dashbitti=1
func _on_yirmaga_timeout():
	dashbitti2=1

func _on_Dash_Timer_timeout():
	
	saniye=1
func _on_hit_timer_timeout():
	hit_move_block=0
#	$AnimatedSprite.play("idle")


func _on_AnimatedSprite_animation_finished():
	animasyon-=1
