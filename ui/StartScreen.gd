extends Control

func _ready():
    if Global.highscore > 0:
        $CenterContainer/VBoxContainer/ScoreNotice.text = "Hight Score: " + str(Global.highscore)

func _input(event):
    if event.is_action_pressed('ui_select'):
        Global.new_game()