package com.revenuecat.purchases.hybridcommon

interface OnResultAny<T> {
    fun onReceived(result: T)
    fun onError(errorContainer: ErrorContainer?)
}
