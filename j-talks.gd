extends Control

var org: OrgNode
var org_dir = 'res://wip/dealing-cards/'

onready var chunks = $HBox/ChunkList
onready var outline = $HBox/Outline
onready var editor = $HBox/Editor
onready var prompter = $Panel/Prompter
onready var wavepanel = $WaveformPanel
onready var timeline = $TimeLine/HBox

const bytesPerSample = 2
const channels = 2
const mixRate = 44100.0
func hms(samples)->String:
	# time in seconds:
	var time = samples/(channels * bytesPerSample * mixRate)
	var mm = int(floor(time/60))
	var hh = int(floor(mm/60)); mm %= 60
	var ss = fmod(time,60)
	return "%02d:%02d:%02.3f" % [hh,mm,ss]

func _ready():
	org = Org.from_path(org_dir+"dealing-cards.org")
	chunks.org_dir = org_dir
	chunks.connect("audio_chunk_selected", self, "_on_audio_chunk_selected")
	outline.connect("node_selected", self, "_on_headline_selected")
	outline.set_org(org)
	# load_timeline()
	# dump_org_file()

func load_timeline():
	# visually show all the clips in a timeline view
	# (disabled for now because it's very slow)
	var i = 0
	var total = 0
	var cur = OrgCursor.new(org)
	var track_names = Org.Track.keys()
	while true:
		var chunk = cur.next_chunk()
		if chunk: print("chunk:", track_names[chunk.track])
		if chunk == null: break
		if chunk.track != Org.Track.AUDIO: continue
		if chunk.file_exists(org_dir):
			var wav = org_dir+chunk.suggest_path()
			var sam : AudioStreamSample = AudioLoader.loadfile(wav)
			var rect = Waveform.new()
			rect.color = Color.beige if i % 2 else Color.bisque; i += 1
			rect.rect_min_size = Vector2(sam.data.size() * 0.0005,64)
			if i < 10: rect.sample = sam
			rect.timeScale = 512
			timeline.add_child(rect)
			total += sam.data.size()
			print(chunk.index, ' ', wav, ' ', hms(sam.data.size()))
		else: print("not there: ", chunk.suggest_path())

	var wav = Waveform.new()
	print("total size: ", total)
	var timeScale = 128
	var bytesPerSample = 4
	print("total length: ", hms(total))

func dump_org_file():
	# for testing that the file has not changed
	var f = File.new()
	f.open("res://wip/dealing-cards/dealing-cards.txt", File.WRITE)
	f.store_string(org.to_string())
	f.close()


func _on_headline_selected(org):
	chunks.set_org(org)
	if org != null: editor.text = org.slide_text()

func _on_audio_chunk_selected(chunk:OrgChunk):
	prompter.text = chunk.lines_to_string()
	wavepanel.edit_path(org_dir + chunk.suggest_path())
