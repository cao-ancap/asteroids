class_name ScoreService
extends Node

signal get_request_completed(result, response_code, headers, body)
signal post_request_completed(result, response_code, headers, body)

const SERVER := "https://modular-server.onrender.com/score"
const CONNECT_ERROR := "An error occurred at event connect."
const HTTP_ERROR := "An error occurred in the HTTP request."

const COEFFICIENT := 1000000


func create_signed_dict(dict: Dictionary) -> Dictionary:
	dict["_n"] = randi()
	dict["_h"] = salt_hash(dict)
	return dict


func salt_hash(dict: Dictionary) -> String:
	var o := dict.duplicate()
	o["_n"] = calc_salt(o["_n"] if o["_n"] and o["_n"] != 0 else 249)
	o["_ns"] = calc_salt(4651)
	o["_ts"] = "dfjksduhajsnduygzyxndcowicxzujnqwbfuygysc"
	return JSON.print(o).sha256_text()


func calc_salt(n: float) -> String:
	var x := int(sin(n) * COEFFICIENT)
	var ac := acos(n) if n > -1 and n < 1 else acos(1 / n)
	var aci := int(ac * COEFFICIENT)
	return str(x + aci)


func send_score(data_to_send: Dictionary):
	make_post_request(SERVER, create_signed_dict(data_to_send))


func get_scores():
	make_get_request(SERVER)


func make_post_request(url: String, data_to_send: Dictionary, use_ssl := true):
	var request_data := JSON.print(data_to_send)
	var headers := ["Content-Type: application/json"]
	var http_request := HTTPRequest.new()
	add_child(http_request)
	var error := http_request.connect("request_completed", self, "_on_post_request_completed")
	if error != OK:
		push_error(CONNECT_ERROR)
	error = http_request.request(url, headers, use_ssl, HTTPClient.METHOD_POST, request_data)
	if error != OK:
		push_error(HTTP_ERROR)


func _on_post_request_completed(result, response_code, headers, body):
	emit_signal("post_request_completed", result, response_code, headers, body)


func make_get_request(url: String):
	var http_request := HTTPRequest.new()
	add_child(http_request)
	var error := http_request.connect("request_completed", self, "_on_get_request_completed")
	if error != OK:
		push_error(CONNECT_ERROR)
	error = http_request.request(url)
	if error != OK:
		push_error(HTTP_ERROR)


func _on_get_request_completed(result, response_code, headers, body):
	emit_signal("get_request_completed", result, response_code, headers, body)
