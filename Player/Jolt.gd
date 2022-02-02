extends Weapon

export var fire_range = 25


func _ready():
	raycast.cast_to = Vector3(0,0,-fire_range)
	fire_rate = 0.25
	reload_rate = 1.25
	battery_size = 10
