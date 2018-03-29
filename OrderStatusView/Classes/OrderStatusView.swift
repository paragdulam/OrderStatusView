//
//  OrderStatusView.swift
//  TeeTimes
//
//  Created by Parag Dulam on 28/03/18.
//  Copyright © 2018 TeeTimes. All rights reserved.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}


public class OrderStatusView: UIView {
    
    var statusCount: Int = 6 {
        didSet {
            setNeedsDisplay()
        }
    }
    var selectedStatusIndex = 0
    var offSet: CGFloat = 16.0
    var circleRadius: CGFloat = 8.0
    
    public var normalStateColor: UIColor! = UIColor(white: 1.0, alpha: 0.8)
    public var selectedStateColor: UIColor! = UIColor(red: 251.0/255.0, green: 175.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.setStrokeColor(normalStateColor.cgColor)
        context?.setFillColor(selectedStateColor.cgColor)
        
        let linesWidth = rect.size.width - (offSet * 2) - (circleRadius * 2)
        let linesOffSet = linesWidth/(CGFloat(statusCount) - 1)
        
        for var i in 0 ..< statusCount {
            let linePoint = CGPoint(x: (circleRadius + offSet) + (CGFloat(i) * linesOffSet), y: rect.size.height/2)
            context?.move(to: linePoint)
            if i != (statusCount - 1) {
                context?.move(to: CGPoint(x: linePoint.x + 8, y: linePoint.y))
                context?.addLine(to: CGPoint(x: linePoint.x + linesOffSet - 8, y: linePoint.y))
            }
            if i < selectedStatusIndex {
                context?.setStrokeColor(selectedStateColor.cgColor)
            } else {
                context?.setStrokeColor(normalStateColor.cgColor)
            }
            context?.strokePath()
            
            context?.addEllipse(in: CGRect(x: linePoint.x - circleRadius, y: linePoint.y - circleRadius, width: circleRadius * 2, height: circleRadius * 2))
            
            if i <= selectedStatusIndex {
                context?.fillPath()
            } else {
                context?.strokePath()
            }
        }
    }
    
    public func setStatus(_ index: Int) {
        if selectedStatusIndex >= statusCount {
            return
        }
        selectedStatusIndex = index
        setNeedsDisplay()
    }
    
}
