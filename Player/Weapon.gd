extends Node

class_name Weapon

export var fire_rate = 0.05
export var battery_size = 30
export var reload_rate = 1
export var automatic = false

onready var battery_label = $"/root/Spatial World/UI/Ammo counter"

onready var raycast = $"../Head/Camera/RayCast"

var current_plasma = battery_size
var can_fire = true
var reloading = false

func _ready():
	current_plasma = battery_size

func _process(delta):
	if reloading:
		battery_label.set_text("Changing batteries...")
	else:
		battery_label.set_text("%d / %d" % [current_plasma, battery_size])
	if current_plasma > 0 and not reloading:
		if Input.is_action_pressed(("primary_fire")) and can_fire and automatic:
			fire()
		elif Input.is_action_just_pressed(("primary_fire")) and can_fire and automatic == false:
			fire()
	
	if Input.is_action_just_pressed("reload") and not reloading:
		reload()

func check_collision():
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if  collider.is_in_group("Enemies"):
			collider.queue_free()
			print("Oof'd " +  collider.name)
func fire():
		print("Pew!")
		can_fire = false
		current_plasma -= 1
		check_collision()
		yield(get_tree().create_timer(fire_rate), "timeout")
		
		can_fire = true

func reload():
	print("Reloading...")
	reloading = true
	yield(get_tree().create_timer(reload_rate), "timeout")
	current_plasma = battery_size
	reloading = false
	print("Reload Complete")
