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
                
                for content in contents {
                        let name = FileManager.default.displayName(atPath: content.path)
//                      print(FileManager.default.displayName(atPath: content.path))
                        print(padding + name)
                        printDirectioryTree(urlString + "/" + name, padding + "  ")
                    }
            }
        } else {
            print(urlString)
        }
//    print("Error while enumerating URL path: \(fileUrl.path)")

}
