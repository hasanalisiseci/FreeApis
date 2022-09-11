//
//  String+Extension.swift
//  FreeApis
//
//  Created by Hasan Ali Şişeci on 11.09.2022.
//

import Foundation

extension StringProtocol {
    var asciiValues: [UInt8] { compactMap(\.asciiValue) }
    
    func toAsciiCode() -> String{
        let asciArray = self.asciiValues
        var str = ""
        for value in asciArray {
            str += "\(value)"
        }
        return str
    }
}

