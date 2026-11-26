import Cocoa
import FlutterMacOS

class AppDelegate: FlutterAppDelegate {
  private var window: NSWindow?

  override func applicationDidFinishLaunching(_ notification: Notification) {
    let controller = FlutterViewController()
    RegisterGeneratedPlugins(registry: controller)
    let window = NSWindow(contentViewController: controller)
    window.setContentSize(NSSize(width: 480, height: 320))
    window.makeKeyAndOrderFront(nil)
    self.window = window
    mainFlutterWindow = window
    super.applicationDidFinishLaunching(notification)
  }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.regular)
app.run()
