//
//  NSValueTransformerName+transformedValue.swift
//  GenGen
//
//  Created by Ceren Majoor on 08/11/2024.
//

import Foundation

@objc(UUIDArrayTransformer)
class UUIDArrayTransformer: ValueTransformer {

    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    override class func allowsReverseTransformation() -> Bool {
        return true
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let uuids = value as? [UUID] else { return nil }
        do {
            let data = try JSONEncoder().encode(uuids)
            return data
        } catch {
            print("Error encoding UUID array: \(error)")
            return nil
        }
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        do {
            let uuids = try JSONDecoder().decode([UUID].self, from: data)
            return uuids
        } catch {
            print("Error decoding UUID array: \(error)")
            return nil
        }
    }
}
