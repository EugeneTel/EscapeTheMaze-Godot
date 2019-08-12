extends Area2D

signal coin_pickup

var textures = {
    'coin': "res://assets/coin.png",
    'key_red': "res://assets/keyRed.png",
    'star': "res://assets/star.png"
}
var type


func _ready():
    $Tween.interpolate_property($Sprite, 'scale', Vector2(1, 1),
        Vector2(2, 2), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
    $Tween.interpolate_property($Sprite, 'modulate',
        Color(0.5, 0.5, 0.5, 0.5), Color(0.5, 0.5, 0.5, 0), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)


func init(_type, pos):
    $Sprite.texture = load(textures[_type])
    type = _type
    position = pos


func pickup():
    match type:
        'coin':
            print('coin pickup signal')
            emit_signal('coin_pickup', 1)
            
    $CollisionShape2D.disabled = true
    $Tween.start()


func _on_Tween_tween_all_completed():
    queue_free()
