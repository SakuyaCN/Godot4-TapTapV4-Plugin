class_name TapMoment
# 内嵌动态模块
var android_runtime = Engine.get_singleton("AndroidRuntime")
var TapTapMoment = JavaClassWrapper.wrap('com.taptap.sdk.moment.TapTapMoment')

func open():
	if android_runtime and TapTap.is_init:
		TapTapMoment.open()
