# res://scripts/generate_puzzle.gd
extends Node

# 设置资源路径和切割参数
const SOURCE_IMAGE := preload("res://assets/puzzle_source.png")
const SAVE_PATH := "res://assets/puzzle/"
const TILE_SIZE := Vector2i(102, 102)
const GRID_WIDTH := 5
const GRID_HEIGHT := 5

func _ready():
	print("开始生成 AtlasTexture 拼图块...")
	for y in range(GRID_HEIGHT):
		for x in range(GRID_WIDTH):
			var atlas_tex := AtlasTexture.new()
			atlas_tex.atlas = SOURCE_IMAGE
			atlas_tex.region_enabled = true
			atlas_tex.region = Rect2(x * TILE_SIZE.x, y * TILE_SIZE.y, TILE_SIZE.x, TILE_SIZE.y)

			# 生成文件名，例如：puzzle_piece_0.tres
			var index := y * GRID_WIDTH + x
			var file_path := SAVE_PATH + "puzzle_piece_%d.tres" % index
			ResourceSaver.save(atlas_tex, file_path)
			print("✔ 生成：", file_path)

	print("✅ 所有拼图块已生成完成！")
