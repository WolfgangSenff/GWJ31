extends CanvasLayer

var ships = ["WASP", "HORNET", "SHIRE", "SCOUT", "FANG"]
var choice = 0
var maxChoices: int

onready var shipList = $ShipMenu/CenterContainer/VBoxContainer/MarginContainer

func _ready():
    maxChoices = shipList.get_children().size() - 1

func _on_Credits_pressed():
    $MainMenu.visible = false
    $CreditsMenu.visible = true
    
func _input(event):
    if $CreditsMenu.visible and event.is_action_pressed("ui_accept"):
        $MainMenu.visible = true
        $CreditsMenu.visible = false


func _on_Start_pressed():
    $MainMenu.visible = false
    $ShipMenu.visible = true


func _on_Left_pressed():
    $ShipMenu/CenterContainer/VBoxContainer/HBoxContainer/Right.disabled = false
    shipList.get_child(choice).visible = false
    choice -= 1
    shipList.get_child(choice).visible = true
    if choice == 0:
        $ShipMenu/CenterContainer/VBoxContainer/HBoxContainer/Left.disabled = true


func _on_Cancel_pressed():
    $MainMenu.visible = true
    $ShipMenu.visible = false
    


func _on_Accept_pressed():
    Globals.selectedShip = "res://scenes/ships/" + ships[choice] +".tscn"
    get_tree().change_scene("res://scenes/Galaxy.tscn")


func _on_Right_pressed():
    $ShipMenu/CenterContainer/VBoxContainer/HBoxContainer/Left.disabled = false
    shipList.get_child(choice).visible = false
    choice += 1
    shipList.get_child(choice).visible = true
    if choice == maxChoices:
        $ShipMenu/CenterContainer/VBoxContainer/HBoxContainer/Right.disabled = true
