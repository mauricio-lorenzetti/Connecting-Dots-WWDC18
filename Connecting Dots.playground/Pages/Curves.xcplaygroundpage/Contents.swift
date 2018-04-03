
//: [Previous](@previous)
//: ## Playing with Curves
//: Curves are a much more fun type of line and understanding them enables us to accomplish much more when doing smooth and visual appealing graphics
//: \
//: \
//: Here we are going to see one really special type of curve, used in almost every single computer-generated graphic due to it ease of understanding and wide range of applications, I present you: the **Bezier Curve**.

//: ![Bezier Curves](bezier.png "Bezier Curves")

//: *Bezier curves are lines from one point to another which have its curvature defined by intermediate points on the plane*

/*:
 * Experiment:
 So, lets play with bezier curves! In addition to changing the start and end dots of the line, you can change the intermediate dots too and see how it reacts to those changes
 */

import CoreGraphics
import Foundation
import UIKit
class AxisInteractiveCurve: AxisView {
    
    override func interaction() {
        let fromPoint = Dot(x: 150.0, y: 100.0)
        let toPoint = Dot(x: 450.0, y: 500.0)
        let controlPoints = [
            Dot(x: 10, y: 600),
            Dot(x: 550, y: 300)
        ]
/*:
 - Note:
 Add more curves! The addCurve(from:to:controlPoints) method accepts up to two Dot objects on the control points array, a draws the corresponding curve. If no control points are provided, the resulting curve is a straigth line.
*/
        
        addCurve(from: fromPoint, to: toPoint, controlPoints: controlPoints)
        addCurve(from: fromPoint, to: toPoint, controlPoints: controlPoints.reversed())
        addCurve(from: fromPoint, to: toPoint, controlPoints: [controlPoints[0]])
        addCurve(from: fromPoint, to: toPoint, controlPoints: [])
        
    }
}

//: And with just those basic dot-connecting elements, straight lines and curves, and a little bit of effort we can achieve much more than some simple lines on the screen and we are going to connect those dots [next](@next).

import PlaygroundSupport
PlaygroundPage.current.liveView = AxisInteractiveCurve()
