extends Panel

signal quited
signal resumed

func _on_ResumeButton_pressed():
	emit_signal("resumed")
	hide()


func _on_QuitButton_pressed():
	emit_signal("quited")
	hide()
