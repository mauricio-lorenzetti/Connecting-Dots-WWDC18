import Foundation
import CoreGraphics
import UIKit

class SkyLayer: CAEmitterLayer {
    
    init(width: CGFloat = 1800.0){
        super.init()
        self.emitterPosition = .zero
        self.emitterShape = kCAEmitterLayerLine
        self.emitterSize = CGSize(width: width, height: 1)
        
        self.emitterCells = (1..<4).map({ intensity in
        
            let intensity = CGFloat(intensity)
            
            let cell = CAEmitterCell()
            
            cell.birthRate = 2.5 * Float(4-intensity)
            cell.lifetime = 60.0
            cell.velocity = 30.0 - intensity*7.0
            cell.velocityRange = 5.0
            
            cell.xAcceleration = 0
            cell.yAcceleration = 0
            cell.zAcceleration = 0
            
            cell.emissionLongitude = CGFloat.pi
            
            cell.scale = 0.2 - intensity/35.0
            cell.contents = UIImage(named: "star.png")!.cgImage
            
            return cell
        })
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
