@tool class_name Rhubarb extends Node

@export var animation_player_nodepath: NodePath = '..'
@export var stream_player_nodepath: NodePath = '../AudioStreamPlayer2D'
@export var character_nodepath: NodePath = '../Michal'
@export var clip: AudioStreamWAV
@export_multiline var text : String
@export_multiline var codes : String
@export var run_rhubarb: bool = false :
	set(x): if x: on_run_rhubarb()

@export var build_animation: bool = false :
	set(x): if x: on_build_animation()

@export_global_dir var rhubarb_dir = "d:/Rhubarb-Lip-Sync-1.12.0-Windows/"
@export_global_dir var temp_dir = "d:/tmp/"
@export var animation_name: String = 'lipsync.000'


func on_run_rhubarb():
	var p = temp_dir + 'rhubarb.txt' 
	var f = FileAccess.open(p, FileAccess.WRITE)
	f.store_string(text)
	f.close()
	var c = ProjectSettings.globalize_path(clip.resource_path)
	var out = []
	OS.execute(rhubarb_dir + 'rhubarb', ["-d", p, c], out)
	self.codes = out[0]

func on_build_animation():
	var ap:AnimationPlayer = get_node(animation_player_nodepath)
	var sp = get_node(stream_player_nodepath)
	var ch = get_node(character_nodepath)
	var anim:Animation = ap.get_animation(animation_name) if ap.has_animation(animation_name) else Animation.new()
#	for i in range(anim.get_track_count()):
#		print('track %02d: ' % i, anim.track_get_path(i))
	var t_sp = anim.find_track(ap.get_node(ap.root_node).get_path_to(sp), Animation.TYPE_AUDIO)
	var t_ch = anim.find_track('Michal-Lipsync/Michal:mouth', Animation.TYPE_VALUE)
	
	# TODO: actually, it should warn if the tracks do NOT exist
	if t_sp == -1: printerr('todo: add sp track'); return
	if t_ch == -1: printerr('todo: add ch track'); return
	
	assert(1 == anim.track_get_key_count(t_sp)) #," no key checked audio track")
	assert(0 == anim.track_get_key_time(t_sp, 0)) #,"audio track not checked frame 0")
	anim.audio_track_set_key_stream(t_sp, 0, clip)
	var rp = anim.audio_track_get_key_stream(t_sp, 0).resource_path
	assert(rp == clip.resource_path) #,"audio track had wrong clip")

	# clear out the old phoneme track
	#print('key indices:', anim.track_get_path(t_sp))
	for i in range(anim.track_get_key_count(t_ch)):
		anim.track_remove_key(t_ch, 0)
	var lines:PackedStringArray = codes.trim_suffix('\n').split('\n')
	for line in lines:
		var x = line.strip_edges().split('\t')
		var t = float(x[0]) # timecode
		var f = x[1] # animation frame
		print(t,'->',f, '=', "ABCDEFGHX".find(f))
		anim.track_insert_key(t_ch, t, f)
	
	assert(len(lines) == anim.track_get_key_count(t_ch)) #,'should have cleared out all the keys.?')
