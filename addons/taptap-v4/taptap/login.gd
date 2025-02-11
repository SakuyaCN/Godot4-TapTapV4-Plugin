class_name TapLogin
## 登录模块

var android_runtime = Engine.get_singleton("AndroidRuntime")

var Scopes = JavaClassWrapper.wrap('com.taptap.sdk.login.Scopes')
var TapTapLogin = JavaClassWrapper.wrap('com.taptap.sdk.login.TapTapLogin')
var TapTapAccount = JavaClassWrapper.wrap('com.taptap.sdk.login.TapTapAccount')
var BaseTapTapCallback = JavaClassWrapper.wrap('com.godot.game.BaseTapTapCallback')

class LoginClass:
	var unionId: String
	var openId: String
	var name: String
	var avatar: String
	var accessToken: String

func login():
	if android_runtime and TapTap.is_init:
		var activity = android_runtime.getActivity()
		var ins = BaseTapTapCallback.call("<init>",get_instance_id())
		TapTapLogin.loginWithScopes(activity,[Scopes.SCOPE_PROFILE],ins)

func logout():
	if android_runtime and TapTap.is_init:
		TapTapLogin.logout()
		TapTap.on_login_out.emit()

func currentTapAccount() -> LoginClass:
	if android_runtime and TapTap.is_init:
		var currentTapAccount = TapTapLogin.getCurrentTapAccount()
		if currentTapAccount != null:
			var accessToken = currentTapAccount.getAccessToken(); # accesstoken
			var login_class = LoginClass.new()
			login_class.name = currentTapAccount.getName()
			login_class.unionId = currentTapAccount.getUnionId()
			login_class.openId = currentTapAccount.getOpenId()
			login_class.avatar = currentTapAccount.getAvatar()
			return login_class
	return null

func _login_success(data):
	var login_class = LoginClass.new()
	login_class.name = data.getName()
	login_class.unionId = data.getUnionId()
	login_class.openId = data.getOpenId()
	login_class.avatar = data.getAvatar()
	TapTap.call_deferred("emit_signal",'on_login_success',login_class)

func _login_fail():
	TapTap.call_deferred("emit_signal",'on_login_fail')
