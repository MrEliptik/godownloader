extends Node

enum TYPE {STABLE, RC, BETA, ALPHA, PRE_ALPHA}

var version = {
	"path": "",
	"version": "",
	"type": TYPE.STABLE
}

var launch_startup: bool = true
var check_update_auto: bool = true
var godot_versions = []

var available_versions = []
