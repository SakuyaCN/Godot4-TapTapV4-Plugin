@tool
extends EditorPlugin

## 远程依赖
const dependencies = [
	'com.taptap.sdk:tap-core:4.5.3', # taptap核心sdk
	'com.taptap.sdk:tap-kit:4.5.3', # taptap核心sdk
	'com.taptap.sdk:tap-login:4.5.3', # taptap登录sdk
	'com.taptap.sdk:tap-compliance:4.5.3', # 防沉迷sdk
	'org.jetbrains.kotlinx:kotlinx-serialization-json:1.4.1',
	'com.taptap.sdk:tap-achievement:4.5.3', # 成就
	'com.taptap.sdk:tap-moment:4.5.3', #内嵌动态
	'com.taptap.sdk:tap-review:4.5.3', #评价功能
	'com.taptap.sdk:tap-update:4.5.3', #唤起更新
]

var export_plugin:AndroidExportPlugin

func _enter_tree():
	export_plugin = AndroidExportPlugin.new()
	add_export_plugin(export_plugin)
	add_autoload_singleton('TapTap',"res://addons/taptap-v4/TapTap.gd")


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_export_plugin(export_plugin)
	export_plugin = null
	remove_autoload_singleton('TapTap')

class AndroidExportPlugin extends EditorExportPlugin:
	var _plugin_name = "taptap-v4"
	
	func _export_begin(features: PackedStringArray, is_debug: bool, path: String, flags: int) -> void:
		var file_path = "res://addons/taptap-v4/kotlin/"
		var list = DirAccess.get_files_at(file_path)
		for file_name in list:
			DirAccess.copy_absolute(file_path+file_name,"res://android/build/src/com/godot/game/"+file_name)
	
	func _get_name():
		return _plugin_name
	
	func _supports_platform(platform):
		if platform is EditorExportPlatformAndroid:
			return true
		return false
	
	func _get_android_dependencies(platform: EditorExportPlatform, debug: bool) -> PackedStringArray:
		return PackedStringArray(dependencies)
	
