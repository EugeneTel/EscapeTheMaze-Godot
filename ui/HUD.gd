extends CanvasLayer

func _ready():
    Global.set_HUD(self)

func set_score(score):
    $MarginContainer/ScoreLabel.text = str(score)