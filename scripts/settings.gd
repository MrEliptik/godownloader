extends ScrollContainer

onready var dir_path = $ContentMargin/VBoxContainer/GodotInstalls/HBoxContainer/DirPath

func _ready() -> void:
	# TODO: handle multiple paths
	dir_path.text = Globals.install_path
