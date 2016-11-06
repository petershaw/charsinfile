//
//  UnicodeScalarGenerator.swift
//  charsinfile
//
//  Created by Kris Simon on 06/11/2016.
//  Copyright © 2016 aus der Technik. All rights reserved.
//

import Foundation

final class UnicodeScalarGenerator<ByteGenerator: IteratorProtocol> where ByteGenerator.Element == UInt8 {
    var byteGenerator: ByteGenerator
    var utf8 = UTF8()
    init(byteGenerator: ByteGenerator) {
        self.byteGenerator = byteGenerator
    }
}

extension UnicodeScalarGenerator: IteratorProtocol {
    func next() -> UnicodeScalar? {
        switch utf8.decode(&byteGenerator) {
        case .scalarValue(let scalar): return scalar
        case .emptyInput: return nil
        case .error: return nil // FIXME: Probably want a closure or something to handle error cases
        }
    }
}
