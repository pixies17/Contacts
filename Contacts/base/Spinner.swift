//
//  Spinner.swift
//  Contacts
//
//  Created by 123 on 18.11.2019.
//

import UIKit
import Foundation

class Spinner {
    
    static let shared = Spinner()
    
    private var spinnerView: UIView = {
        let container = UIView()
        container.frame = .init(x: 0, y: 0, width: 80, height: 80)
        container.backgroundColor = .init(white: 0, alpha: 0.7)
        container.layer.cornerRadius = 10
        container.clipsToBounds = true
        
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView()
        indicator.color = .white
        indicator.frame = .init(x: 0, y: 0, width: 40, height: 40)
        indicator.style = .large
        indicator.center = container.center
        
        container.addSubview(indicator)
        indicator.startAnimating()
        
        return container
    }()
    
    func show(in view: UIView) {
        spinnerView.center = view.center
        view.addSubview(spinnerView)
    }
    
    func hide() {
        spinnerView.removeFromSuperview()
    }
    
}
