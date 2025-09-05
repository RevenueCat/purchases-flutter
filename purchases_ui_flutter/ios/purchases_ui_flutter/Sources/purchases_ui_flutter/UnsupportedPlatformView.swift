//
//  UnsupportedPlatformView.swift
//  purchases_ui_flutter
//
//  Created by Cesar de la Vega on 5/3/24.
//

import Foundation
import Flutter

class UnsupportedPlatformView: NSObject, FlutterPlatformView {
    private var _view: UIView

    override init() {
        _view = UIView()
        super.init()
    }

    func view() -> UIView {
        return _view
    }
}
