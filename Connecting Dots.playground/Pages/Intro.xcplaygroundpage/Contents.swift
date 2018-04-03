//: # Connecting Dots

//: ## "It's about connecting the dots" - Steve Jobs
//: \
//: \
//: I really been into computer graphics for some time  and really like all the math behind it, when I began studying **Swift** I've found out that it handles graphics by many interesting ways, and that's what I'm going to show you here, but first, lets start from the beginning.
//: \
//: \
//: When we talk about computer graphics we basically rely on lines to do the drawings, simple elements that connects two dots and those lines can be further split into two categories, straight lines and curves
//: And combining those elements with 'CoreAnimation', masks, 'CAReplicatorLayer' and some other **Swift** tools we are going to build astonishing graphics!
//:
//: ---
//:
//: ### Straight Lines
//:
//: Lines connects dots, right, and straight lines are the most straightforward way of doing this (no pun intended)
/*:
 * Experiment:
 Go ahead and play with the lines, try changing the fromPoint and toPoint coordinates of the line and see what happens
 */

import CoreGraphics
import Foundation
import UIKit
class AxisInteractiveLine: AxisView {
    
//: The **Dot** class is just a typealias for **CGPoint**, it represents a point with (x,y) coordinates on the screen
/*:
 - Note:
 Add lines to the screen! The available addLine(from:to:) method adds one line between two provided Dot objects, try adding more lines to the screen uncommenting the line below
 */
    
    override func interaction() {
        let fromPoint = Dot(x: 150.0, y: 150.0)
        let toPoint = Dot(x: 300.0, y: 450.0)
        
        addLine(from: fromPoint,  to: toPoint)
        
        //addLine(from: Dot(x: 250.0, y: 100.0), to: Dot(x: 350.0, y: 500.0))
        
    }
}

//: When talking about computer graphics, straight lines are indeed the simplest but also the most boring way of connecting dots, so lets dive into something a little more interesting next, let's play with [Curves](@next)!

import PlaygroundSupport
PlaygroundPage.current.liveView = AxisInteractiveLine()
