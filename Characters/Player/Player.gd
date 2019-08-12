extends "res://Characters/Character.gd"

signal moved
signal dead
signal grabbed_key
signal win

func _ready():
    Global.set_Player(self)

func _process(delta):
    if can_move:
        for dir in moves.keys():
            if Input.is_action_pressed(dir):
                if move(dir):
                    emit_signal("moved")

func hurt():
    set_process(false)
    $CollisionShape2D.disabled = true
    $AnimationPlayer.play("die")
    yield($AnimationPlayer, 'animation_finished')
    emit_signal('dead')

func _on_Player_area_entered(area):
    if area.is_in_group('enemies'):
        area.hide()
        hurt()
  
    if area.is_in_group('pickups'):
        area.pickup()
        if area.type == 'key_red':
            emit_signal('grabbed_key')
        if area.type == 'star':
            emit_signal('win')


