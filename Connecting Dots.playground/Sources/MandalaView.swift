import CoreGraphics
import Foundation
import UIKit

/// A view capable of drawing and animating a mandala just by adding layers with the following methods.
/// Every parameter of the layers have by default random values, so omitting them increases the randomness of the final mandala drawing
/// - Available layer-adding methods so far:
///   - addPetalLayer()
///   - addBorderLayer()
///   - addCirclesLayer()
///   - addDropLayer()
///   - addAppleLayer()
///   - addReversedPetalLayer()
///
/// - randomize(layers:) method can be called in order to draw a totally random new mandala. If 'layers' is not specified, the resulting mandala will have 4 layers with randomly chosen layer patterns.
open class MandalaView: UIView {
    
    //parameters:
    var currentLayer:Double = 1
    var startRad:CGFloat = 0.0
    
    public init() {
        super.init(frame: Global.frame)
        
        //background setup
        self.backgroundColor = Global.backgroundColor
        self.layer.addSublayer(SkyLayer())
        
        //optimizing for performance
        self.layer.isOpaque = true
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale/3.0
        //self.contentScaleFactor = 0.5
        //self.layer.contentsScale = 1.0
        //self.layer.drawsAsynchronously = true
        
        //THE MAGIC
        self.interaction()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //interaction
    open func interaction() {}
    
    public func randomize(layers: Int = 4) {
        for _ in 0..<layers {
            let which = random(0..<4)
            if (headsOrTails()) {
                addBorderLayer()
            }
            switch (which) {
            case 0:
                addPetalLayer()
            case 1:
                addDropLayer()
            case 2:
                addReversedPetalLayer()
            default:
                addCirclesLayer()
            }
        }
    }
    
    //patterns
    
    /// Adds a Petal pattern layer to the mandala
    ///
    /// - Parameters:
    ///   - slices: base number of petals, the final number of petals varies with the 'factor' variable and the current layer drawing
    ///   - sharpness: varies from -1.0 to 1.0, changes how sharp the petals will be
    ///   - crossings: how many petals overlays one another
    ///   - offset: distance from petal ending to next layer start
    ///   - lineWidth: stroke line width
    ///   - layerWidth: width of the layer
    ///   - factor: varies the density of drawing
    ///   - phase: draws pattern radially out of phase
    ///   - animationDuration: how long the drawing will take to complete
    ///   - rotation: type of rotation of this layer, defaults to no rotation
    ///   - detail: type of detail drawing on the petals
    ///   - fillColor: color of petals
    ///   - strokeColor: color of petals stroke
    ///   - random: if true, every parameter passed is ignored, Global and random values are used instead
    public func addPetalLayer(
        slices:CGFloat = CGFloat(random(4..<10)),
        sharpness:CGFloat = CGFloat(random(-1000..<1000))/1000.0,
        offset:CGFloat = Global.offset,
        lineWidth:CGFloat = Global.lineWidth,
        layerWidth:CGFloat = Global.layerWidth,
        factor:CGFloat = Global.factor,
        phase:Bool = Global.phase,
        animationDuration:CFTimeInterval = Global.animationDuration,
        rotation:RotationType = Global.rotation,
        detail:PetalDetailType = Global.detail,
        fillColor:CGColor = Global.fillColor,
        strokeColor:CGColor = Global.strokeColor,
        random: Bool = false
        )
    {
        if (random) {
            addPetalLayer()
            return
        }
        
        //drawing setup
        let crossings = factor
        let slices = slices * factor * CGFloat(currentLayer)
        let endRad = startRad + layerWidth + lineWidth/2.0
        let bezierPath = UIBezierPath()
        let animations = createAnimations(rotation: rotation)
        let phaseTransform = createTransform(phase: phase, slices: slices)
        
        //pattern drawing
        let petalStart = max(0, startRad-layerWidth)
        let petalHeightControl:CGFloat = crossings * (sin(2.0*CGFloat.pi/slices) * (startRad + (layerWidth/2.0)))
        bezierPath.move(to: CGPoint(x: petalStart, y: 0))
        bezierPath.addQuadCurve(to: CGPoint(x: endRad-offset, y: 0), controlPoint: CGPoint(x:(currentLayer == 1 ? (endRad-offset)/2.0 : startRad+offset) + (layerWidth * sharpness), y: petalHeightControl))
        bezierPath.addQuadCurve(to: CGPoint(x: petalStart+offset, y: 0), controlPoint: CGPoint(x:(currentLayer == 1 ? (endRad-offset)/2.0 : startRad+offset) + (layerWidth * sharpness), y: -petalHeightControl))
        
        drawPattern(slices: slices, path: bezierPath, strokeColor: strokeColor, fillColor: fillColor, lineWidth: lineWidth, endRad: endRad, animationDuration: animationDuration, animations: animations, transform: phaseTransform)
        
        //detail drawing
        switch detail {
        case .circle(let radius, let offset, let fillColor):
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: startRad + offset, y: 0), radius: radius, startAngle: 0.0, endAngle: 2.0*CGFloat.pi, clockwise: true)
            
            drawPattern(slices: slices, path: circlePath, strokeColor: strokeColor, fillColor: fillColor, lineWidth: lineWidth, endRad: endRad, animationDuration: animationDuration, animations: animations, transform: phaseTransform)
            
        case .none:
            break
        }
        
        //updates for the next layer drawing
        updateForNextLayer(endRad: endRad)
        
    }
    
    
    /// Adds a Border to the previous layer
    ///
    /// - Parameters:
    ///   - lineWidth: stroke line width
    ///   - animationDuration: how long the drawing will take to complete
    ///   - clockwise: stroke animation drawing sense
    ///   - strokeColor: color of border stroke
    ///   - random: if true, every parameter passed is ignored, Global and random values are used instead
    public func addBorderLayer(
        lineWidth:CGFloat = Global.lineWidth,
        animationDuration:CFTimeInterval = Global.animationDuration,
        clockwise:Bool = headsOrTails(),
        strokeColor:CGColor = Global.strokeColor,
        random: Bool = false
        )
    {
        if (random) {
            addBorderLayer()
            return
        }
        //drawing setup
        let endRad = startRad + lineWidth
        let bezierPath = UIBezierPath()
        
        //pattern drawing
        bezierPath.addArc(withCenter: .zero, radius: (endRad + startRad)/2.0, startAngle: 0, endAngle: 2.0*CGFloat.pi, clockwise: clockwise)
        
        drawPattern(slices: 1.0, path: bezierPath, strokeColor: strokeColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth, endRad: endRad, animationDuration: animationDuration)
        
        //updates for the next layer drawing
        startRad = endRad
    }
    
    /// Adds a layer full of same radius circles
    ///
    /// - Parameters:
    ///   - circleRadius: radius of the circles
    ///   - slices: base number for amount of circles definition
    ///   - lineWidth: stroke line width
    ///   - animationDuration: how
    ///   - animationDuration: how long the drawing will take to complete
    ///   - clockwise: stroke animation drawing sense
    ///   - fillColor: color of petals
    ///   - strokeColor: color of petals stroke
    ///   - random: if true, every parameter passed is ignored, Global and random values are used instead
    public func addCirclesLayer(
        circleRadius:CGFloat = CGFloat(random(5..<18)),
        slices:CGFloat = CGFloat(random(8..<16)),
        lineWidth:CGFloat = Global.lineWidth,
        animationDuration:CFTimeInterval = Global.animationDuration,
        rotation: RotationType = Global.rotation,
        clockwise:Bool = headsOrTails(),
        fillColor:CGColor = Global.fillColor,
        strokeColor:CGColor = Global.strokeColor,
        random: Bool = false
        )
    {
        if (random) {
            addCirclesLayer()
            return
        }
        //drawing setup
        let slices = slices * CGFloat(currentLayer)
        let endRad = startRad + lineWidth + (2.0 * circleRadius)
        let bezierPath = UIBezierPath()
        let animations = createAnimations(rotation: rotation)
        
        //detail drawing
        bezierPath.append(UIBezierPath(arcCenter: CGPoint(x: startRad + circleRadius + lineWidth/2.0, y: 0), radius: circleRadius, startAngle: 0.0, endAngle: 2.0*CGFloat.pi, clockwise: clockwise))
        
        drawPattern(slices: slices, path: bezierPath, strokeColor: strokeColor, fillColor: fillColor, lineWidth: lineWidth, endRad: endRad, animationDuration: animationDuration, animations: animations, transform: CATransform3DIdentity)
        
        //updates for the next layer drawing
        updateForNextLayer(endRad: endRad)
        
    }
    
    
    /// Adds a layer of drop patterns
    ///
    ///   - slices: base number of drops, the final number of drops varies with the 'factor' variable and the current layer drawing
    ///   - crossings: how many drops overlays one another
    ///   - offset: distance from drop ending to next layer start
    ///   - lineWidth: stroke line width
    ///   - layerWidth: width of the layer
    ///   - factor: varies the density of drawing
    ///   - phase: draws pattern radially out of phase
    ///   - animationDuration: how long the drawing will take to complete
    ///   - rotation: type of rotation of this layer, defaults to no rotation
    ///   - detail: type of detail drawing on the drops
    ///   - fillColor: color of drops
    ///   - strokeColor: color of drops stroke
    ///   - random: if true, every parameter passed is ignored, Global and random values are used instead
    public func addDropLayer(
        slices:CGFloat = CGFloat(random(8..<16)),
        offset:CGFloat = Global.offset,
        lineWidth:CGFloat = Global.lineWidth,
        layerWidth:CGFloat = Global.layerWidth,
        factor:CGFloat = Global.factor,
        phase:Bool = Global.phase,
        animationDuration:CFTimeInterval = Global.animationDuration,
        rotation:RotationType = Global.rotation,
        detail:PetalDetailType = Global.detail,
        fillColor:CGColor = Global.fillColor,
        strokeColor:CGColor = Global.strokeColor,
        random: Bool = false
        )
    {
        if (random) {
            addDropLayer()
            return
        }
        //drawing setup
        let crossings = factor
        let slices = slices * factor * CGFloat(currentLayer)
        let endRad = startRad + layerWidth + lineWidth/2.0
        let bezierPath = UIBezierPath()
        let animations = createAnimations(rotation: rotation)
        let phaseTransform = createTransform(phase: phase, slices: slices)
        
        //pattern drawing
        let dropControlY:CGFloat = crossings * 2.0 * (sin(2.0*CGFloat.pi/slices) * (startRad + (layerWidth/2.0)))
        bezierPath.move(to: CGPoint(x: startRad, y: 0))
        bezierPath.addCurve(to: bezierPath.currentPoint, controlPoint1: CGPoint(x: endRad*1.05-offset, y: dropControlY), controlPoint2: CGPoint(x: endRad*1.05-offset, y: -dropControlY))
        
        drawPattern(slices: slices, path: bezierPath, strokeColor: strokeColor, fillColor: fillColor, lineWidth: lineWidth, endRad: endRad, animationDuration: animationDuration, animations: animations, transform: phaseTransform)
        
        //detail drawing
        switch detail {
        case .circle(let radius, let offset, let fillColor):
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: startRad + offset, y: 0), radius: radius, startAngle: 0.0, endAngle: 2.0*CGFloat.pi, clockwise: true)
            
            drawPattern(slices: slices, path: circlePath, strokeColor: strokeColor, fillColor: fillColor, lineWidth: lineWidth, endRad: endRad, animationDuration: animationDuration, animations: animations, transform: phaseTransform)
        case .none:
            break
        }
        
        //updates for the next layer drawing
        updateForNextLayer(endRad: endRad)
    }
    
    
    /// Adds an Apple symbol to the center of the Mandala, works only on the first layer of the mandala
    ///
    /// - Parameters:
    ///   - lineWidth: stroke line width, defaults for twice the Global value
    ///   - animationDuration: how long the drawing will take to complete
    ///   - clockwise: stroke animation drawing sense
    ///   - strokeColor: color of drops stroke
    public func addAppleLayer(
        lineWidth:CGFloat = Global.lineWidth * 2,
        animationDuration:CFTimeInterval = Global.animationDuration,
        clockwise:Bool = headsOrTails(),
        strokeColor:CGColor = Global.strokeColor
        )
    {
        //only works on the first layer
        if (currentLayer != 1) { return }
        
        //drawing setup
        let endRad = startRad + 60.0
        let bezierPath = applePath()
        
        //path adjustments
        bezierPath.apply(CGAffineTransform
            .identity
            .scaledBy(x: 0.20, y: 0.20)
            .translatedBy(x: 0, y: 32))
        
        drawPattern(slices: 1.0, path: bezierPath, strokeColor: strokeColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth, endRad: endRad, animationDuration: animationDuration)
        
        //background
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 112, height: 112)
        gradientLayer.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        gradientLayer.colors = UIColor.Pallete.AppleLogo.colors.map({
            $0.cgColor
        })
        //centralizing the mandala drawing
        let shapeLayer = CAShapeLayer()
        bezierPath.apply(CGAffineTransform
            .identity
            .translatedBy(x: 56, y: 56))
        shapeLayer.path = bezierPath.cgPath
        gradientLayer.mask = shapeLayer
        self.layer.addSublayer(gradientLayer)
        
        //updates for the next layer drawing
        updateForNextLayer(endRad: endRad)
        
        //adds border to apple drawing
        addBorderLayer(lineWidth: lineWidth)
    }
    
    /// Adds a Reversed Petals pattern layer to the mandala
    ///
    /// - Parameters:
    ///   - slices: base number of petals, the final number of petals varies with the 'factor' variable and the current layer drawing
    ///   - sharpness: varies from -1.0 to 1.0, changes how sharp the petals will be
    ///   - crossings: how many petals overlays one another
    ///   - offset: distance from petal ending to next layer start
    ///   - lineWidth: stroke line width
    ///   - layerWidth: width of the layer
    ///   - factor: varies the density of drawing
    ///   - phase: draws pattern radially out of phase
    ///   - animationDuration: how long the drawing will take to complete
    ///   - rotation: type of rotation of this layer, defaults to no rotation
    ///   - detail: type of detail drawing on the petals
    ///   - fillColor: color of petals
    ///   - strokeColor: color of petals stroke
    ///   - random: if true, every parameter passed is ignored, Global and random values are used instead
    public func addReversedPetalLayer(
        slices:CGFloat = CGFloat(random(8..<24)),
        sharpness:CGFloat = CGFloat(random(-1000..<1000))/1000.0,
        offset:CGFloat = 0,
        lineWidth:CGFloat = Global.lineWidth,
        layerWidth:CGFloat = Global.layerWidth,
        factor:CGFloat = Global.factor,
        phase:Bool = Global.phase,
        animationDuration:CFTimeInterval = Global.animationDuration,
        rotation:RotationType = Global.rotation,
        detail:PetalDetailType = Global.detail,
        fillColor:CGColor = Global.fillColor,
        strokeColor:CGColor = Global.strokeColor,
        random: Bool = false
        )
    {
        if (random) {
            addReversedPetalLayer()
            return
        }
        
        //drawing setup
        let crossings = factor
        let slices = slices * factor * CGFloat(currentLayer)
        let endRad = startRad + layerWidth + lineWidth/2.0
        let bezierPath = UIBezierPath()
        let animations = createAnimations(rotation: rotation)
        let phaseTransform = createTransform(phase: phase, slices: slices)
        
        //pattern drawing
        let sliceAngle = crossings * CGFloat(2*Double.pi/Double(slices))
        bezierPath.move(to: CGPoint(x: endRad-offset, y: 0).rotate(byRadians: sliceAngle/2.0))
        bezierPath.addQuadCurve(to: CGPoint(x: endRad-offset, y: 0).rotate(byRadians: -sliceAngle/2.0), controlPoint: CGPoint(x: startRad-layerWidth, y: 0))
        
        drawPattern(slices: slices, path: bezierPath, strokeColor: strokeColor, fillColor: fillColor, lineWidth: lineWidth, endRad: endRad, animationDuration: animationDuration, animations: animations, transform: phaseTransform)
        
        //detail drawing
        switch detail {
        case .circle(let radius, let offset, let fillColor):
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: startRad + offset, y: 0), radius: radius, startAngle: 0.0, endAngle: 2.0*CGFloat.pi, clockwise: true)
            
            drawPattern(slices: slices, path: circlePath, strokeColor: strokeColor, fillColor: fillColor, lineWidth: lineWidth, endRad: endRad, animationDuration: animationDuration, animations: animations, transform: phaseTransform)
            
        case .none:
            break
        }
        
        //updates for the next layer drawing
        updateForNextLayer(endRad: endRad)
        
        //adds border
        addBorderLayer()
        
    }
    
    
    //>> pattern drawing auxiliar functions
    func drawPattern(slices: CGFloat, path: UIBezierPath, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat, endRad: CGFloat, animationDuration: CFTimeInterval, animations: [CAAnimation] = [], transform: CATransform3D = CATransform3DIdentity) {
        
        var layers:[CALayer] = []
        
        //stroke drawing
        let shapeLayer = strokeLayer(path: path, strokeColor: strokeColor, lineWidth: lineWidth, transform: transform)
        
        //masking as a donut
        shapeLayer.mask = donutMask(from: startRad-lineWidth, to: endRad+lineWidth)
        
        //animating the stroke
        shapeLayer.add(strokeAnimation(animationDuration: animationDuration), forKey: "strokeAnimation")
        
        //setting shapeLayer to draw
        layers.append(shapeLayer)
        
        //coloring drawing: circle inside out
        if (fillColor.alpha != 0.0) {
            let colorLayer = coloringLayer(path: path.cgPath, endRad: endRad, fillColor: fillColor, transform: transform, animationDuration: animationDuration)
            layers.append(colorLayer)
        }
        
        //centralizing the mandala drawing
        let transform = CATransform3DMakeTranslation(self.frame.midX, self.frame.midY, 0.0)
        
        //adding replicated layer to mandala
        self.layer.addSublayer(replicatingLayer(subLayers: layers, slices: slices, transform: transform, animationDuration: animationDuration, animations: animations))
    }
    
    func strokeLayer(path: UIBezierPath, strokeColor: CGColor, lineWidth: CGFloat, transform: CATransform3D = CATransform3DIdentity) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.transform = transform
        shapeLayer.path = path.cgPath
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor
        
        return shapeLayer
    }
    
    func replicatingLayer(subLayers: [CALayer], slices: CGFloat, transform: CATransform3D, animationDuration: CFTimeInterval, animations: [CAAnimation]) -> CAReplicatorLayer {
        
        let replicatorLayer = CAReplicatorLayer()
        for layer in subLayers {
            replicatorLayer.addSublayer(layer)
        }
        for anim in animations {
            replicatorLayer.add(anim, forKey: "animation")
        }
        
        replicatorLayer.instanceCount = Int(slices)
        let rotationAngle = 2.0 * CGFloat.pi/CGFloat(slices)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(rotationAngle, 0.0, 0.0, 1.0)
        replicatorLayer.transform = transform
        
        return replicatorLayer
    }
    
    func donutMask(from smallerRadius: CGFloat, to largerRadius: CGFloat) -> CAShapeLayer {
        //donut clipping mask
        let clippingPath = donutPath(from: smallerRadius, to: largerRadius)
        let maskLayer = CAShapeLayer()
        maskLayer.path = clippingPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        return maskLayer
    }
    
    func donutPath(from smallerRadius: CGFloat, to largerRadius: CGFloat) -> CGPath {
        let clippingPath = UIBezierPath(arcCenter: .zero, radius: smallerRadius, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2), clockwise: false)
        clippingPath.append(UIBezierPath(arcCenter: .zero, radius: largerRadius, startAngle: 0.0, endAngle: CGFloat(Double.pi * 2), clockwise: false))
        
        return clippingPath.cgPath
        
    }
    
    func strokeAnimation(animationDuration duration: CFTimeInterval) -> CAAnimation {
        //stroke animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 2.0*duration
        animation.beginTime = CACurrentMediaTime() + duration/5.0 * currentLayer
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fillMode = kCAFillModeBoth
        
        return animation
    }
    
    func coloringLayer(path: CGPath, endRad: CGFloat, fillColor: CGColor, transform: CATransform3D?, animationDuration: CFTimeInterval) -> CAShapeLayer {
        //coloring layer
        let colorShapeLayer = CAShapeLayer()
        colorShapeLayer.path = path
        colorShapeLayer.strokeColor = UIColor.black.cgColor
        colorShapeLayer.fillColor = fillColor
        colorShapeLayer.zPosition = -10
        if let transform = transform { colorShapeLayer.transform = transform }
        
        //coloring animation
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = donutPath(from: startRad, to: startRad)
        animation.toValue = donutPath(from: startRad, to: endRad)
        animation.duration = 2.0*animationDuration*currentLayer/3.0
        animation.beginTime = CACurrentMediaTime() + animationDuration/5.0 * currentLayer
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.fillMode = kCAFillModeBoth
        
        //coloring masking
        let colorMaskLayer = CAShapeLayer()
        colorMaskLayer.path = donutPath(from: startRad, to: endRad)
        colorMaskLayer.fillRule = kCAFillRuleEvenOdd
        colorMaskLayer.add(animation, forKey: "maskPathAnimation")
        colorShapeLayer.mask = colorMaskLayer
        
        return colorShapeLayer
    }
    
    //>> animations
    public func rotationAnimation(duration: CFTimeInterval = CFTimeInterval([10.0, 20.0, 30.0].randomElement()), clockwise: Bool = headsOrTails()) -> CAAnimation {
        //rotation code: custom animation example for patterns
        let duration = duration * currentLayer
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.byValue = NSNumber(value: (clockwise ? 2.0 : -2.0) * Double.pi as Double)
        rotation.duration = duration
        rotation.repeatCount = Float.infinity
        
        return rotation
    }
    
    //>> parameter-specific generators
    func createTransform(phase: Bool = false, slices: CGFloat) -> CATransform3D {
        if (phase) {
            return CATransform3DMakeRotation(CGFloat.pi/slices, 0.0, 0.0, 1.0)
        }
        return CATransform3DIdentity
    }
    
    func createAnimations(rotation: RotationType = .still) -> [CAAnimation] {
        var animations:[CAAnimation] = []
        switch rotation {
        case .clockwise(let period):
            animations.append(rotationAnimation(duration: period, clockwise: true))
        case .anticlockwise(let period):
            animations.append(rotationAnimation(duration: period, clockwise: false))
        case .still:
            break
        }
        
        return animations
    }
    
    func applePath() -> UIBezierPath {
        let bezierPath = UIBezierPath()
        let path188Path = UIBezierPath()
        path188Path.move(to: CGPoint(x: 136.12, y: -1.34))
        path188Path.addCurve(to: CGPoint(x: 190.89, y: -92.72), controlPoint1: CGPoint(x: 135.54, y: -62.12), controlPoint2: CGPoint(x: 188.5, y: -91.3))
        path188Path.addCurve(to: CGPoint(x: 98.17, y: -140.37), controlPoint1: CGPoint(x: 161.09, y: -134.04), controlPoint2: CGPoint(x: 114.72, y: -139.7))
        path188Path.addCurve(to: CGPoint(x: 1.17, y: -118.36), controlPoint1: CGPoint(x: 58.73, y: -144.15), controlPoint2: CGPoint(x: 21.17, y: -118.36))
        path188Path.addCurve(to: CGPoint(x: -82.45, y: -139.22), controlPoint1: CGPoint(x: -18.82, y: -118.36), controlPoint2: CGPoint(x: -49.74, y: -139.83))
        path188Path.addCurve(to: CGPoint(x: -187.31, y: -79.01), controlPoint1: CGPoint(x: -125.5, y: -138.61), controlPoint2: CGPoint(x: -165.14, y: -115.52))
        path188Path.addCurve(to: CGPoint(x: -155.21, y: 162.97), controlPoint1: CGPoint(x: -231.99, y: -5.54), controlPoint2: CGPoint(x: -198.71, y: 103.34))
        path188Path.addCurve(to: CGPoint(x: -75.2, y: 223.76), controlPoint1: CGPoint(x: -133.9, y: 192.13), controlPoint2: CGPoint(x: -108.54, y: 224.97))
        path188Path.addCurve(to: CGPoint(x: 7.85, y: 204.08), controlPoint1: CGPoint(x: -43.07, y: 222.55), controlPoint2: CGPoint(x: -30.93, y: 204.08))
        path188Path.addCurve(to: CGPoint(x: 91.5, y: 223.18), controlPoint1: CGPoint(x: 46.62, y: 204.08), controlPoint2: CGPoint(x: 57.55, y: 223.76))
        path188Path.addCurve(to: CGPoint(x: 169.08, y: 164.16), controlPoint1: CGPoint(x: 126.02, y: 222.55), controlPoint2: CGPoint(x: 147.94, y: 193.4))
        path188Path.addCurve(to: CGPoint(x: 204.15, y: 95.83), controlPoint1: CGPoint(x: 193.48, y: 130.31), controlPoint2: CGPoint(x: 203.57, y: 97.56))
        path188Path.addCurve(to: CGPoint(x: 136.12, y: -1.34), controlPoint1: CGPoint(x: 203.38, y: 95.53), controlPoint2: CGPoint(x: 136.82, y: 71.34))
        path188Path.close()
        path188Path.miterLimit = 4
        
        let path190Path = UIBezierPath()
        path190Path.move(to: CGPoint(x: 58.76, y: -203.62))
        path190Path.addCurve(to: CGPoint(x: 82.46, y: -284.5), controlPoint1: CGPoint(x: 74.67, y: -225.04), controlPoint2: CGPoint(x: 85.42, y: -254.82))
        path190Path.addCurve(to: CGPoint(x: 15.33, y: -246.1), controlPoint1: CGPoint(x: 59.53, y: -283.48), controlPoint2: CGPoint(x: 31.79, y: -267.52))
        path190Path.addCurve(to: CGPoint(x: -8.83, y: -167.77), controlPoint1: CGPoint(x: 0.59, y: -227.18), controlPoint2: CGPoint(x: -12.33, y: -196.85))
        path190Path.addCurve(to: CGPoint(x: 58.76, y: -203.62), controlPoint1: CGPoint(x: 16.74, y: -165.57), controlPoint2: CGPoint(x: 42.85, y: -182.24))
        path190Path.close()
        path190Path.miterLimit = 4
        
        bezierPath.append(path188Path)
        bezierPath.append(path190Path)
        
        return bezierPath
    }
    
    func updateForNextLayer(endRad:CGFloat) {
        //updates for the next layer drawing
        startRad = endRad
        currentLayer += 1
    }
    
}
