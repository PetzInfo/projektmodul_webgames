extends Node2D

@onready var width: = get_viewport_rect().size.x
@onready var height: = get_viewport_rect().size.y

var platform: = preload("res://objects/platform.tscn")

var platformCount: = 5
var platforms: = []
@onready var treshold: = height * 0.5
var scrollSpeed = 0.05


@onready var player: = $Player
@onready var platformParent: = $Platforms
@onready var background:Sprite2D = $"ParallaxBackground/ParallaxLayer/Sprite2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	player.global_position.y = treshold
	for i in platformCount:
		var inst: = platform.instantiate()
		inst.global_position.y = height / platformCount * i
		inst.global_position.x = randf_range(20.0, width - 20.0)
		
		platformParent.add_child(inst)
		platforms.append(inst)
	
	platforms.back().global_position.x = player.global_position.x


func _physics_process(delta):
	
	if player.global_position.y < treshold:
		var move:float = lerp(0.0, treshold -player.global_position.y, scrollSpeed)
		move_background(move)
		player.global_position.y += move
		for plat in platforms:
			plat.global_position.y += move
			if plat.global_position.y > height:
				plat.global_position.y -= height
				plat.global_position.x = randf_range(20.0, width - 20.0)
	if player.global_position.y > height:
		game_over()

func move_background(move:float)->void:
	var ratio: = 0.75
	background.global_position.y = fmod((background.global_position.y +height +move*ratio), height) - height

func game_over()->void:
	get_tree().reload_current_scene()
