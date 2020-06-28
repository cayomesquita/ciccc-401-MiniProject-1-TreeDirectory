//
//  main.swift
//  TreeDirectory
//
//  Created by Cornerstone on 2020-06-25.
//  Copyright © 2020 Cornerstone. All rights reserved.
//

import Foundation
import AppKit

printDirectoryTree(FileManager.default.currentDirectoryPath)

func printDirectoryTreeHelper(_ urlString: String, _ padding: String = " ", _ directoryCounter: inout Int, _ fileCounter: inout Int) {
    let localFileManager = FileManager.default
    var isDirectory : ObjCBool = false
    guard let fileUrl = URL(string: urlString), localFileManager.fileExists(atPath: fileUrl.path, isDirectory: &isDirectory) else {
        return
    }
    
    if isDirectory.boolValue {
        directoryCounter += 1
        let contents = try! localFileManager.contentsOfDirectory(at: fileUrl, includingPropertiesForKeys: nil,
                                     options: [.skipsHiddenFiles])
            for i in 0...contents.count-1 {
                let name = localFileManager.displayName(atPath: contents[i].path)
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

func printDirectoryTree(_ urlString: String) {
    var directoryCounter = -1
    var fileCounter = 0
    printDirectoryTreeHelper(urlString, "", &directoryCounter, &fileCounter)
    print("\n\(directoryCounter) directories, \(fileCounter) files\n")
}

