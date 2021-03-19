extends Control


func _on_Resume_pressed():
	get_tree().paused = false
	visible = false

func _on_Quit_pressed():
	get_tree().quit()
