extends Control

export var notification_scene: PackedScene = preload("res://scenes/notification.tscn")
export var notification_time: float = 4.0

var queue: Array

func _ready() -> void:
	pass

func queue_notification(text: String) -> void:
	var instance = notification_scene.instance()
	instance.text = text
	queue.append(instance)
	
	# Check if timer is already running,
	# if not, we can pop a notification
	if $Timer.time_left > 0: return
	
	$Timer.start(notification_time)
	var inst = queue.pop_front()
	$Container.add_child(inst)
	$Tween.interpolate_property(inst, "rect_position", Vector2(0, 150), Vector2.ZERO, 
		0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()


func _on_Timer_timeout() -> void:
	var notif = $Container.get_child(0)
	if not notif: return
	$Tween.interpolate_property(notif, "modulate", 
		Color(1, 1, 1, 1), Color(1, 1, 1, 0),
		0.4, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.start()
	yield(get_tree().create_timer(0.45), "timeout")
	notif.queue_free()
