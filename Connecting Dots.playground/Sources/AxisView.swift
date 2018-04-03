import CoreGraphics
import Foundation
import UIKit

open class AxisView: UIView {
    
    let fontSize:CGFloat = 10.0
    let font:CFTypeRef = CGFont(UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.thin).fontName as CFString)!
    
    public init(){
        super.init(frame: Global.frame)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "grid.png")!)
        self.interaction()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func interaction() {}
    
    public func addLine(from:Dot, to:Dot) {
        addCurve(from: from, to: to, controlPoints: [])
    }
    
    public func addCurve(from:Dot, to:Dot, controlPoints:[Dot]) {
        let shapeLayer = CAShapeLayer()
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: from)
        if (controlPoints.count == 1) {
            bezierPath.addQuadCurve(to: to, controlPoint: controlPoints[0])
        } else if (controlPoints.count > 1) {
            bezierPath.addCurve(to: to, controlPoint1: controlPoints[0], controlPoint2: controlPoints[1])
        } else {
            bezierPath.addLine(to: to)
        }
        
        //add graphic descriptors
        addLabels(from: from, to: to, controlPoints: controlPoints)
        addDashedLines(from: from, to: to, controlPoints: controlPoints)
        addDotIndicator(from: from, to: to, controlPoints: controlPoints)
        addAxisIndicators()
        
        //setup shapeLayer to be drawn
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.strokeColor = Global.strokeColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = Global.lineWidth
        shapeLayer.lineCap = kCALineCapRound
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        //set up animation
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = Global.animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        shapeLayer.add(animation, forKey: "drawLineAnimation")
        
        //add drawing to view
        self.layer.addSublayer(shapeLayer)
        
    }
    
    func addAxisIndicators() {
        let offset:CGFloat = 20
        let axisLayer = CAShapeLayer()
        axisLayer.strokeColor = UIColor.Graphics.Axis.cgColor
        axisLayer.lineWidth = 4.0
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: offset))
        path.addLine(to: CGPoint(x: self.frame.maxX, y: offset))
        path.move(to: CGPoint(x: offset, y: 0))
        path.addLine(to: CGPoint(x: offset, y: self.frame.maxY))
        axisLayer.path = path.cgPath
        
        let zeroText = CATextLayer()
        zeroText.string = "(0, 0)"
        zeroText.font = font
        zeroText.fontSize = fontSize
        zeroText.foregroundColor = Global.textColor
        zeroText.frame = CGRect(x: 0.0, y: 0.0, width: 60.0, height: 25.0)
        zeroText.position = CGPoint(x: offset+40, y: offset+20)
        self.layer.addSublayer(zeroText)
        
        self.layer.addSublayer(axisLayer)
    }
    
    func addDotIndicator(from: Dot, to: Dot, controlPoints: [Dot]) {
        
        let cell = CAEmitterCell()
        cell.birthRate = 0.5
        cell.lifetime = 15
        cell.velocity = 0
        
        cell.xAcceleration = 0
        cell.yAcceleration = 0
        cell.zAcceleration = 0
        
        cell.emissionLongitude = 2*CGFloat.pi
        cell.emissionRange = 2*CGFloat.pi
        cell.alphaSpeed = -0.25
        
        cell.scale = 0.085
        cell.scaleSpeed = 0.18
        cell.contents = UIImage(named: "circle.png")!.cgImage
        
        self.layer.addSublayer(createEmitter(on: to, cells:[cell]))
        self.layer.addSublayer(createEmitter(on: from, cells:[cell]))
        
        if (controlPoints.count == 1) {
            self.layer.addSublayer(createEmitter(on: controlPoints[0], cells:[cell]))
        }
        if (controlPoints.count > 1) {
            self.layer.addSublayer(createEmitter(on: controlPoints[1], cells:[cell]))
        }
        
    }
    
    func createEmitter(on point: CGPoint, cells: [CAEmitterCell]) -> CAEmitterLayer {
        let emitter = CAEmitterLayer()
        emitter.emitterPosition = point
        emitter.emitterShape = kCAEmitterLayerPoint
        emitter.emitterSize = CGSize(width: 1, height: 1)
        emitter.emitterCells = cells
        
        return emitter
    }
    
    func addDashedLines(from: Dot, to: Dot, controlPoints: [Dot]) {
        
        let dashedLinesLayer = CAShapeLayer()
        let path = UIBezierPath()
        
        if (controlPoints.count == 1) {
            path.move(to: CGPoint(x: from.x, y: from.y))
            path.addLine(to: CGPoint(x: controlPoints[0].x, y: controlPoints[0].y))
            
            path.move(to: CGPoint(x: to.x, y: to.y))
            path.addLine(to: CGPoint(x: controlPoints[0].x, y: controlPoints[0].y))
        }
        if (controlPoints.count > 1) {
            path.move(to: CGPoint(x: from.x, y: from.y))
            path.addLine(to: CGPoint(x: controlPoints[1].x, y: controlPoints[1].y))
            
            path.move(to: CGPoint(x: to.x, y: to.y))
            path.addLine(to: CGPoint(x: controlPoints[1].x, y: controlPoints[1].y))
        }
        
        dashedLinesLayer.path = path.cgPath
        dashedLinesLayer.lineDashPattern = [6,12]
        dashedLinesLayer.strokeColor = UIColor.Graphics.Dashed.cgColor
        dashedLinesLayer.fillColor = UIColor.clear.cgColor
        dashedLinesLayer.lineWidth = 1.5
        dashedLinesLayer.lineCap = kCALineCapRound
        
        self.layer.addSublayer(dashedLinesLayer)
        
    }
    
    func addLabels(from: Dot, to: Dot, controlPoints: [Dot]) {
        
        let offset:CGFloat = 40.0
        
        let fromText = CATextLayer()
        fromText.string = "(\(Int(from.x)), \(Int(from.y)))"
        fromText.font = font
        fromText.fontSize = fontSize
        fromText.foregroundColor = Global.textColor
        fromText.frame = CGRect(x: 0, y: 0, width: 60.0, height: 25.0)
        fromText.position = CGPoint(x: offset + from.x, y: from.y)
        self.layer.addSublayer(fromText)
        
        let toText = CATextLayer()
        toText.string = "(\(Int(to.x)), \(Int(to.y)))"
        toText.font = font
        toText.fontSize = fontSize
        toText.foregroundColor = Global.textColor
        toText.frame = CGRect(x: 0, y: 0, width: 60.0, height: 25.0)
        toText.position = CGPoint(x: offset + to.x, y: to.y)
        self.layer.addSublayer(toText)
        
        if (controlPoints.count == 1) {
            let cText = CATextLayer()
            cText.string = "(\(Int(controlPoints[0].x)), \(Int(controlPoints[0].y)))"
            cText.font = font
            cText.fontSize = fontSize
            cText.foregroundColor = Global.textColor
            cText.frame = CGRect(x: 0, y: 0, width: 60.0, height: 25.0)
            cText.position = CGPoint(x: offset + controlPoints[0].x, y: controlPoints[0].y)
            self.layer.addSublayer(cText)
            
        }
        if (controlPoints.count > 1) {
            let c2Text = CATextLayer()
            c2Text.string = "(\(Int(controlPoints[1].x)), \(Int(controlPoints[1].y)))"
            c2Text.font = font
            c2Text.fontSize = fontSize
            c2Text.foregroundColor = Global.textColor
            c2Text.frame = CGRect(x: 0, y: 0, width: 60.0, height: 25.0)
            c2Text.position = CGPoint(x: offset + controlPoints[1].x, y: controlPoints[1].y)
            self.layer.addSublayer(c2Text)
        }
        
    }
}
