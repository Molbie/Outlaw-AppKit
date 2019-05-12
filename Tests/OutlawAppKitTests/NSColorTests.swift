//
//  NSColorTests.swift
//  OutlawAppKit
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

#if os(macOS)
import XCTest
import Outlaw
import OutlawCoreGraphics
@testable import OutlawAppKit


class NSColorTests: XCTestCase {
    fileprivate typealias keys = NSColor.ExtractableKeys
    fileprivate typealias indexes = NSColor.ExtractableIndexes
    
    func testExtractableValue() {
        let rawData: [String: CGFloat] = [keys.red: 0.1,
                                          keys.green: 0.2,
                                          keys.blue: 0.3,
                                          keys.alpha: 0.4]
        let data: [String: [String: CGFloat]] = ["color": rawData]
        let color: NSColor = try! data.value(for: "color")
        
        XCTAssertEqual(color.redComponent, rawData[keys.red])
        XCTAssertEqual(color.greenComponent, rawData[keys.green])
        XCTAssertEqual(color.blueComponent, rawData[keys.blue])
        XCTAssertEqual(color.alphaComponent, rawData[keys.alpha])
    }
    
    func testIndexExtractableValue() {
        var rawData = [CGFloat](repeating: 0, count: 4)
        rawData[indexes.red] = 0.1
        rawData[indexes.green] = 0.2
        rawData[indexes.blue] = 0.3
        rawData[indexes.alpha] = 0.4
        
        let data: [[CGFloat]] = [rawData]
        let color: NSColor = try! data.value(for: 0)
        
        XCTAssertEqual(color.redComponent, rawData[indexes.red])
        XCTAssertEqual(color.greenComponent, rawData[indexes.green])
        XCTAssertEqual(color.blueComponent, rawData[indexes.blue])
        XCTAssertEqual(color.alphaComponent, rawData[indexes.alpha])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: CGAffineTransform = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        let color = NSColor(deviceRed: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
        let data = color.serialized()
        
        XCTAssertEqual(data[keys.red], color.redComponent)
        XCTAssertEqual(data[keys.green], color.greenComponent)
        XCTAssertEqual(data[keys.blue], color.blueComponent)
        XCTAssertEqual(data[keys.alpha], color.alphaComponent)
        
        let white = NSColor.white
        let data2 = white.serialized()
        let rgbwhite = white.rgbColor()
        
        XCTAssertEqual(data2[keys.red], rgbwhite?.redComponent)
        XCTAssertEqual(data2[keys.green], rgbwhite?.greenComponent)
        XCTAssertEqual(data2[keys.blue], rgbwhite?.blueComponent)
        XCTAssertEqual(data2[keys.alpha], rgbwhite?.alphaComponent)
    }
    
    func testIndexSerializable() {
        let color = NSColor(deviceRed: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
        let data = color.serializedIndexes()
        
        XCTAssertEqual(data[indexes.red], color.redComponent)
        XCTAssertEqual(data[indexes.green], color.greenComponent)
        XCTAssertEqual(data[indexes.blue], color.blueComponent)
        XCTAssertEqual(data[indexes.alpha], color.alphaComponent)
        
        let white = NSColor.white
        let data2 = white.serializedIndexes()
        let rgbwhite = white.rgbColor()
        
        XCTAssertEqual(data2[indexes.red], rgbwhite?.redComponent)
        XCTAssertEqual(data2[indexes.green], rgbwhite?.greenComponent)
        XCTAssertEqual(data2[indexes.blue], rgbwhite?.blueComponent)
        XCTAssertEqual(data2[indexes.alpha], rgbwhite?.alphaComponent)
    }
}
#endif
