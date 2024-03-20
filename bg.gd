extends ParallaxBackground

var speed_bg = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.x -= speed_bg * delta
