//
//  NSColor+Outlaw.swift
//  OutlawAppKit
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

#if os(macOS)
import AppKit
import Outlaw
import OutlawCoreGraphics


public extension NSColor {
    public struct ExtractableKeys {
        public static let red = "red"
        public static let green = "green"
        public static let blue = "blue"
        public static let alpha = "alpha"
    }
}

extension NSColor: Value {
    public static func value(from object: Any) throws -> NSColor {
        if let data = object as? Extractable {
            typealias keys = NSColor.ExtractableKeys
            
            let red: CGFloat = try data.value(for: keys.red)
            let green: CGFloat = try data.value(for: keys.green)
            let blue: CGFloat = try data.value(for: keys.blue)
            let alpha: CGFloat? = data.value(for: keys.alpha)
            
            return NSColor(deviceRed: red, green: green, blue: blue, alpha: alpha ?? 1)
        }
        else if let data = object as? IndexExtractable {
            let red: CGFloat = try data.value(for: 0)
            let green: CGFloat = try data.value(for: 1)
            let blue: CGFloat = try data.value(for: 2)
            let alpha: CGFloat? = data.value(for: 3)
            
            return NSColor(deviceRed: red, green: green, blue: blue, alpha: alpha ?? 1)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension NSColor: Serializable {
    public func serialized() -> [String: CGFloat] {
        typealias keys = NSColor.ExtractableKeys
        
        var result = [String: CGFloat]()
        result[keys.red] = self.redComponent
        result[keys.green] = self.greenComponent
        result[keys.blue] = self.blueComponent
        result[keys.alpha] = self.alphaComponent
        
        return result
    }
}
#endif
