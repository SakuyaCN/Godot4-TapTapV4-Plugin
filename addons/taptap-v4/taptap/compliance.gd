class_name TapCompliance
## 防沉迷模块
var android_runtime = Engine.get_singleton("AndroidRuntime")
var TapTapCompliance = JavaClassWrapper.wrap('com.taptap.sdk.compliance.TapTapCompliance')
var BaseTapTapComplianceCallback = JavaClassWrapper.wrap('com.godot.game.BaseTapTapComplianceCallback')
var TapTapLogin = JavaClassWrapper.wrap('com.taptap.sdk.login.TapTapLogin')
var TapTapAccount = JavaClassWrapper.wrap('com.taptap.sdk.login.TapTapAccount')

func _init() -> void:
	if android_runtime:
		var activity = android_runtime.getActivity()
		var ins = BaseTapTapComplianceCallback.call("<init>",get_instance_id())
		TapTapCompliance.registerComplianceCallback(ins)

func checkCompliance():
	if android_runtime and TapTap.is_init:
		var currentTapAccount = TapTapLogin.getCurrentTapAccount()
		if currentTapAccount != null:
			var activity = android_runtime.getActivity()
			var unionId = currentTapAccount.getUnionId()
			TapTapCompliance.startup(activity, unionId)
			

func exit():
	if android_runtime and TapTap.is_init:
		TapTapCompliance.exit()

func _on_compliance_callback(code):
	print(code)
	TapTap.call_deferred("emit_signal",'on_compliance_callback',code)
