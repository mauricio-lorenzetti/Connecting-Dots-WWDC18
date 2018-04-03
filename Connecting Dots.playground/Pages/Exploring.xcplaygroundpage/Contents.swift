//: [Previous](@previous)
import Foundation
import CoreGraphics
import SpriteKit
import UIKit
import PlaygroundSupport
//: ## Exploring a bit more... 🔍🔍
//: Now lets explore some of the possibilities that this mandala architect algorithm offers us
//:
//: ---
//: ### Global values 🌎
//: Every pattern drawing parameter has a default value, most of them defined at runtime, all of them globally definable, and used in case of parameter omission. This makes possible to generate surprising mandalas with really little code. Every parameter of every pattern has its action detailed on the method documentation and can be easily acessed by clicking on the method while holding the **⌥ Opt** key,  let's review some of the most relevant parameters here.
//: \
//: ![Mandala Parameters](mandala_explained.png "Mandala Parameters")
//: \
//: Some of the parameters are explained in the picture above
//: + **Global Parameters**:
//:     + **lineWidth**: width of the contour line, globally defined as a random value from 1.7 to 2.5.
//:     + **layerWidth**: width of each layer, globally defined as 60.0 pixels.
//:     + **offset**: width of the contour line, globally defined as a random value from 1.7 to 2.5.
//:     + **animationDuration**: Defaults to 8.0, how long a pattern will take to be drawn.
//:     + **rotation**: whole layer animation, default is .still (no rotation)
//: \
//: *only for petal, reversed petal and drop patterns.*
//:     + **factor**: changes the density of lines on the layer.
//:     + **detail**: additional drawing made over the layer, only one is currently available, circles.
//:     + **phase**: if set 'true', rotates the whole layer half of the width of a single pattern entity
//:\
//: Now, let's review how colors are defined.
//:
//: ---
//: ### Colors 🎨
//: For the colors we have 3 possibilities, choosing a totally random color each time, defining a global value for *Global.strokeColor* and *Global.fillColor* of choosing one of the predefined color palletes and setting its *colors* vector to *Global.fillColorPallete* and *Global.strokeColorPallete*.
//: \
//: Currently there are 5 palletes available, *UIColor.Pallete.Clear, UIColor.Pallete.Vibrating, UIColor.Pallete.Hot, UIColor.Pallete.AppleLogo and UIColor.Pallete.FlatColors*.
/*:
 * Experiment:
 Go ahead and try varying the global and individual parameters of the patterns and see the result in the overriden interaction() method below
 */
class MandalaExploration: MandalaView {
/*:
 * Callout(Patterns available):
 The 5 following patterns are available for the mandala construction:
 \
 addPetalLayer()
 \
 addDropLayer()
 \
 addCirclesLayer()
 \
 addReversedPetalLayer()
 \
 addBorderLayer()
 */
    
    override func interaction() {
        //setting global values
        Global.fillPallete = UIColor.Pallete.Vibrating.colors
        Global.strokePallete = [UIColor.white, UIColor.lightGray, UIColor.gray, UIColor.black]
        Global.lineWidth = 3.0
        
        addPetalLayer()
        addBorderLayer()
        addCirclesLayer()
        addReversedPetalLayer()
        addBorderLayer(lineWidth: 5)
        addCirclesLayer(circleRadius: 10, slices: 10)
        addBorderLayer(lineWidth: 5)
        addReversedPetalLayer(slices: 6, sharpness: 0, offset: 0, lineWidth: 2.0, layerWidth: 50, factor: 3, phase: true, rotation: .anticlockwise(period: 30.0), detail: .circle(radius: 8, offset: 15, fillColor: Global.fillColor))
        addDropLayer(slices: 10, offset: 0, lineWidth: 4, layerWidth: 70, factor: 2, phase: false, rotation: .clockwise(period: 30.0), detail: .circle(radius: 10, offset: 15, fillColor: Global.fillColor))
    }
}

//: With all this possibilities we can create [MUCH MORE!!](@previous)

import PlaygroundSupport
PlaygroundPage.current.liveView = MandalaExploration()
