package com.godot.game

import android.app.Activity
import com.taptap.sdk.BuildConfig
import com.taptap.sdk.compliance.option.TapTapComplianceOptions
import com.taptap.sdk.core.TapTapRegion
import com.taptap.sdk.core.TapTapSdk
import com.taptap.sdk.core.TapTapSdkOptions


class BaseTapInit(val activity: Activity,val clientId:String,val clientToken:String) {

    init {
        val enableLog: Boolean = BuildConfig.DEBUG

        val tapSdkOptions: TapTapSdkOptions = TapTapSdkOptions(
            clientId,  // 游戏 Client ID
            clientToken,  // 游戏 Client Token
            TapTapRegion.CN // 游戏可玩区域: [TapTapRegion.CN]=国内 [TapTapRegion.GLOBAL]=海外
        )
        tapSdkOptions.enableLog = enableLog


        // 可选配置 合规模块
        val tapComplianceOptions = TapTapComplianceOptions(
            true,  // 是否显示切换账号按钮，默认为 false
            true // 游戏是否需要获取真实年龄段信息，默认为 true
        )

        // 初始化 TapSDK
        TapTapSdk.init(activity, tapSdkOptions, tapComplianceOptions)
    }
}