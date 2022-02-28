extends Control

var org_dir = 'res://wip/dealing-cards/'

onready var chunks = $HBox/ChunkList
onready var outline = $HBox/Outline
onready var editor = $HBox/Editor
onready var prompter = $Panel/Prompter
onready var wavepanel = $WaveformPanel

func _ready():
	var org = Org.from_path("res://wip/dealing-cards/dealing-cards.org")
	var f = File.new()
	f.open("res://wip/dealing-cards/dealing-cards.txt", File.WRITE)
	f.store_string(org.to_string())
	f.close()

	chunks.org_dir = org_dir
	chunks.connect("audio_chunk_selected", self, "_on_audio_chunk_selected")
	outline.connect("node_selected", self, "_on_headline_selected")
	outline.set_org(org)

func _on_headline_selected(org):
	chunks.set_org(org)
	if org != null: editor.text = org.slide_text()

func _on_audio_chunk_selected(chunk:OrgChunk):
	prompter.text = chunk.lines_to_string()
	wavepanel.edit_path(org_dir + chunk.suggest_path())
