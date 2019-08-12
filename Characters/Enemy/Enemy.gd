extends "res://Characters/Character.gd"

func _ready():
    can_move = false
    set_rand_facing()
    yield(get_tree().create_timer(0.5), 'timeout')
    can_move = true

func _process(delta):
    if can_move:
        if not move(facing) or randi() % 10 > 5:
            set_rand_facing()

func set_rand_facing():
    facing = moves.keys()[randi() % 4]
