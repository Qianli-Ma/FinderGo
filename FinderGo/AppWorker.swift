//
//  AppWorker.swift
//  FinderGo
//
//  Created by Khoa Pham on 15/03/2017.
//  Copyright © 2017 Fantageek. All rights reserved.
//

import Cocoa

struct AppWorker {

  func finderCurrentPath() -> String? {
      guard let scriptUrl = Bundle.main.url(forResource: "finderCurrentPath", withExtension: "scpt"),
            let script = try? String(contentsOf: scriptUrl) else {
          return nil
          }
//      let scriptURL = Bundle.main.url(forResource: "finderCurrentPath", withExtension: "scpt")
//      let script = try? String(contentsOf: scriptURL) else {
//                  return nil
      var error: NSDictionary?
      if let scriptObject = NSAppleScript(source: script)
      {
          let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error)
//          print(output.stringValue as Any)
//          let alert = NSAlert()
          
          if (error != nil)
          {
//              var _: NSError?
//              guard let errorJson = try? JSONSerialization.data(withJSONObject:error as Any, options: JSONSerialization.WritingOptions.prettyPrinted) else { return default nil }
//              let json = NSString(data:errorJson, encoding:String.Encoding.utf8.rawValue)
//              let errorString :String = json! as String
//              alert.messageText = errorString
//              alert.messageText = "ERRRRRR"
//              alert.runModal()
              return nil
          }
//          alert.messageText = output.stringValue!
//          alert.runModal()
          return output.stringValue
      }
      return nil
//    let script = NSAppleScript(source: string)
//    return script?.executeAndReturnError(nil).stringValue
  }

  func findTerminal() -> String {
    return UserDefaults.standard.string(forKey: "terminal") ?? "iTerm"
  }

  func run() {
    guard let path = finderCurrentPath() else {
      return
    }

    let process = Process()
    let terminal = findTerminal()
    process.launchPath = "/usr/bin/open"
    process.arguments = ["-a", terminal, "\(path)"]

    process.launch()
    process.waitUntilExit()
  }
}
