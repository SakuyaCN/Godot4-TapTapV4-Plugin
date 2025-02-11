class_name TapInit

var android_runtime = Engine.get_singleton("AndroidRuntime")

func _init(clientId,clientToken,enableLog = false) -> void:
	if android_runtime:
		var activity = android_runtime.getActivity()
		var BaseTapInit = JavaClassWrapper.wrap('com.godot.game.BaseTapInit')
		BaseTapInit.call('<init>',activity,clientId,clientToken)
