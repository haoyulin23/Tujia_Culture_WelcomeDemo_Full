extends Node

signal reset_kick_jianzi


func call_reset() -> void:
	reset_kick_jianzi.emit()
