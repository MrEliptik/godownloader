extends Node2D

signal download_progress(progress)
signal download_finished(complete)

var mirror = "https://downloads.tuxfamily.org/godotengine/"

onready var http_req = $HTTPRequest
onready var download_req = $DownloadReq

var version_regex = RegEx.new()
var type_regex = RegEx.new()

var downloading_version: String = ""

var last_download_percent: int = 0
var downloading: bool = false

func _ready() -> void:
	version_regex.compile("(?<=>)(?:[0-9]\\.){1,2}[0-9](?=<)")
	type_regex.compile("(?<=-)(.*?)(?=_)")
	
#	get_available_versions()

func _process(delta: float) -> void:
	if not downloading: return
	var bodySize = download_req.get_body_size()
	var downloadedBytes = download_req.get_downloaded_bytes()
	print("Download: %smb" % str(downloadedBytes/1000000.0))
			
	var percent = ceil(downloadedBytes*100/bodySize)
	if percent > last_download_percent:
		last_download_percent = percent
		emit_signal("download_progress", percent)
	
func get_available_versions() -> void:
	http_req.request(mirror)
	yield(http_req, "request_completed")
	
func download_version(version: String) -> void:
	downloading_version = version
	download_req.set_download_file("user://download_tmp_godot_%s.zip" % version)
	download_req.request(mirror+"/"+version+"/Godot_v"+version+"-stable_win64.exe.zip")
	downloading = true
	last_download_percent = 0

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
		emit_signal("download_finished", true)
	emit_signal("download_finished", false)
	downloading = false
	
	
