extends Node

enum TYPE {STABLE, RC, BETA, ALPHA, PRE_ALPHA}

var TYPE_TO_STRING = {
	TYPE.STABLE: "stable",
	TYPE.RC: "rc",
	TYPE.BETA: "beta",
	TYPE.ALPHA: "alpha",
	TYPE.PRE_ALPHA: "dev"
}

var version = {
	"path": "",
	"version": "",
	"type": TYPE.STABLE
}

var install_path: String = ""
var setup_complete: bool = false

var launch_startup: bool = true
var check_update_auto: bool = true
var auto_delete_install_file: bool = true
var godot_versions = []

var available_versions = []
