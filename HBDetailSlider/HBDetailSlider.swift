//
//  HBDetailSlider.swift
//  HBDetailSlider
//
//  Created by Hunter Bryant on 1/5/16.
//  Copyright © 2016 Hunter Bryant. All rights reserved.
//

import UIKit

class HBDetailSlider: UIControl {
	
	//TODO: Add decelleration functionality.
	//TODO: Add snapping to initial value functionality.

	//MARK: Properties
	
	var initialValue: Double = 0.5
	var value: Double
	var scale: Double = 4.0
	var minimumValue: Double = 0.0
	var maximumValue: Double = 1.0
	var threshold: Double = 0.01
	
	var previousLocation = CGPoint()
	
	var highlightTintColor: UIColor = UIColor(red: 101/255, green: 241/255, blue: 224/255, alpha: 1.0) /* #65f1e0 */
	var secondaryTintColor: UIColor = UIColor(red: 113/255, green: 121/255, blue: 140/255, alpha: 1.0) /* #71798c */
	var indicatorColor: UIColor = UIColor(red: 242/255, green: 245/255, blue: 255/255, alpha: 1.0) /* #f2f5ff */
	
	
	//MARK: Initialization
	
	required init?(coder aDecoder: NSCoder) {
		self.value = self.initialValue
		super.init(coder: aDecoder)

		drawSlider()
	}
	
	override init(frame: CGRect) {
		self.value = self.initialValue
		super.init(frame: frame)

		drawSlider()
	}
	
	
	//MARK: Operation methods
	
	func setValue(value: Double, isAnimated: Bool) {
		
	}
	
	
	//MARK: Touch Functions
	
	override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
		previousLocation = touch.locationInView(self)
		
		return true
	}
	
	override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
		let location = touch.locationInView(self)
		
		// 1. Determine by how much the user has dragged
		let deltaLocation = Double(location.x - previousLocation.x)
		let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width)
		
		// 2. Update the values
		if deltaValue < 0 && value <= 0{
			value = 0
		} else if deltaValue > 0 && value >= 1.0 {
			value = 1.0
		} else if abs(initialValue-value) < threshold && abs(deltaValue/scale) < threshold {
			value = initialValue
		} else {
			value += (deltaValue) / scale
		}
		
		previousLocation = location
		
		// 3. Update the UI
		setNeedsDisplay()
		
		return true
	}
	
	
	//MARK: Drawing methods
	
	override func drawRect(rect: CGRect) {
		
		let width = self.bounds.width
		let height = self.bounds.height
		
		let scaledInitialValue = CGFloat(self.initialValue) * width
		let scaledValue = CGFloat(self.value) * width
	
		//Drawing Value Mark
		let context = UIGraphicsGetCurrentContext()
		CGContextSetStrokeColorWithColor(context, indicatorColor.CGColor)
		CGContextSetLineWidth(context, CGFloat(2.0))
		CGContextMoveToPoint(context, scaledValue, 0)
		CGContextAddLineToPoint(context, scaledValue, height/3)
		
		CGContextStrokePath(context)
		
		//Drawing Initial Value Mark
		CGContextSetStrokeColorWithColor(context, highlightTintColor.CGColor)
		CGContextSetLineWidth(context, CGFloat(2.0))
		CGContextMoveToPoint(context, scaledInitialValue, 0)
		CGContextAddLineToPoint(context, scaledInitialValue, height/3)
		
		CGContextStrokePath(context)
		
		//Drawing Lines
		let amountOfLines = scale * 5
		let totalWidth: CGFloat = CGFloat(amountOfLines) * 27
		
		for index in 0...Int(amountOfLines)+1 {
			
			let lineScaledX: CGFloat = ((CGFloat(index))/(CGFloat(amountOfLines))) * (totalWidth + self.bounds.width)
			let lineXPos: CGFloat = (lineScaledX - totalWidth) + totalWidth*CGFloat(value)
			
			CGContextSetStrokeColorWithColor(context, secondaryTintColor.CGColor)
			CGContextSetLineWidth(context, CGFloat(1.0))
			
			//Drawing Line
			CGContextMoveToPoint(context, lineXPos, height/3)
			CGContextAddLineToPoint(context, lineXPos, height)
			
		}
		
		CGContextStrokePath(context)

	}
	
	func drawSlider() {
		
		setNeedsDisplay()
	}
	
}







