extends Node

var android_runtime = Engine.get_singleton("AndroidRuntime")

var is_init = false # 是否初始化

var login_instance = TapLogin.new()
var compliance_instance = TapCompliance.new()
var moment_instance = TapMoment.new()

# 登录信号
signal on_login_success(data:TapLogin.LoginClass)
signal on_login_fail()
signal on_login_out()

#防沉迷信号
#500 玩家未受到限制，正常进入游戏
#1000 退出防沉迷认证及检查，当开发者调用 Exit 接口时或用户认证信息无效时触发，游戏应返回到登录页
#1001 用户点击切换账号，游戏应返回到登录页
#1030 用户当前时间无法进行游戏，此时用户只能退出游戏或切换账号
#1050 用户无可玩时长，此时用户只能退出游戏或切换账号
#1100 当前用户因触发应用设置的年龄限制无法进入游戏，该回调的优先级高于 1030，触发该回调无弹窗提示
#1200 数据请求失败，游戏需检查当前设置的应用信息是否正确及判断当前网络连接是否正常
#9002 实名过程中点击了关闭实名窗，游戏可重新开始防沉迷认证
signal on_compliance_callback(code)

# 初始化sdk
func init(clientId:String,clientToken:String,enableLog = false):
	var tap_init = TapInit.new(clientId,clientToken,enableLog)
	is_init = true

# 打开评价界面
func openReview():
	if is_init:
		JavaClassWrapper.wrap('com.taptap.sdk.review.TapTapReview').openReview()

# 更新游戏
func updateGame():
	if is_init and android_runtime:
		var activity = android_runtime.getActivity()
		var BaseTapTapUpdateCallback = JavaClassWrapper.wrap('com.godot.game.BaseTapTapUpdateCallback')
		var ins = BaseTapTapUpdateCallback.call('<init>')
		activity.runOnUiThread(android_runtime.createRunnableFromGodotCallable(func():
			JavaClassWrapper.wrap('com.taptap.sdk.update.TapTapUpdate').updateGame(activity,ins)))

func toast(msg,time = 1):
	if android_runtime:
		var activity = android_runtime.getActivity()
		
		var toastCallable = func ():
			var ToastClass = JavaClassWrapper.wrap("android.widget.Toast")
			ToastClass.makeText(activity, msg, time).show()
		activity.runOnUiThread(android_runtime.createRunnableFromGodotCallable(toastCallable))
	else:
		printerr("Unable to access android runtime")
