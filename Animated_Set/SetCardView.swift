//
//  CardView.swift
//  Graphical_Set
//
//  Created by Work Kris on 4/7/19.
//  Copyright © 2019 Kris P. All rights reserved.
//

import UIKit

@IBDesignable
class SetCardView: UIView {

    @IBInspectable
//    var shapeSymbol: String = "Diamond" { didSet { setNeedsDisplay(); setNeedsLayout() } }
    var shapeSymbol = String() { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var shapeNumber = Int() { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var shapeColor = UIColor() { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var shapeShading = String() { didSet { setNeedsDisplay(); setNeedsLayout() } }
    @IBInspectable
    var borderColorValue = UIColor() { didSet { setNeedsDisplay() } }
//    @IBInspectable
//    var isSelected = false {
//        didSet {
//            if isSelected {
//                self.borderColorValue = UIColor.blue
//            } else {
//                self.borderColorValue = UIColor.gray
//            }
//
//            setNeedsDisplay()
//        }
//    }
    
    // #1
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // #2
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // #3
    public convenience init(shapeSymbol: String, shapeNumber: Int, shapeColor: UIColor, shapeShading: String, borderColorValue: UIColor) {
//        self.init(frame: shapeFrame)
        self.init()
        self.shapeSymbol = shapeSymbol
        self.shapeNumber = shapeNumber
        self.shapeColor = shapeColor
        self.shapeShading = shapeShading
        self.borderColorValue = borderColorValue
        
//        print("In CardView -> init")
    }
    
    private func setupView() {
//        translatesAutoresizingMaskIntoConstraints = false
        
        self.isOpaque = false
        self.contentMode = .redraw
        
        // Create, add and layout the children views ..
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    private func drawCard() {
        
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundedRect.addClip()
        UIColor.white.setFill()
        borderColorValue.setStroke()
        roundedRect.lineWidth = borderWidth
        roundedRect.fill()
        roundedRect.stroke()
        
        let midPointsArray = [[], [bounds.center], [bounds.topHalf.center, bounds.bottomHalf.center], [bounds.topThird.center, bounds.middleThird.center, bounds.bottomThird.center]]
        
        for index in midPointsArray[shapeNumber].indices {
            if let shapePath = getShapePath(symbol: shapeSymbol, center: midPointsArray[shapeNumber][index]) {
                shapePath.lineWidth = shapeStrokeWidth
                shapeColor.setStroke()
                shapePath.stroke()
                let context = UIGraphicsGetCurrentContext()
                context?.addPath(shapePath.cgPath)
                context?.saveGState()
                shapePath.addClip()
                drawShapeShading(shading: shapeShading, color: shapeColor)
                shapePath.fill()
                context?.restoreGState()
            }
        }
        
    }
    
    private func drawShapeShading(shading: String, color: UIColor) {
        if shading == "Solid" {
            color.setFill()
        } else if shading == "Striped" {
            drawStripes(color: color)
        } else if shading == "Open" {
            UIColor.clear.setFill()
        }
    }
   
    private func drawStripes(color: UIColor) {
        let path = UIBezierPath()
        for xVal in stride(from: -bounds.maxX, to: bounds.maxX, by: stripeSpacing) {
            path.move(to: CGPoint(x: xVal, y: bounds.minY))
            path.addLine(to: CGPoint(x: bounds.maxX + xVal, y: bounds.maxY))
        }
        path.lineWidth = stripeWidth
        color.setStroke()
        path.stroke()
        UIColor.clear.setFill()
    }
    
    private func drawDiamond(center: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: center.offsetBy(dx: 0.0, dy: -(shapeHeight / 2)))
        path.addLine(to: center.offsetBy(dx: (diamondWidth / 2), dy: 0.0))
        path.addLine(to: center.offsetBy(dx: 0.0, dy: (shapeHeight / 2)))
        path.addLine(to: center.offsetBy(dx: -(diamondWidth / 2), dy: 0.0))
        path.close()
        return path
    }
    
    private func drawOval(center: CGPoint) -> UIBezierPath {
        let path = UIBezierPath(ovalIn: CGRect(x: center.x - (bounds.width / 2) + (ovalWidthOffset / 2), y: center.y - (ovalHeight / 2), width: bounds.width - ovalWidthOffset, height: ovalHeight))
        return path
    }
    
    private func drawSquiggle(center: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        let squiggleCenter = center.offsetBy(dx: 0.0, dy: squiggleCenterOffset)
        path.move(to: squiggleCenter.offsetBy(dx: (squiggleWidth / 2), dy: -(squiggleHeight / 2) - squigglHeightOffset))
        path.addCurve(to: squiggleCenter.offsetBy(dx: -(squiggleWidth / 2), dy: -(squiggleHeight / 2)), controlPoint1: squiggleCenter.offsetBy(dx: squiggleWidthOffset, dy: squigglHeightOffset), controlPoint2: squiggleCenter.offsetBy(dx: -squiggleWidthOffset, dy: -(squiggleHeight / 2) - squigglHeightOffset))
        path.addLine(to: squiggleCenter.offsetBy(dx: -(squiggleWidth / 2), dy: (squiggleHeight / 2)))
        path.addCurve(to: squiggleCenter.offsetBy(dx: (squiggleWidth / 2), dy: (squiggleHeight / 2) - squigglHeightOffset), controlPoint1: squiggleCenter.offsetBy(dx: -squiggleWidthOffset, dy: -(squiggleHeight / 2) - squigglHeightOffset), controlPoint2: squiggleCenter.offsetBy(dx: squiggleWidthOffset, dy: (squiggleHeight / 2) + squigglHeightOffset))
        path.close()
        return path
    }
    
    private func getShapePath(symbol: String, center: CGPoint) -> UIBezierPath? {
        if symbol == "Diamond" {
            return drawDiamond(center: center)
        } else if symbol == "Squiggle" {
            return drawSquiggle(center: center)
        } else if symbol == "Oval" {
            return drawOval(center: center)
        } else {
            return nil
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        drawCard()
    }

}

extension SetCardView {
    private struct SizeRatio {
        static let shapeHeightRatio: CGFloat = 0.19
        static let shapeStrokeWidthRatio: CGFloat = 0.015
        static let diamondWidthRatio: CGFloat = 0.63
        static let ovalWidthOffsetRatio: CGFloat = 0.2
        static let ovalHeightRatio: CGFloat = 0.2
        static let squiggleWidthRatio: CGFloat = 0.63
        static let squiggleHeightRatio: CGFloat = 0.14
        static let squiggleHeightOffsetRatio: CGFloat = 0.09
        static let squiggleWidthOffsetRatio: CGFloat = 0.20
        static let squiggleEndWidthOffsetRatio: CGFloat = 0.14
        static let squiggleCenterOffsetRatio: CGFloat = 0.03
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let borderWidthToBoundsHeight: CGFloat = 0.04
        static let stripeSpacingRatio: CGFloat = 0.1
        static let stripeWidthRatio: CGFloat = 0.01
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var borderWidth: CGFloat {
        return bounds.size.height * SizeRatio.borderWidthToBoundsHeight
    }
    private var shapeStrokeWidth: CGFloat {
        return bounds.size.width * SizeRatio.shapeStrokeWidthRatio
    }
    private var shapeHeight: CGFloat {
        return bounds.size.height * SizeRatio.shapeHeightRatio
    }
    private var diamondWidth: CGFloat {
        return bounds.size.width * SizeRatio.diamondWidthRatio
    }
    private var ovalWidthOffset: CGFloat {
        return bounds.size.width * SizeRatio.ovalWidthOffsetRatio
    }
    private var ovalHeight: CGFloat {
        return bounds.size.height * SizeRatio.ovalHeightRatio
    }
    private var squiggleWidth: CGFloat {
        return bounds.size.width * SizeRatio.squiggleWidthRatio
    }
    private var squiggleHeight: CGFloat {
        return bounds.size.height * SizeRatio.squiggleHeightRatio
    }
    private var squigglHeightOffset: CGFloat {
        return bounds.size.width * SizeRatio.squiggleHeightOffsetRatio
    }
    private var squiggleWidthOffset: CGFloat {
        return bounds.size.width * SizeRatio.squiggleWidthOffsetRatio
    }
    private var squiggleEndWidthOffset: CGFloat {
        return bounds.size.width * SizeRatio.squiggleEndWidthOffsetRatio
    }
    private var squiggleCenterOffset: CGFloat {
        return bounds.size.height * SizeRatio.squiggleCenterOffsetRatio
    }
    private var stripeSpacing: CGFloat {
        return bounds.size.width * SizeRatio.stripeSpacingRatio
    }
    private var stripeWidth: CGFloat {
        return bounds.size.width * SizeRatio.stripeWidthRatio
    }
}

extension CGRect {
    var topHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height/2)
    }
    var bottomHalf: CGRect {
        return CGRect(x: minX, y: midY, width: width, height: height/2)
    }
    var topThird: CGRect {
        return CGRect(x: minX, y: minY, width: width, height: height/3)
    }
    var middleThird: CGRect {
        return CGRect(x: minX, y: (topThird.maxY), width: width, height: height/3)
    }
    var bottomThird: CGRect {
        return CGRect(x: minX, y: (middleThird.maxY), width: width, height: height/3)
    }
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size: CGSize) -> CGRect {
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
