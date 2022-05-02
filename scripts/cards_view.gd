extends ScrollContainer

export var card_scene: PackedScene = preload("res://scenes/card.tscn")

onready var latest_version = $ContentMargin/VBoxContainer/LatestVersion
onready var installed = $ContentMargin/VBoxContainer/Installed

func _ready() -> void:
	pass

func _on_Setup_finish() -> void:
	for version in Globals.godot_versions:
		var instance = card_scene.instance()
		instance.path = version["path"]
		instance.version = version["version"]
		instance.type = version["type"]
		instance.installed = true
		installed.add_child(instance)
