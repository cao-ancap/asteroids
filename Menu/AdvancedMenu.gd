extends Control

signal dynamic_background_enabled(enabled)

const laguages := [
	{"code": "pt_BR", "name": "Português (Brasil)"},
	{"code": "en_US", "name": "English (United States)"}
]

func _ready():
	for laguage in laguages:
		$LanguageButton.add_item(laguage["name"])

	select_language(0)

func _on_LanguageButton_item_selected(index: int):
	 select_language(index)


func select_language(index: int):
	if laguages.size() > index:
		TranslationServer.set_locale(laguages[index]["code"])


func _on_CloseButton_pressed():
	hide()


func _on_BackgroundButton_toggled(enabled: bool):
	emit_signal("dynamic_background_enabled", enabled)
	

