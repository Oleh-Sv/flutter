// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
    RegisterMethodChannel(registry: flutterViewController)

    super.awakeFromNib()
  }


  func RegisterMethodChannel(registry: FlutterPluginRegistry) {
    let registrar = registry.registrar(forPlugin: "flavors")
    let channel = FlutterMethodChannel(name: "flavor",
                                       binaryMessenger: registrar.messenger)
    channel.setMethodCallHandler({ (call, result) in
      let flavor = Bundle.main.infoDictionary?["Flavor"] as? String
      result(flavor)
    })
  }
}
