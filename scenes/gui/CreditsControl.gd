extends CanvasLayer

func _on_Credits_pressed():
	$MainMenu.visible = false
	$CreditsMenu.visible = true
	
func _input(event):
	if $CreditsMenu.visible and event.is_action_pressed("ui_accept"):
		$MainMenu.visible = true
		$CreditsMenu.visible = false
