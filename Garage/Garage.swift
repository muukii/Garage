// Garage.swift
//
// Copyright (c) 2014 eureka
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit

// iPhone4 iPhone4S
let kScreenHeight_Xsmall: CGFloat = 480.0
// iPhone5 iPhone5S
let kScreenHeight_Small: CGFloat = 568.0
// iPhone6
let kScreenHeight_Medium: CGFloat = 667.0
// iPhone6+
let kScreenHeight_Large: CGFloat = 736.0

// iPhone4 iPhone4S iPhone5 iPhone5S
let kScreenWidth_Small: CGFloat = 320.0
// iPhone6
let kScreenWidth_Midium: CGFloat = 375.0
// iPhone6+
let kScreenWidth_Large: CGFloat = 414.0

public class Garage: NSObject{

}

/**
*  Screen Size
*/
public extension Garage {

    /**
    ScreenScale
    
    :returns: CGFloat
    */
    class func ScreenScale() -> CGFloat {
        return UIScreen.mainScreen().scale
    }
    /**
    ScreenHeight
    
    :returns: CGFloat
    */
    class func ScreenHeight() -> CGFloat {
        return UIScreen.mainScreen().bounds.height
    }
    /**
    ScreenWidth

    :returns: CGFloat
    */
    class func ScreenWidth() -> CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    
    /**
    One Pixel
    
    :returns:
    */
    class func OnePixelLength() -> CGFloat {
        return 1.0 / self.ScreenScale()
    }
    
    /**
    NumberOfPixels width
    
    :returns: Number of pixels (width)
    */
    class func ScreenWidthPixel() -> Int {
        return Int(self.ScreenWidth() * self.ScreenScale())
    }
    
    /**
    NumberOfPixels height
    
    :returns: Number of pixels (height)
    */
    class func ScreenHeightPixel() -> Int {
        return Int(self.ScreenHeight() * self.ScreenScale())
    }
    
    /**
    iPhone4 iPhone4S
    
    :returns: Bool
    */
    class func ScreenHeightXsmall() -> Bool {
        if ScreenHeight() <= kScreenHeight_Xsmall && ScreenHeight() < kScreenHeight_Small {
            return true
        }else {
            return false
        }
    }

    /**
    iPhone4 iPhone4S iPhone5 iPhone5S

    :returns: Bool
    */
    class func ScreenWidthSmall() -> Bool{
        if ScreenWidth() <= kScreenWidth_Small && ScreenWidth() < kScreenWidth_Midium {
            return true
        } else {
            return false
        }
    }

    /**
    iPhone6

    :returns: Bool
    */
    class func ScreenWidthMidium() -> Bool{
        if ScreenWidth() <= kScreenWidth_Midium && ScreenWidth() > kScreenWidth_Small {
            return true
        } else {
            return false
        }
    }

    /**
    iPhone6+

    :returns: Bool
    */
    class func ScreenWidthLarge() -> Bool{
        if ScreenWidth() <= kScreenWidth_Large && ScreenWidth() > kScreenWidth_Midium {
            return true
        } else {
            return false
        }
    }
}

/**
*  Calculate
*/
public extension Garage {
    /**
    Get FittingSize For CollectionView
    
    :param: maxWidth           CollectionView Width
    :param: numberOfItemsInRow Items count of Row
    :param: margin             Margin between items
    :param: index              IndexPath.item by collectionView
    
    :returns: Suitable width
    */
    class func CalculateFittingGridSize(maxWidth maxWidth: CGFloat, numberOfItemsInRow: Int, margin: CGFloat, index: Int) -> CGSize {
        let totalMargin: CGFloat = margin * CGFloat(numberOfItemsInRow - 1)
        let actualWidth: CGFloat = maxWidth - totalMargin
        let width: CGFloat = CGFloat(floorf(Float(actualWidth) / Float(numberOfItemsInRow)))
        let extraWidth: CGFloat = actualWidth - (width * CGFloat(numberOfItemsInRow))
        
        if index % numberOfItemsInRow == 0 || index % numberOfItemsInRow == (numberOfItemsInRow - 1) {
            return CGSizeMake(width + extraWidth/2.0,width)
        } else {
            return CGSizeMake(width,width)
        }
    }
}

/**
*  Date
*/
public extension Garage {

    
}

/**
*  System
*/
public extension Garage {
    func osVersionString() -> String {
        return UIDevice.currentDevice().systemVersion
    }
}

/**
*  UIColor
*/
extension UIColor {
    class func hexStr (var hexStr : NSString, var alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}

extension UITableView {
    enum UITableViewCellPosition {
        case None
        case Top
        case Middle
        case Bottom
    }
    
    /**
    Get Cell Position
    
    :param: indexPath
    :param: overSection
    
    :returns:
    */
    func cellPosition(indexPath indexPath: NSIndexPath?, overSection: Bool) -> UITableViewCellPosition {
        if let indexPath = indexPath {
            let numberOfSection = self.numberOfSections
            let numberOfRowInLastSection = self.numberOfRowsInSection(numberOfSection - 1)
            
            if overSection {
                if indexPath.section == (numberOfSection - 1) && indexPath.row == (numberOfRowInLastSection - 1) {
                    return .Bottom
                } else if indexPath.section == 0 && indexPath.row == 0 {
                    return .Top
                } else {
                    return .Middle
                }
            } else {
                if indexPath.row == self.numberOfRowsInSection(indexPath.section) - 1 {
                    return .Bottom
                } else if indexPath.row == 0 {
                    return .Top
                } else {
                    return .Middle
                }
            }
        } else {
            return .None
        }
    }
    
    /**
    Cell Position is Bottom
    
    :param: indexPath
    :param: overSection
    
    :returns:
    */
    func cellPositionIsBottom(indexPath indexPath: NSIndexPath?, overSection: Bool) -> Bool{
        if self.cellPosition(indexPath: indexPath, overSection: overSection) == .Bottom {
            return true
        } else {
            return false
        }
    }
    
    /**
    Cell Position is Middle
    
    :param: indexPath
    :param: overSection
    
    :returns:
    */
    func cellPositionIsMiddle(indexPath indexPath: NSIndexPath?, overSection: Bool) -> Bool {
        if self.cellPosition(indexPath: indexPath, overSection: overSection) == .Middle {
            return true
        } else {
            return false
        }
    }
    
    /**
    Cell Position is Top
    
    :param: indexPath
    :param: overSection
    
    :returns:
    */
    func cellPositionIsTop(indexPath indexPath: NSIndexPath?, overSection: Bool) -> Bool {
        if self.cellPosition(indexPath: indexPath, overSection: overSection) == .Top {
            return true
        } else {
            return false
        }
    }
}
