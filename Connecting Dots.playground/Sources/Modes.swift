import Foundation
import UIKit

public enum RotationType {
    case clockwise (period: CFTimeInterval)
    case anticlockwise (period: CFTimeInterval)
    case still
}

public enum PetalDetailType {
    case circle (radius: CGFloat, offset: CGFloat, fillColor: CGColor)
    case none
}

