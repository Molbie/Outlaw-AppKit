//
//  NSColor+Outlaw.swift
//  OutlawAppKit
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

#if os(OSX)
import AppKit
import Outlaw
import OutlawCoreGraphics


extension NSColor: Value {
    public static func value(from object: Any) throws -> NSColor {
        if let data = object as? Extractable {
            let red: CGFloat = try data.value(for: "red")
            let green: CGFloat = try data.value(for: "green")
            let blue: CGFloat = try data.value(for: "blue")
            let alpha: CGFloat? = data.value(for: "alpha")
            
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
        var result = [String: CGFloat]()
        result["red"] = self.redComponent
        result["green"] = self.greenComponent
        result["blue"] = self.blueComponent
        result["alpha"] = self.alphaComponent
        
        return result
    }
}
#endif
