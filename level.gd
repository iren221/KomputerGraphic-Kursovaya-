extends Node2D

@onready var level_text = $CanvasLayer/NumberLevel
@onready var animPlayer = $CanvasLayer/AnimationPlayer

func _ready():
	level_text_fade()

func level_text_fade():
	animPlayer.play("level_text_fade_in")
	await get_tree().create_timer(3).timeout
	animPlayer.play("level_text_fade_out")
