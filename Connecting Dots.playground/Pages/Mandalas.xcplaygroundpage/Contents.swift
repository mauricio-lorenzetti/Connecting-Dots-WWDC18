//: [Previous](@previous)
import Foundation
import CoreGraphics
import SpriteKit
import UIKit
import PlaygroundSupport
//: ## A beautiful way of connecting dots 🌀
//: Now, with the tools that we have developed so far and some other tricks that **Swift** offers to us, we can start making something beautiful out of it.
//: And a really interesting choice for this are **Mandalas**.
//: \
//: ![Mandala](mandala.png "Mandala")
//: ## The Mandala
//: Mandala means literally circle, and throughout the history almost every human civilization have used the circle as some kind of spiritual symbol in many rituals and traditions. In the western psychology circles and mandalas are currently beign used as an instrument of self-examination, aiming to achieve the feeling of wholeness and self-knowledge, aiming to not just understand and connect the dots of life, but completing and closing them, like a circle does.
//: ## So, lets draw some mandalas!
//: With the following class we use the concepts seen before to create an almost endless number of totally different and beautiful mandalas.
//: By adding patterns and tweaking its parameters this code makes possible to create totally predictable mandalas, or totally random ones, by omitting the same parameters, letting the code handle those values itself
/*:
 * Experiment:
 Try adding some patterns in the overriden interaction() method below, and see what happens, there are many possible patterns to be added and each one of them have lots of parameters that can be omitted, omitting them increases the randomness of the final drawing,
 Mess with the patterns properties, if you're unsure of what they do, click on them while holding the **⌥ Opt** key.
 */
class MandalaInteractive: MandalaView {
    
/*:
 * Callout(Patterns available):
 The 5 following patterns are available for the mandala construction:
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
/*:
 - Note:
 The randomize(layers:) method creates a totally random mandala with random patterns, the default number of layers are 4, if the parameter is not provided
 */
    
    override func interaction() {
        
//        addDropLayer()
//        addReversedPetalLayer()
//        addPetalLayer()
//        addBorderLayer()
//        addCirclesLayer()
//        addBorderLayer()
//        addCirclesLayer()
//
        randomize(layers: 4)
    }
}

//: In this code the pattern is drawn and replicated radially symmetrical around the center.
//: Each pattern bounded to concentrics circular rings of increasing and juxtaposed sizes.
//: The sum of all of these rings of variable patterns results in a humongous number of possible mandalas!!
//: \
//: \
//: On the next pages we are going to explore the capabilities of those [drawings](@next).

import PlaygroundSupport
PlaygroundPage.current.liveView = MandalaInteractive()
