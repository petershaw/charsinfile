//
//  main.swift
//  charsinfile
//
//  Created by Kris Simon on 06/11/2016.
//  Copyright © 2016 aus der Technik. All rights reserved.
//

import Foundation

if CommandLine.arguments.count < 2 {
    print("Too less arguments.")
    exit(0)
}
let file = CommandLine.arguments[1]

if let aCharReader = CharReader(path: file) {
    defer {
        aCharReader.close()
    }
    while let char = aCharReader.nextChar() {
        continue
    }
}

