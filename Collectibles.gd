extends Node2D

var money = preload("res://Collectibles/money.tscn")


func _on_timer_timeout():
	var money_temp = money.instantiate()
	var rng = RandomNumberGenerator.new()
	var rand_int = randi_range(35, 470)
	money_temp.position = Vector2(rand_int, 565)
	add_child(money_temp)
