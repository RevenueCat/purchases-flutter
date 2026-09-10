package com.revenuecat.purchases.hybridcommon.mappers

import com.revenuecat.purchases.utils.Iso8601Utils
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.MainScope
import org.json.JSONArray
import org.json.JSONObject
import java.text.NumberFormat
import java.util.Currency
import java.util.Date

fun Map<String, *>.convertToJson(): JSONObject {
    val jsonObject = JSONObject()
    for ((key, value) in this) {
        when (value) {
            null -> jsonObject.put(key, JSONObject.NULL)
            is Map<*, *> -> jsonObject.put(key, (value as Map<String, *>).convertToJson())
            is List<*> -> jsonObject.put(key, value.convertToJsonArray())
            is Array<*> -> jsonObject.put(key, value.toList().convertToJsonArray())
            else -> jsonObject.put(key, value)
        }
    }
    return jsonObject
}

fun List<*>.convertToJsonArray(): JSONArray {
    val writableArray = JSONArray()
    for (item in this) {
        when (item) {
            null -> writableArray.put(JSONObject.NULL)
            is Map<*, *> -> writableArray.put((item as Map<String, *>).convertToJson())
            is Array<*> -> writableArray.put(item.asList().convertToJsonArray())
            is List<*> -> writableArray.put(item.convertToJsonArray())
            else -> writableArray.put(item)
        }
    }
    return writableArray
}

fun JSONObject.convertToMap(): Map<String, String?> =
    this.keys().asSequence<String>().associate { key ->
        if (this.isNull(key)) {
            key to null
        } else {
            key to this.getString(key)
        }
    }

/**
 * If this is set before the first time [mapperDispatcher] is accessed, it will be used as the dispatcher for mapping
 * operations. This is useful to override the dispatcher for testing purposes.
 */
internal var overrideMapperDispatcher: CoroutineDispatcher? = null

internal val mapperDispatcher: CoroutineDispatcher by lazy { overrideMapperDispatcher ?: Dispatchers.Default }

internal val mainScope: CoroutineScope = MainScope()

internal fun Date.toMillis(): Long = this.time

internal fun Date.toIso8601(): String = Iso8601Utils.format(this)

internal fun formatUsingDeviceLocale(priceCurrencyCode: String, number: Long): String {
    return NumberFormat.getCurrencyInstance().apply {
        currency = Currency.getInstance(priceCurrencyCode)
    }.format(number)
}
