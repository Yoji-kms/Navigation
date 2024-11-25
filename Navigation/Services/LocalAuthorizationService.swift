//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Yoji on 25.11.2024.
//

import UIKit
import LocalAuthentication

final class LocalAuthorizationService {
    private let context = LAContext()
    private let policy: LAPolicy = .deviceOwnerAuthentication
    var authorizationType: LABiometryType {
        get {
            context.biometryType
        }
    }
    
    init() {
        context.localizedCancelTitle = "Enter Username/Password".localized
        var error: NSError?
        
        guard self.context.canEvaluatePolicy(self.policy, error: &error) else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
            return
        }
    }
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool, Error?) -> Void) {
        self.context.evaluatePolicy(self.policy, localizedReason: "Log in to your account".localized) { result, error in
            authorizationFinished(result, error)
        }
    }
}

extension LABiometryType {
    var icon: UIImage {
        switch self {
        case .touchID:
            UIImage(systemName: "touchid") ?? UIImage()
        case .faceID:
            UIImage(systemName: "faceid") ?? UIImage()
        case .opticID:
            UIImage(systemName: "eye.square") ?? UIImage()
        default:
            UIImage()
        }
    }
}
