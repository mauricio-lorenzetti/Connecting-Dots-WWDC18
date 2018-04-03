//: [Previous](@previous)
import Foundation
import CoreGraphics
import SpriteKit
import UIKit
import PlaygroundSupport
//: ## Connecting dots? Maybe more...
//: Mandalas are complex drawings, that when manually made take a lot of time and dedication, like this single playground. Mandalas also shouldn't be kept, it is not about its beautifulness but the time invested working on it, the elements that initially appear to be just random dots slowly makes sense one with another and as the dots are connected we can see meaning on the mandala itself.\
//: One interesting fact to be noticed is that mandalas not only connects its dots but close all of them, maintaining symmetry while not letting not a single line without closure.\
//: This completude naturally makes us feel good and the mandala is, most of the times, pleasing to stare at, it deals with the feeling of self-sufficiency and independence, aspirations of every human being, according to Maslow and Jung, precursors of the modern western psychology.
//:
//: ---
//: ### Closing the dots ✈️
//: ## "You can't connect the dots looking forward. You can only connect them looking backwards." - Steve Jobs
//:
//: ![Circle](connecting_circles.png "Circle")
//:
//: Like a mandala, the dots only makes sense with the mandala complete, as my interest in computer graphics led me to the conception of the idea of this playground, something that I couldn't even imagine long ago, before starting studying **Swift** or even further. And I hope that this dot here connects me to WWDC 2018!\
//: So I prepared a final mandala for us, hope you like it like I do.
/*:
 * Experiment:
 Just watch this beautiful mandala form itself with the old apple logo colors! You can change the parameters and modify this mandala as you want.
 */
class MandalaExploration: MandalaView {
/*:
 * Callout(Hidden patterns found!):
     addAppleLayer() works only in the first layer and the gradient have the old and new colors of apple logo
 */
    
    override func interaction() {
        //setting global values
        Global.fillPallete = UIColor.Pallete.AppleLogo.colors
        Global.strokePallete = nil
        Global.lineWidth = 3.0
        Global.layerWidth = 70.0
        
        addAppleLayer()
        addBorderLayer(lineWidth: 5)
        addCirclesLayer(circleRadius: 8, slices: 14)
        addBorderLayer(lineWidth: 5)
        addPetalLayer(slices: 8, sharpness: 0.5, offset: 0, lineWidth: 2.0, layerWidth: 50, factor: 2, rotation: .anticlockwise(period: 30.0), detail: .circle(radius: 8, offset: 20, fillColor: Global.fillColor))
        addReversedPetalLayer(detail: .none)
        addBorderLayer()
        addCirclesLayer(circleRadius: 10, slices: 15, rotation: .clockwise(period: 45.0))
        addBorderLayer()
        
    }
}

//: And now I'm closing this. Its is all I have to say. Hope it all made sense for you.
//: \
//: Thank you very much!

import PlaygroundSupport
PlaygroundPage.current.liveView = MandalaExploration()
