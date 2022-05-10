extends Node

enum TYPE {STABLE, RC, BETA, ALPHA, PRE_ALPHA}

var version = {
	"path": "",
	"version": "",
	"type": TYPE.STABLE
}

var install_path: String = ""
var setup_complete: bool = false

var launch_startup: bool = true
var check_update_auto: bool = true
var godot_versions = []

var available_versions = []
