package com.godot.game

import com.taptap.sdk.core.TapTapSdk
import com.taptap.sdk.kit.internal.callback.TapTapCallback
import com.taptap.sdk.kit.internal.exception.TapTapException
import com.taptap.sdk.kit.internal.extensions.toJson
import com.taptap.sdk.login.TapTapAccount
import com.taptap.sdk.login.TapTapLogin.getCurrentTapAccount
import org.godotengine.godot.variant.Callable

class BaseTapTapCallback(val oid:Long) :TapTapCallback<TapTapAccount>{

    override fun onFail(exception: TapTapException) {
        Callable.call(oid,"_login_fail")
    }

    override fun onSuccess(result: TapTapAccount) {
        Callable.call(oid,"_login_success",result)
    }

    override fun onCancel() {
        Callable.call(oid,"_login_fail")
    }
}
