extends Panel

const cao_ancap := "Cachorro Anarquista"
const anikid := "Anikid"

const nl := "\n"
const dl := "\n\n"

onready var ndCredits := $Credits
onready var ndCloseButton := $CloseButton


func _ready():
	update_text()


func update_text():
	if visible:
		var credit := make_title(tr("Credits")) + dl
		credit += make_title("Asteroids") + nl
		credit += Utils.version + dl
		credit += make_title(tr("Art Design")) + nl
		credit += cao_ancap + nl + anikid + dl
		credit += make_title(tr("Sound Design")) + nl
		credit += cao_ancap + dl
		credit += make_title(tr("Programming")) + nl
		credit += cao_ancap + dl
		credit += make_title(tr("Special Thanks")) + nl
		credit += "Nick Curtis - " + tr("Fairfax Station NF Font") + nl
		credit += "Jason Pagura - " + tr("Rutaban Font") + nl
		credit += "GDQuest" + nl
		credit += "Gonkee" + nl

		ndCredits.bbcode_text = center(credit)


func center(text: String) -> String:
	return "[center]" + text + "[/center]"


func make_title(text: String) -> String:
	return "[b]" + text + "[/b]"


func _on_CreditsMenu_visibility_changed():
	update_text()


func _on_CloseButton_pressed():
	hide()
