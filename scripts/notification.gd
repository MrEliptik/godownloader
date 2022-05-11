extends Control

var text: String = ""

onready var text_label = $MarginContainer/HBoxContainer/Text

func _ready() -> void:
	text_label.text = text

func _on_CloseBtn_pressed() -> void:
	queue_free()
