//
//  String+.swift
//  UmbrellaFriend-iOS
//
//  Created by 고아라 on 2/19/24.
//

import UIKit

extension String {
    
    func isValidName() -> Bool {
        let pattern = "[가-힣]"
        guard self.range(of: pattern, options: .regularExpression) != nil else { return false }
        return true
    }
    
    func isValidStudentID() -> Bool {
        let studentIDRegex = #"^\d{7}$"#
        let studentIDTest = NSPredicate(format: "SELF MATCHES %@", studentIDRegex)
        return studentIDTest.evaluate(with: self)
    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneRegex = #"^010[0-9]{8}$"#
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = #"^[a-z0-9]+$"#
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegex = #"^(?=.*[A-Za-z])[A-Za-z\d]{8,}$"#
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    }
}
