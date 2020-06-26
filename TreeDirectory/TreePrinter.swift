//
//  TreePrinter.swift
//  TreeDirectory
//
//  Created by Martin Kuchar on 2020-06-25.
//  Copyright © 2020 Cornerstone. All rights reserved.
//

import Foundation


func printDirectioryTree(_ urlString: String, _ padding: String = " ") {
    guard let fileUrl = URL(string: urlString), FileManager.default.fileExists(atPath: fileUrl.path) else {
        return
    }
    let localFileManager = FileManager.default
        /// Enumerating the directory when we want to use recursion
        //        guard let enumeratedDir = localFileManager.enumerator(atPath: URL.path)  else {
        //            return
        //        }
        //     for content in enumeratedDir {
        //        if let file = content as? String, !file.hasPrefix(".git") {
        //            let attributes = try! FileManager.default.attributesOfItem(atPath: file)
        //            print(file)
        //        }
        //    }

        var isDirectory : ObjCBool = false
        if FileManager.default.fileExists(atPath: fileUrl.path, isDirectory:&isDirectory) {
            if isDirectory.boolValue {
            // Content is a directory
            let contents = try! localFileManager.contentsOfDirectory(at: fileUrl, includingPropertiesForKeys: nil,
                                                                           options: [.skipsHiddenFiles])
                for i in 0...contents.count-1 {
                    let name = FileManager.default.displayName(atPath: contents[i].path)
                    if i == contents.count - 1 {
                        print(padding + "└─" + name)
                        printDirectioryTree(urlString + "/" + name, padding + "  ")
                    } else {
                        print(padding + "├─" + name)
                        printDirectioryTree(urlString + "/" + name, padding + "│ ")
                    }
//                      print(FileManager.default.displayName(atPath: content.path))
                }
            }
        }
//    print("Error while enumerating URL path: \(fileUrl.path)")

}
