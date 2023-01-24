package com.revenuecat.purchases_flutter

class LogHandler(
    private val callback: (logData: Map<String, String>) -> Unit
) : com.revenuecat.purchases.LogHandler {
    override fun d(tag: String, msg: String) {
        callback(
            mapOf(
                "logLevel" to "DEBUG", "message" to msg
            )
        )
    }

    override fun e(tag: String, msg: String, throwable: Throwable?) {
        val message = throwable?.let {
            "$msg. Throwable: $it"
        } ?: msg
        callback(
            mapOf(
                "logLevel" to "ERROR", "message" to message
            )
        )
    }

    override fun i(tag: String, msg: String) {
        callback(
            mapOf(
                "logLevel" to "INFO", "message" to msg
            )
        )
    }

    override fun w(tag: String, msg: String) {
        callback(
            mapOf(
                "logLevel" to "WARN", "message" to msg
            )
        )

    }

}