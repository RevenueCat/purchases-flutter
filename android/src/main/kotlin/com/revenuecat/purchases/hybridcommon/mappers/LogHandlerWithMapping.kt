package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.LogHandler
import com.revenuecat.purchases.LogLevel

class LogHandlerWithMapping(
    private val callback: (logData: Map<String, String>) -> Unit,
) : LogHandler {
    override fun d(tag: String, msg: String) {
        invokeCallback(LogLevel.DEBUG, msg)
    }

    override fun e(tag: String, msg: String, throwable: Throwable?) {
        val message = throwable?.let { "$msg. Throwable: $it" } ?: msg
        invokeCallback(LogLevel.ERROR, message)
    }

    override fun i(tag: String, msg: String) {
        invokeCallback(LogLevel.INFO, msg)
    }

    override fun v(tag: String, msg: String) {
        invokeCallback(LogLevel.VERBOSE, msg)
    }

    override fun w(tag: String, msg: String) {
        invokeCallback(LogLevel.WARN, msg)
    }

    private fun invokeCallback(logLevel: LogLevel, msg: String) {
        callback(mapOf("logLevel" to logLevel.name.uppercase(), "message" to msg))
    }
}
