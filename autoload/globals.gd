extends Node

enum TYPE {STABLE, RC, BETA, ALPHA, PRE_ALPHA}

var version = {
	"path": "",
	"version": "",
	"type": TYPE.STABLE
}

var install_path: String = ""
var setup_complete: bool = true

var launch_startup: bool = true
var check_update_auto: bool = true
var auto_delete_install_file: bool = true
var godot_versions = []

var available_versions = []
