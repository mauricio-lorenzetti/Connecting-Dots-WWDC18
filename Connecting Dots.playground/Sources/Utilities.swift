import Foundation
import UIKit

public extension CGFloat {
    ///Returns radians if given degrees
    var radians: CGFloat{ return self * .pi / 180 }
}

public extension CGPoint {
    ///Rotates point by given degrees
    func rotate(origin: CGPoint? = CGPoint(x: 0.5, y: 0.5), byDegrees: CGFloat) -> CGPoint {
        guard let origin = origin else {return self}
        
        let rotationSin = sin(byDegrees.radians)
        let rotationCos = cos(byDegrees.radians)
        
        let x = (self.x * rotationCos - self.y * rotationSin) + origin.x
        let y = (self.x * rotationSin + self.y * rotationCos) + origin.y
        
        return CGPoint(x: x, y: y)
    }
    
    //Rotate point by given radians around origin
    func rotate(origin: CGPoint? = CGPoint(x: 0.0, y: 0.0), byRadians: CGFloat) -> CGPoint {
        guard let origin = origin else {return self}
        
        let rotationSin = sin(byRadians)
        let rotationCos = cos(byRadians)
        
        let x = (self.x * rotationCos - self.y * rotationSin) + origin.x
        let y = (self.x * rotationSin + self.y * rotationCos) + origin.y
        
        return CGPoint(x: x, y: y)
    }
}

//random parameter-generating functions
public extension Array {
    
    func randomElement() -> Element {
        return self[random(0..<self.count)]
    }
    
    private func random(_ range:Range<Int>) -> Int {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
}

public func random(_ range:Range<Int>) -> Int {
    return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
}

public func randomElement<T>(from s:[T]) -> T {
    return s[random(0..<s.count)]
}

public func randomEven(_ range:Range<Int>) -> Int {
    var r:Int;
    repeat {
        r = random(range)
    } while (r % 2 != 0)
    return r
}

public func randomOdd(_ range:Range<Int>) -> Int {
    var r:Int;
    repeat {
        r = random(range)
    } while (r % 2 == 0)
    return r
}

public func headsOrTails() -> Bool {
    return random(0..<2) % 2 == 0
}
