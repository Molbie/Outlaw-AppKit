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
    struct ExtractableKeys {
        public static let red = "red"
        public static let green = "green"
        public static let blue = "blue"
        public static let alpha = "alpha"
    }
    struct ExtractableIndexes {
        public static let red: Int = 0
        public static let green: Int = 1
        public static let blue: Int = 2
        public static let alpha: Int = 3
    }
    private typealias keys = NSColor.ExtractableKeys
    private typealias indexes = NSColor.ExtractableIndexes
}

extension NSColor: Value {
    public static func value(from object: Any) throws -> NSColor {
        if let data = object as? Extractable {
            let red: CGFloat = try data.value(for: keys.red)
            let green: CGFloat = try data.value(for: keys.green)
            let blue: CGFloat = try data.value(for: keys.blue)
            let alpha: CGFloat? = data.optional(for: keys.alpha)
            
            return NSColor(deviceRed: red, green: green, blue: blue, alpha: alpha ?? 1)
        }
        else if let data = object as? IndexExtractable {
            let red: CGFloat = try data.value(for: indexes.red)
            let green: CGFloat = try data.value(for: indexes.green)
            let blue: CGFloat = try data.value(for: indexes.blue)
            let alpha: CGFloat? = data.optional(for: indexes.alpha)
            
            return NSColor(deviceRed: red, green: green, blue: blue, alpha: alpha ?? 1)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: Swift.type(of: object))
        }
    }
}

internal extension NSColor {
    func rgbColor() -> NSColor? {
        guard colorSpace == .genericRGB || colorSpace == .deviceRGB else {
            return self.usingColorSpace(.genericRGB)
        }
        
        return self
    }
}

extension NSColor: Serializable {
    public func serialized() -> [String: CGFloat] {
        guard let color = rgbColor() else { return [:] }
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var result = [String: CGFloat]()
        result[keys.red] = red
        result[keys.green] = green
        result[keys.blue] = blue
        result[keys.alpha] = alpha
        
        return result
    }
}

extension NSColor: IndexSerializable {
    public func serializedIndexes() -> [CGFloat] {
        guard let color = rgbColor() else { return [] }
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var result = [CGFloat](repeating: 0, count: 4)
        result[indexes.red] = red
        result[indexes.green] = green
        result[indexes.blue] = blue
        result[indexes.alpha] = alpha
        
        return result
    }
}
#endif
