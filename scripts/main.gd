extends Node2D
@export var tree_scene: PackedScene
@export var min_spawn_time: float = 1
@export var max_spawn_time: float = 4.0
@onready var spawn_timer: Timer = $spawntimer
@onready var spawn_marker: Marker2D = $spawn_point
@onready var movement: AnimationPlayer = $Ground/ground/movement
@onready var retry: Button = $Control/retry
@onready var game_start: Label = $CenterContainer/start
@onready var score: Label = $score
@onready var final_score: Label = $final_score



var start=false
var Score=0
var Final_score=0

func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	set_random_timer()
	retry.hide()
	game_start.show()
	score.hide()
	final_score.hide()


func _process(delta: float) -> void:
	score.text=str(Score)















func _on_spawn_timer_timeout() -> void:
	spawn_tree()
	set_random_timer()

func spawn_tree() -> void:
	if  tree_scene and  start:
		var tree = tree_scene.instantiate()
		tree.death.connect(die)
		
		# FIX: Instead of hardcoded numbers, use the Marker2D's global position
		tree.global_position = spawn_marker.global_position
		
		add_child(tree)
		
	else:
		return

func set_random_timer() -> void:
	var random_time = randf_range(min_spawn_time, max_spawn_time)
	spawn_timer.wait_time = random_time
	spawn_timer.start()
	
func die():
	get_tree().paused=true	
	start=false
	retry.show()
	score.hide()
	Final_score=Score
	final_score.text="SCORE:"+str(Final_score)
	final_score.show()
	
	
	


func _on_dino_start() -> void:
	movement.play("movement")
	start=true
	game_start.hide()
	score.show()


func _on_retry_pressed() -> void:
	get_tree().paused=false
	get_tree().reload_current_scene()
	


func _on_score_updater_timeout() -> void:
	Score+=1
