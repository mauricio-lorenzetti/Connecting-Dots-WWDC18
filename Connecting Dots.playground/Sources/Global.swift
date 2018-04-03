import Foundation
import UIKit
import CoreGraphics

public typealias Dot = CGPoint

public struct Global {
    
    //environment variables
    public static var frame:CGRect = CGRect(x: 0, y: 0, width: 550, height: 550)
    public static var textColor:CGColor = UIColor.white.cgColor
    public static var backgroundColor:UIColor = UIColor(patternImage: UIImage(named: "stars_bg.png")!)
    
    //pattern variables
    private static var pLineWidth:CGFloat?
    public static var lineWidth:CGFloat {
        get {
            if let v = pLineWidth {
                return v
            }
            return CGFloat([1.75, 2.0, 2.5].randomElement())
        }
        set (newValue) {
            self.pLineWidth = newValue
        }
    }
    //prevent two identical colors next to each other
    private static var lastFillOddity:Bool = false
    private static var pFillColor:CGColor?
    public static var fillColor:CGColor {
        get {
            if let v = pFillColor {
                return v
            }
            if let v = fillPallete {
                if (v.count == 1) { return v[0].cgColor }
                var color = v.randomElement()
                while ((lastFillOddity && v.index(of: color)! % 2 == 1)  ||
                       (!lastFillOddity && v.index(of: color)! % 2 == 0)) {
                        color = v.randomElement()
                }
                lastFillOddity = !lastFillOddity
                return color.cgColor
            }
            return UIColor(red: CGFloat(random(0..<256))/255.0, green: CGFloat(random(0..<256))/255.0, blue: CGFloat(random(0..<256))/255.0, alpha: CGFloat(random(70..<101))/100.0).cgColor
        }
        set (newValue) {
            self.pFillColor = newValue
        }
    }
    private static var pStrokeColor:CGColor?
    public static var strokeColor:CGColor {
        get {
            if let v = pStrokeColor {
                return v
            }
            if let p = strokePallete {
                return p.randomElement().cgColor
            }
            return UIColor.white.cgColor
        }
        set (newValue) {
            self.pStrokeColor = newValue
        }
    }
    public static var layerWidth:CGFloat = 50.0
    private static var pFactor:CGFloat?
    public static var factor:CGFloat {
        get {
            if let v = pFactor {
                return v
            }
            return 1.0
        }
        set (newValue) {
            self.pFactor = newValue
        }
    }
    private static var pOffset:CGFloat?
    public static var offset:CGFloat {
        get {
            if let v = pOffset {
                return v
            }
            return 0.0
        }
        set (newValue) {
            self.pOffset = newValue
        }
    }
    public static var animationDuration:CFTimeInterval = 8.0
    public static var fillPallete:[UIColor]? = UIColor.Pallete.Hot.colors
    private static var pStrokePallete:[UIColor]?
    public static var strokePallete:[UIColor]? {
        get {
            if let v = pStrokePallete {
                var array = [UIColor.white]
                for color in v {
                    array.append(color)
                }
                return array
            }
            return nil
        }
        set (newValue) {
            self.pStrokePallete = newValue
        }
    }
    public static var rotation:RotationType = .still
    public static var pDetail:PetalDetailType?
    public static var detail:PetalDetailType {
        get {
            if let v = pDetail {
                return v
            }
            if (headsOrTails()) {
                return .circle(radius: CGFloat(random(5000..<15000))/1000.0, offset: CGFloat(random(0..<100*Int(layerWidth)))/100.0, fillColor: fillColor)
            }
            return .none
        }
        set (newValue) {
            self.pDetail = newValue
        }
    }
    private static var pPhase:Bool?
    public static var phase:Bool {
        get {
            if let v = pPhase {
                return v
            }
            return headsOrTails()
        }
        set (newValue) {
            self.pPhase = newValue
        }
    }
}

