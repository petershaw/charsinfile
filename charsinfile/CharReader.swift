//
//  CharReader.swift
//  charsinfile
//
//  Created by Kris Simon on 06/11/2016.
//  Copyright © 2016 aus der Technik. All rights reserved.
//

import Foundation
class CharReader {
    
    let encoding : String.Encoding
    let chunkSize : Int
    var fileHandle : FileHandle!
    let buffer : NSMutableData!
    var atEof : Bool = false
    var characterPointer: UnsafeMutablePointer<Character>
    var startPointer: UnsafeMutablePointer<Character>

    var stored_cnt: Int = 0;
    var stored_idx: Int = 0;
    
    init?(path: String, encoding: String.Encoding = String.Encoding.utf8, chunkSize : Int = 1024) {
        self.chunkSize = chunkSize
        self.encoding = encoding
        characterPointer = UnsafeMutablePointer<Character>.allocate(capacity: chunkSize)
        startPointer = characterPointer
        if let fileHandle = FileHandle(forReadingAtPath: path),
            let buffer = NSMutableData(capacity: chunkSize){
            self.fileHandle = fileHandle
            self.buffer = buffer
        } else {
            self.fileHandle = nil
            self.buffer = nil
            return nil
        }
    }
    
    deinit {
        self.close()
    }
    
    func nextChar() -> Character? {
        
        if atEof {
            return nil
        }
        
        if stored_cnt > (stored_idx + 1) {
            stored_idx += 1
            let char = characterPointer.pointee
            characterPointer += 1 //characterPointer.successor()
            return char
        }
        
        let tmpData = fileHandle.readData(ofLength: (chunkSize))
        if tmpData.count == 0 {
            atEof = true
            return nil
        }
        
        
        if let s = String(data: tmpData, encoding: encoding) {
            stored_idx = 0
            let characters = s.characters
            stored_cnt = characters.count
            
            characterPointer = startPointer
            characterPointer.initialize(from: characters)
            
            let char = characterPointer.pointee
            characterPointer = characterPointer.successor()
            return char
        }
        return nil;
    }
    
    
    /// Close the underlying file. No reading must be done after calling this method.
    func close() -> Void {
        fileHandle?.closeFile()
        fileHandle = nil
    }
    
}
