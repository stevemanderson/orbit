extends Node

var player_entities = []
var enemy_entities = []

func _ready():
	player_entities.push_back($earth)
	enemy_entities.push_back($enemy_earth)
