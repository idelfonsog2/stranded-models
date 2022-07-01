//
//  File.swift
//  
//
//  Created by Idelfonso Gutierrez on 7/1/22.
//

import Foundation

#if swift(>=5.6)
extension Date: @unchecked Sendable {}
extension UUID: @unchecked Sendable {}
extension Data: @unchecked Sendable {}
#endif

extension String {
   public var internetDate: Date {
      get throws {
         let f = DateFormatter()
         f.dateFormat = "yyyy-MM-dd HH:mmZ"
         if let date = f.date(from: self) {
            return date
         }
         return Date()
      }
   }
}
