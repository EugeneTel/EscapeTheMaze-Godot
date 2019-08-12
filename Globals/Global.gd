extends Node

var levels = [
    "res://Levels/Level1.tscn",
    "res://Levels/Level2.tscn"
]
var current_level
var start_screen = 'res://ui/StartScreen.tscn'
var end_screen = 'res://ui/EndScreen.tscn'
var score_file = 'user://highscore.txt'
var score
var highscore = 0
var HUD
var Player

func _ready():
    setup()

func setup():
    var f = File.new()
    if f.file_exists(score_file):
        f.open(score_file, File.READ)
        var content = f.get_as_text()
        highscore = int(content)
        f.close()

func set_HUD(_hud):
    HUD = _hud
    HUD.set_score(score)

func set_Player(_player):
    Player = _player
    Player.connect('dead', self, 'game_over')

func update_score(num):
    print('coin pickup global')
    score += num
    HUD.set_score(score)

func new_game():
    current_level = -1
    score = 0
    next_level()
    
func game_over():
    if score > highscore:
        highscore = score
        save_score()
    
    get_tree().change_scene(end_screen)

func save_score():
    var f = File.new()
    f.open(score_file, File.WRITE)
    f.store_string(str(highscore))
    f.close()
    
func next_level():
    current_level += 1
    if current_level >= Global.levels.size():
        game_over()
    else:
        get_tree().change_scene(levels[current_level])