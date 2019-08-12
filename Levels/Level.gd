extends Node2D

export (PackedScene) var Enemy
export (PackedScene) var Pickup

onready var items = $Items
onready var camera = $Player/Camera2D
onready var player = $Player

var doors = []

func _ready():
    randomize()
    $Items.hide()
    set_camera_limits()
    set_doors()
    spawn_items()
    connect_signals()
    
    
func set_doors():
    var door_id = $Walls.tile_set.find_tile_by_name('door_red')
    for cell in $Walls.get_used_cells_by_id(door_id):
        doors.append(cell)


func set_camera_limits():
    var map_size = $Ground.get_used_rect()
    var cell_size = $Ground.cell_size
    camera.limit_left = map_size.position.x * cell_size.x
    camera.limit_right = map_size.end.x * cell_size.x
    camera.limit_top = map_size.position.y * cell_size.y
    camera.limit_bottom = map_size.end.y * cell_size.y


func connect_signals():
    player.connect('grabbed_key', self, '_on_Player_grabbed_key')
    player.connect('win', self, '_on_Player_win')


func spawn_items():
    for cell in items.get_used_cells():
        var id = items.get_cellv(cell)
        var type = items.tile_set.tile_get_name(id)
        var pos = items.map_to_world(cell) + items.cell_size / 2
        
        match type:
            'slime_spawn':
                var s = Enemy.instance()
                s.position = pos
                s.tile_size = items.cell_size
                add_child(s)
            'player_spawn':
                player.position = pos
                player.tile_size = items.cell_size
            'coin', 'key_red', 'star':
                var p = Pickup.instance()
                p.init(type, pos)
                p.connect('coin_pickup', Global, 'update_score')
                add_child(p)

func _on_Player_win():
    print("Player win")
    Global.next_level()


func _on_Player_grabbed_key():
    for cell in doors:
        $Walls.set_cellv(cell, -1)
