import Foundation
import UIKit

public extension UIColor {
    
    public struct Background {
        public static let Dark = UIColor(red:0.00, green:0.00, blue:0.04, alpha: 1.0)
    }
    
    public struct Graphics {
        public static let Dashed = UIColor(red:0.42, green:0.42, blue:0.42, alpha: 1.0)
        public static let Axis = UIColor(red:0.45, green:0.45, blue:0.45, alpha: 1.0)
    }
    
    public struct Pallete {
        
        public struct Clear {
            public static let colors = [UIColor.clear]
        }
        
        public struct Vibrating {
            
            public static let colors = [
                UIColor.Pallete.Vibrating.Purple,
                UIColor.Pallete.Vibrating.Beige,
                UIColor.Pallete.Vibrating.Blue,
                UIColor.Pallete.Vibrating.Yellow,
                UIColor.Pallete.Vibrating.Pink,
                UIColor.Pallete.Vibrating.Green,
                UIColor.Pallete.Vibrating.Navy,
                UIColor.Pallete.Vibrating.Orange
            ]
            
            public static let Purple = UIColor(red:0.33, green:0.18, blue:0.44, alpha:1.0)
            public static let Beige = UIColor(red:1.00, green:0.80, blue:0.18, alpha:1.0)
            public static let Blue = UIColor(red:0.22, green:0.15, blue:0.98, alpha:1.0)
            public static let Yellow = UIColor(red:1.00, green:0.97, blue:0.22, alpha:1.0)
            public static let Pink = UIColor(red:0.98, green:0.10, blue:0.62, alpha:1.0)
            public static let Green = UIColor(red:0.68, green:0.93, blue:0.20, alpha:1.0)
            public static let Navy = UIColor(red:0.08, green:0.36, blue:0.98, alpha:1.0)
            public static let Orange = UIColor(red:0.99, green:0.66, blue:0.16, alpha:1.0)
        }
        
        public struct Hot {
            
            public static let colors = [
                UIColor.Pallete.Hot.Crimson,
                UIColor.Pallete.Hot.Red,
                UIColor.Pallete.Hot.Orange,
                UIColor.Pallete.Hot.Beige,
                UIColor.Pallete.Hot.Yellow
            ]
            
            public static let Crimson = UIColor(red:0.57, green:0.16, blue:0.16, alpha:1.0)
            public static let Red = UIColor(red:0.93, green:0.13, blue:0.18, alpha:1.0)
            public static let Orange = UIColor(red:0.96, green:0.57, blue:0.19, alpha:1.0)
            public static let Beige = UIColor(red:0.93, green:0.72, blue:0.33, alpha:1.0)
            public static let Yellow = UIColor(red:1.00, green:0.85, blue:0.49, alpha:1.0)
        }
        
        public struct AppleLogo {
            
            public static let colors = [
                UIColor.Pallete.AppleLogo.Green,
                UIColor.Pallete.AppleLogo.Orange,
                UIColor.Pallete.AppleLogo.Blue,
                UIColor.Pallete.AppleLogo.Red,
                UIColor.Pallete.AppleLogo.Violet,
                UIColor.Pallete.AppleLogo.Yellow
            ]
            
            public static let Green = UIColor(red:0.17, green:0.56, blue:0.14, alpha: 1.0)
            public static let Yellow = UIColor(red:0.99, green:0.75, blue:0.22, alpha: 1.0)
            public static let Orange = UIColor(red:0.94, green:0.36, blue:0.14, alpha: 1.0)
            public static let Red = UIColor(red:0.98, green:0.14, blue:0.16, alpha: 1.0)
            public static let Violet = UIColor(red:0.73, green:0.13, blue:0.31, alpha: 1.0)
            public static let Blue = UIColor(red:0.13, green:0.34, blue:0.83, alpha: 1.0)
        }
        
        public struct FlatColor {
            
            public static let colors = [
                UIColor.Pallete.FlatColor.Green.Dark,
                UIColor.Pallete.FlatColor.Green.Light,
                UIColor.Pallete.FlatColor.Blue.Dark,
                UIColor.Pallete.FlatColor.Blue.Light,
                UIColor.Pallete.FlatColor.Purple.Dark,
                UIColor.Pallete.FlatColor.Purple.Light,
                UIColor.Pallete.FlatColor.Pink.Dark,
                UIColor.Pallete.FlatColor.Pink.Light,
                UIColor.Pallete.FlatColor.Orange.Dark,
                UIColor.Pallete.FlatColor.Orange.Light,
                UIColor.Pallete.FlatColor.Red.Dark,
                UIColor.Pallete.FlatColor.Red.Light
            ]
            
            public struct Green {
                public static let Dark = UIColor(red: 58/255, green: 255/255, blue: 126/255, alpha: 0.7)
                public static let Light = UIColor(red: 58/255, green: 227/255, blue: 116/255, alpha: 0.7)
            }
            public struct Blue {
                public static let Dark = UIColor(red: 23/255, green: 192/255, blue: 235/255, alpha: 0.7)
                public static let Light = UIColor(red: 24/255, green: 220/255, blue: 255/255, alpha: 0.7)
            }
            public struct Purple {
                public static let Dark = UIColor(red: 113/255, green: 88/255, blue: 226/255, alpha: 0.7)
                public static let Light = UIColor(red: 255/255, green: 95/255, blue: 255/255, alpha: 0.7)
            }
            public struct Pink {
                public static let Dark = UIColor(red: 255/255, green: 184/255, blue: 184/255, alpha: 0.7)
                public static let Light = UIColor(red: 255/255, green: 204/255, blue: 204/255, alpha: 0.7)
            }
            public struct Orange {
                public static let Dark = UIColor(red: 255/255, green: 159/255, blue: 26/255, alpha: 0.7)
                public static let Light = UIColor(red: 255/255, green: 175/255, blue: 64/255, alpha: 0.7)
            }
            public struct Red {
                public static let Dark = UIColor(red: 255/255, green: 56/255, blue: 56/255, alpha: 0.7)
                public static let Light = UIColor(red: 255/255, green: 77/255, blue: 77/255, alpha: 0.7)
            }
        }
    }
}
