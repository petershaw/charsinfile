//
//  main.swift
//  charsinfile
//
//  Created by Kris Simon on 06/11/2016.
//  Copyright © 2016 aus der Technik. All rights reserved.
//

import Foundation

if CommandLine.arguments.count < 3 {
    print("Too less arguments.")
    exit(0)
}
let file = CommandLine.arguments[1]
let variant = CommandLine.arguments[2]

switch(variant){
    case "a":
        if let aCharReader = CharReader(path: file) {
            defer {
                aCharReader.close()
            }
            var cnt = 0;
            while let char = aCharReader.nextChar() {
                print(char, terminator: "")
                continue
            }
        }
    case "b":
        let inputStream = InputStream(fileAtPath: file)!
        inputStream.open()
        
        let streamGen = StreamGenerator(stream: inputStream)
        let unicodeGen = UnicodeScalarGenerator(byteGenerator: streamGen)
        var string = ""
        for c in IteratorSequence(unicodeGen) {
            print(c, terminator: "")
        }
    
    default:
        print("no type secected, chose a or b")
}


