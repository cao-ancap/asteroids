extends Panel

const CAO_ANCAP := "Cachorro Anarquista"
const ANIKID := "Anikid"

const NL := "\n"
const DL := "\n\n"

onready var ndCredits := $Credits
onready var ndCloseButton := $CloseButton


func _ready():
	update_text()


func update_text():
	if visible:
		var credit := make_title(tr("Credits")) + DL
		credit += make_title("Asteroids") + NL
		credit += Utils.VERSION + DL
		credit += make_title(tr("Art Design")) + NL
		credit += CAO_ANCAP + NL + ANIKID + DL
		credit += make_title(tr("Sound Design")) + NL
		credit += CAO_ANCAP + DL
		credit += make_title(tr("Programming")) + NL
		credit += CAO_ANCAP + DL
		credit += make_title(tr("Special Thanks")) + NL
		credit += "Nick Curtis - " + tr("Fairfax Station NF Font") + NL
		credit += "Jason Pagura - " + tr("Rutaban Font") + NL
		credit += "Severin Meyer - " + tr("Xolonium Font") + NL
		credit += "GDQuest" + NL
		credit += "Gonkee" + NL

		ndCredits.bbcode_text = center(credit)
	else:
		ndCredits.bbcode_text = ""


func center(text: String) -> String:
	return "[center]" + text + "[/center]"


func make_title(text: String) -> String:
	return "[b]" + text + "[/b]"


func _on_CreditsMenu_visibility_changed():
	update_text()


func _on_CloseButton_pressed():
	hide()
