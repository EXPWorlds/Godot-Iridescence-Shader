extends MeshInstance


func _process(delta):
	rotate_y(PI / 4.0 * delta)
