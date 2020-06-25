//
//  TreePrinter.swift
//  TreeDirectory
//
//  Created by Martin Kuchar on 2020-06-25.
//  Copyright © 2020 Cornerstone. All rights reserved.
//

import Foundation

func printDirectioryTree(_ URL: URL) {
    if !FileManager.default.fileExists(atPath: URL.path) {
        return
    }
    
    let localFileManager = FileManager()
    let enumeratedDir = localFileManager.enumerator(atPath: URL.path)
    
    let contents = try! FileManager.default.contentsOfDirectory(at: URL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
    for content in contents {
        print(content.description)
    }
}
