import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
	@IBOutlet weak var picker: UIPickerView!
	@IBOutlet weak var redRectView: UIView!
	var viewToUse: UIView?
	var window: UIView?
	var pinch: UIPinchGestureRecognizer?
	var rotate: UIRotationGestureRecognizer?
	var pan: UIPanGestureRecognizer?
	
	override func viewDidLoad()
	{
		picker.dataSource = self
		picker.delegate = self
		
		viewToUse = redRectView
		
		pinch = UIPinchGestureRecognizer(target: self, action: #selector(onPinch(_:)))
		rotate = UIRotationGestureRecognizer(target: self, action: #selector(onRotate(_:)))
		pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
		
		pickerView(picker, didSelectRow: 0, inComponent: 0)
	}
	
	//
	// UIPickerDataSource
	//
	func numberOfComponents(in pickerView: UIPickerView) -> Int
	{
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
	{
		guard component == 0 else
		{
			return 0
		}
		
		return 3
	}

	//
	// UIPickerDelegate
	//
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
	{
		guard component == 0 else
		{
			return nil
		}
		
		if row == 0
		{
			return "Red rectangle"
		}
		else if row == 1
		{
			return "View"
		}
		else if row == 2
		{
			return "Window"
		}
		else
		{
			return nil
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
	{
		guard component == 0, let pinch = pinch, let rotate = rotate, let pan = pan else
		{
			return
		}
		
		viewToUse?.removeGestureRecognizer(pinch)
		viewToUse?.removeGestureRecognizer(rotate)
		viewToUse?.removeGestureRecognizer(pan)
		
		if row == 0
		{
			viewToUse = redRectView
		}
		else if row == 1
		{
			viewToUse = view
		}
		else if row == 2
		{
			viewToUse = window
		}
		
		viewToUse?.addGestureRecognizer(pinch)
		viewToUse?.addGestureRecognizer(rotate)
		viewToUse?.addGestureRecognizer(pan)
	}
	
	@objc func onPinch(_ sender: UIPinchGestureRecognizer)
	{
		if let scaledTransform = viewToUse?.transform.scaledBy(x: sender.scale, y: sender.scale)
		{
			viewToUse?.transform = scaledTransform
		}
		
		debugPrint("Scale:\(sender.scale)")
		sender.scale = 1
	}
	
	@objc func onRotate(_ sender: UIRotationGestureRecognizer)
	{
		debugPrint("Rotate:\(sender.rotation),\(sender.velocity)")
		
		if let rotatedTransform = viewToUse?.transform.rotated(by: sender.rotation)
		{
			viewToUse?.transform = rotatedTransform
		}
		
		sender.rotation = 0
	}
	
	@objc func onPan(_ sender: UIPanGestureRecognizer)
	{
		let translation = sender.translation(in: viewToUse)
		
		if let translatedTransform = viewToUse?.transform.translatedBy(x: translation.x, y: translation.y)
		{
			viewToUse?.transform = translatedTransform
		}
		
		sender.setTranslation(CGPoint(x: 0, y: 0), in: viewToUse)
	}
}


