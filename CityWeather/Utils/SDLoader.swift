//
//  SDLoader.swift
//  CityWeather
//
//  Created by Amjad Khan on 07/01/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import UIKit

class SmartDubaiLoader {
    
    // MARK: - Properties
    
    static let shared = SmartDubaiLoader()
    
    // MARK: -
    
    var container: UIView
    var loadingView: UIView
    var activityIndicator: UIActivityIndicatorView
    
    // Initialization
    
    private init() {
        container = UIView()
        loadingView = UIView()
        activityIndicator = UIActivityIndicatorView()
    }

    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
    
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
    
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)

        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        container.removeFromSuperview()
    }

    private func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
}
