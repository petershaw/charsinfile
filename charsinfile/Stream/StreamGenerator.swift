//
//  StreamGenerator.swift
//  charsinfile
//
//  Created by Kris Simon on 06/11/2016.
//  Copyright © 2016 aus der Technik. All rights reserved.
//

import Foundation

final class StreamGenerator {
    static let bufferSize = 1024
    let stream: InputStream
    var buffer = [UInt8](repeating: 0, count: StreamGenerator.bufferSize)
    var buffGen = IndexingIterator<ArraySlice<UInt8>>(_elements: [])
    
    init(stream: InputStream) {
        self.stream = stream
        stream.open()
    }
}

extension StreamGenerator: IteratorProtocol {
    func next() -> UInt8? {
        // Check the stream status
        switch stream.streamStatus {
        case .notOpen:
            assertionFailure("Cannot read unopened stream")
            return nil
        case .writing:
            preconditionFailure("Impossible status")
        case .atEnd, .closed, .error:
            return nil // FIXME: May want a closure to post errors
        case .opening, .open, .reading:
            break
        }
        
        // First see if we can feed from our buffer
        if let result = buffGen.next() {
            return result
        }
        
        // Our buffer is empty. Block until there is at least one byte available
        let count = stream.read(&buffer, maxLength: buffer.count)
        
        if count <= 0 { // FIXME: Probably want a closure or something to handle error cases
            stream.close()
            return nil
        }
        
        buffGen = buffer.prefix(count).makeIterator()
        return buffGen.next()
    }
}

