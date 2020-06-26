//
//  TreePrinter.swift
//  TreeDirectory
//
//  Created by Martin Kuchar on 2020-06-25.
//  Copyright © 2020 Cornerstone. All rights reserved.
//

import Foundation
import AppKit

func printDirectoryTreeHelper(_ urlString: String, _ padding: String = " ", _ directoryCounter: inout Int, _ fileCounter: inout Int) {
    guard let fileUrl = URL(string: urlString), FileManager.default.fileExists(atPath: fileUrl.path) else {
        return
    }
    let localFileManager = FileManager.default
    var isDirectory : ObjCBool = false
    if FileManager.default.fileExists(atPath: fileUrl.path, isDirectory:&isDirectory) {
        if isDirectory.boolValue {
            directoryCounter += 1
        let contents = try! localFileManager.contentsOfDirectory(at: fileUrl, includingPropertiesForKeys: nil,
                                     options: [.skipsHiddenFiles])
            for i in 0...contents.count-1 {
                let name = FileManager.default.displayName(atPath: contents[i].path)
                if i == contents.count - 1 {
                    print(padding + "└─" + name)
                    printDirectoryTreeHelper(urlString + "/" + name, padding + "   ", &directoryCounter, &fileCounter)
                } else {
                    print(padding + "├─" + name)
                    printDirectoryTreeHelper(urlString + "/" + name, padding + "│  ",  &directoryCounter, &fileCounter)
                }
            }
        } else {
            fileCounter += 1
        }
    }
}

func printDirectoryTree(_ urlString: String) {
    var directoryCounter = -1
    var fileCounter = 0
    printDirectoryTreeHelper(urlString, "", &directoryCounter, &fileCounter)
    print("\n\(directoryCounter) directories, \(fileCounter) files\n")
}
