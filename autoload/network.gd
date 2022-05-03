extends Node2D

var mirror = "https://downloads.tuxfamily.org/godotengine/"

onready var http_req = $HTTPRequest
onready var download_req = $DownloadReq

var version_regex = RegEx.new()
var type_regex = RegEx.new()

var downloading_version: String = ""


func _ready() -> void:
	version_regex.compile("(?<=>)(?:[0-9]\\.){1,2}[0-9](?=<)")
	type_regex.compile("(?<=-)(.*?)(?=_)")
	
#	get_available_versions()
	
func get_available_versions() -> void:
	http_req.request(mirror)
	yield(http_req, "request_completed")
	
func download_version(version: String) -> void:
	downloading_version = version
	download_req.set_download_file("user://download_tmp_godot_%s.zip" % version)
	download_req.request(mirror+"/"+version+"/Godot_v"+version+"-stable_win64.exe.zip")

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
#	print(body.get_string_from_utf8())
	var res = version_regex.search_all(body.get_string_from_utf8())
	for r in res:
		print(r.get_string())
		Globals.available_versions.append({"version":r.get_string(), "type":Globals.TYPE.STABLE})

func _on_DownloadReq_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	print(result)
	print(response_code)
	if response_code == 200:
		# Load a zip file
		"user://download_tmp_godot_%s.zip" % downloading_version
	
