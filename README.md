# 需要Godot版本：4.4+

目前处于Beta状态，不建议投入到生产环境中使用。

## 功能：

- Tap一键登录
- 防沉迷验证
- 内嵌动态
- 评价功能
- 唤起更新

## 模块

### 初始化
`
TapTap.init(clientId,clientToken)
`

### 登录模块
`
TapTap.login_instance
`
### 防沉迷模块
`
TapTap.compliance_instance
`
### 内嵌动态模块
`
TapTap.moment_instance
`

### 其他API

打开评价
`
TapTap.openReview()
`

唤起更新
`
TapTap.updateGame()
`

内置提示框
`
TapTap.toast(msg)
`
