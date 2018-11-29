//
//  String.swift
//  ShudderProject
//
//  Created by Duy Pham on 11/29/18.
//  Copyright © 2018 Duy Khac. All rights reserved.
//

import Foundation

extension String {
    
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}


