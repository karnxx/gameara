extends VBoxContainer

var start = "START"
var cred = "CREDITS"
var quit = "QUIT"


func _on_starts_focus_entered() -> void:
	$starts.text = ">START"

func _on_starts_focus_exited() -> void:
	$starts.text = "START"

func _on_starts_mouse_entered() -> void:
	$starts.text = ">START"

func _on_starts_mouse_exited() -> void:
	$starts.text = "START"

func _on_credits_focus_entered() -> void:
	$credits.text = ">CREDITS"

func _on_credits_focus_exited() -> void:
	$credits.text = "CREDITS"

func _on_credits_mouse_entered() -> void:
	$credits.text = ">CREDITS"

func _on_credits_mouse_exited() -> void:
	$credits.text = "CREDITS"


func _on_quit_focus_entered() -> void:
	$quit.text = ">QUIT"

func _on_quit_focus_exited() -> void:
	$quit.text = "QUIT"

func _on_quit_mouse_entered() -> void:
	$quit.text = ">QUIT"

func _on_quit_mouse_exited() -> void:
	$quit.text = "QUIT"
