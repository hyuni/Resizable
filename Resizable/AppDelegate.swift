import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
	{
		if let vc = window?.rootViewController as? ViewController
		{
			vc.window = window
			window?.backgroundColor = UIColor.green
		}
		
		return true
	}
}

