//
//  HBDetailSlider.swift
//  HBDetailSlider
//
//  Created by Hunter Bryant on 1/5/16.
//  Copyright © 2016 Hunter Bryant. All rights reserved.
//

import UIKit

class HBDetailSlider: UIControl {

	//MARK: Properties
	
	var value: Double = 0.25
	var initialValue: Double = 0.5
	var scale: Double = 5.0
	var minimumValue: Double = 0.0
	var maximumValue: Double = 1.0
	
	var highlightTintColor: UIColor = UIColor(red: 101/255, green: 241/255, blue: 224/255, alpha: 1.0) /* #65f1e0 */
	var secondaryTintColor: UIColor = UIColor(red: 113/255, green: 121/255, blue: 140/255, alpha: 1.0) /* #71798c */
	
	
	//MARK: Initialization
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		drawSlider()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)

		drawSlider()
	}
	
	
	//MARK: Operation methods
	
	func setValue(value: Double, isAnimated: Bool) {
		
	}
	
	
	//MARK: Drawing methods
	
	override func drawRect(rect: CGRect) {
		
		let width = self.bounds.width
		let height = self.bounds.height
		
		let scaledInitialValue = CGFloat(self.initialValue) * width
		let scaledValue = CGFloat(self.value) * width
		
		//Drawing Initial Value Mark
		let context = UIGraphicsGetCurrentContext()
		CGContextSetStrokeColorWithColor(context, highlightTintColor.CGColor)
		CGContextSetLineWidth(context, CGFloat(2.0))
		CGContextMoveToPoint(context, scaledInitialValue, 0)
		CGContextAddLineToPoint(context, scaledInitialValue, height/3)
		
		CGContextStrokePath(context)
		
		//Drawing Value Mark
		CGContextSetStrokeColorWithColor(context, secondaryTintColor.CGColor)
		CGContextSetLineWidth(context, CGFloat(2.0))
		CGContextMoveToPoint(context, scaledValue, 0)
		CGContextAddLineToPoint(context, scaledValue, height/3)
		
		//Drawing Lines
		let amountOfLines = Int(1 * scale * 5)
		for index in 0...amountOfLines {
			
			let totalWidth: CGFloat = CGFloat(amountOfLines) * 27
			let lineScaledX: CGFloat = ((CGFloat(index))/(CGFloat(amountOfLines))) * totalWidth
			let lineXPos: CGFloat = lineScaledX
			
			//Drawing Line
			CGContextSetStrokeColorWithColor(context, secondaryTintColor.CGColor)
			CGContextSetLineWidth(context, CGFloat(1.0))
			CGContextMoveToPoint(context, lineXPos, height/3)
			CGContextAddLineToPoint(context, lineXPos, height)
		}
		
		CGContextStrokePath(context)
		

	}
	
	func drawSlider() {
		
		setNeedsDisplay()
	}
	
}







