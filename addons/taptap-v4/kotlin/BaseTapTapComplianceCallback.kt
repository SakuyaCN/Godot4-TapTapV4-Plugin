package com.godot.game

import com.taptap.sdk.compliance.TapTapComplianceCallback
import org.godotengine.godot.variant.Callable


class BaseTapTapComplianceCallback(val oid: Long) : TapTapComplianceCallback {

    override fun onComplianceResult(code: Int, extra: Map<String, Any>?) {
        Callable.call(oid,"_on_compliance_callback",code)
    }
}