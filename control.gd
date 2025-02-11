extends Control

@onready var rich_text = $RichTextLabel

var login_instence = TapTap.login_instance
var compliance_instance = TapTap.compliance_instance
var moment_instance = TapTap.moment_instance

func _ready() -> void:
	TapTap.init(Consts.clientId,Consts.ClisntToken,true)
	
	TapTap.on_login_success.connect(func (data:TapLogin.LoginClass):
		rich_text.append_text('登录成功:'+data.name + '\n'))
		
	
	TapTap.on_login_fail.connect(func ():
		rich_text.append_text('登录失败'+ '/n'))
	
	TapTap.on_compliance_callback.connect(func (code):
		rich_text.append_text('防沉迷验证结果：'+str(code)+ '\n'))
		
	
	var login_data = login_instence.currentTapAccount()
	if login_data:
		rich_text.append_text('自动登录结果：'+login_data.name+ '\n')
		print(login_data.name)
	else:
		rich_text.append_text('未自动登录'+ '\n')

func _on_button_pressed() -> void:
	login_instence.login()


func _on_button_2_pressed() -> void:
	compliance_instance.checkCompliance()


func _on_button_3_pressed() -> void:
	compliance_instance.exit()


func _on_button_4_pressed() -> void:
	moment_instance.open()


func _on_button_5_pressed() -> void:
	TapTap.openReview()


func _on_button_6_pressed() -> void:
	TapTap.updateGame()
