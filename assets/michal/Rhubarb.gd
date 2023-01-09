tool class_name Rhubarb extends Node

export(NodePath) var animation_player_nodepath = '..'
export(NodePath) var stream_player_nodepath = '../AudioStreamPlayer2D'
export(NodePath) var character_nodepath = '../Michal'
export(AudioStreamSample) var clip
export(String, MULTILINE) var text
export(String, MULTILINE) var codes
export(bool) var rhubarb_flag = false setget set_rhubarb_flag
export(bool) var script_flag = false setget set_script_flag
export(String, DIR, GLOBAL) var rhubarb_dir = "d:/Rhubarb-Lip-Sync-1.12.0-Windows/"
export(String, DIR, GLOBAL) var temp_dir = "d:/tmp/"
export(String) var animation_name = 'lipsync.000'


func rhubarb():
	var f = File.new()
	var p = temp_dir + 'rhubarb.txt' 
	f.open(p, File.WRITE)
	f.store_string(text)
	f.close()
	var c = ProjectSettings.globalize_path(clip.resource_path)
	var out = []
	OS.execute(rhubarb_dir + 'rhubarb', ["-d", p, c], true, out)
	self.codes = out[0]

func set_rhubarb_flag(x):
	if x: rhubarb()

func set_script_flag(x):
	if x: build_animation()


func build_animation():
	var ap:AnimationPlayer = get_node(animation_player_nodepath)
	var sp = get_node(stream_player_nodepath)
	var ch = get_node(character_nodepath)
	var anim:Animation = ap.get_animation(animation_name) if ap.has_animation(animation_name) else Animation.new()
#	for i in range(anim.get_track_count()):
#		print('track %02d: ' % i, anim.track_get_path(i))
	var t_sp = anim.find_track(ap.get_node(ap.root_node).get_path_to(sp))
	var t_ch = anim.find_track(ap.get_node(ap.root_node).get_path_to(ch))
	
	# TODO: actually, it should warn if the tracks do NOT exist
	if t_sp == -1: return printerr('todo: add sp track')
	if t_ch == -1: return printerr('todo: add ch track')
	
	assert(1 == anim.track_get_key_count(t_sp), " no key on audio track")
	assert(0 == anim.track_get_key_time(t_sp, 0), "audio track not on frame 0")
	anim.audio_track_set_key_stream(t_sp, 0, clip)
	var rp = anim.audio_track_get_key_stream(t_sp, 0).resource_path
	assert(rp == clip.resource_path, "audio track had wrong clip")

	# clear out the old phoneme track
	#print('key indices:', anim.track_get_path(t_sp))
	for i in range(anim.track_get_key_count(t_ch)):
		anim.track_remove_key(t_ch, 0)
	var lines:PoolStringArray = codes.trim_suffix('\n').split('\n')
	for line in lines:
		var x = line.split('\t')
		var t = float(x[0]) # timecode
		var f = x[1] # animation frame
		print(t,'->',f)
		anim.track_insert_key(t_ch, t, f)
	
	assert(len(lines) == anim.track_get_key_count(t_ch), 'should have cleared out all the keys.?')
