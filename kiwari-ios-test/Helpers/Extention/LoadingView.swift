//
//  LoadingView.swift
//  kiwari-ios-test
//
//  Created by keenOI on 20/04/20.
//  Copyright © 2020 keen. All rights reserved.
//

import UIKit

final class CustomActivityIndicator {
    
    static let shared = CustomActivityIndicator()
    
    private init() {}
    
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var label: UILabel = UILabel()
    
    func show(uiView: UIView,
              backgroundColor: UIColor = .darkGray,
              size: Double = 80,
              animated: Bool = false,
              duration: Double = 1.0) {
        
        uiView.isUserInteractionEnabled = false
        loadingView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        loadingView.center = uiView.center
        loadingView.backgroundColor = backgroundColor
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        if animated {
            loadingView.alpha = 0.0
        } else {
            loadingView.alpha = 1.0
        }
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: size / 2, height: size / 2)
        activityIndicator.style =
            UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        activityIndicator.hidesWhenStopped = true
        
        DispatchQueue.main.async {
            self.loadingView.addSubview(self.activityIndicator)
            uiView.addSubview(self.loadingView)
            self.activityIndicator.startAnimating()
            if animated {
                self.loadingView.fadeIn(duration: duration)
            }
        }
    }
    
    func show(uiView: UIView,
              labelText: String,
              backgroundColor: UIColor = .darkGray,
              textColor: UIColor = .white,
              animated: Bool = false,
              duration: Double = 1.0) {
        
        uiView.isUserInteractionEnabled = false
        let width: CGFloat = labelText.width(withConstrainedHeight: 21.0, font: UIFont.systemFont(ofSize: 17))
        
        
        if width > 200 {
            let height: CGFloat = labelText.height(withConstrainedWidth: 200, font: UIFont.systemFont(ofSize: 17))
            if height > 200 {
                
                show(uiView: uiView, backgroundColor: backgroundColor)
                return
            }
            loadingView.frame = CGRect(x: 0, y: 0, width: 220, height: 110 + height)
            loadingView.center = uiView.center
            label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: height))
            label.center = CGPoint(x: loadingView.frame.size.width / 2, y: (height / 2) + 80)
            label.numberOfLines = 0
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            activityIndicator.center = CGPoint(x: 110, y: 50)
            
        } else {
            loadingView.frame = CGRect(x: 0, y: 0, width: width + 20, height: 110)
            loadingView.center = uiView.center
            label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 21))
            label.center = CGPoint(x: loadingView.frame.size.width / 2, y: 90)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        }
        
        loadingView.backgroundColor = backgroundColor
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = labelText
        
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.hidesWhenStopped = true
        
        if animated {
            
            loadingView.alpha = 0.0
        } else {
            loadingView.alpha = 1.0
        }
        
        DispatchQueue.main.async {
            self.loadingView.addSubview(self.label)
            self.loadingView.addSubview(self.activityIndicator)
            uiView.addSubview(self.loadingView)
            self.activityIndicator.startAnimating()
            if animated {
                self.loadingView.fadeIn(duration: duration)
            }
        }
    }
    
    func hide(uiView: UIView, animated: Bool = false, duration: Double = 1.0) {
        
        if loadingView.isDescendant(of: uiView) {
            DispatchQueue.main.async {
                if animated {
                    UIView.animate(withDuration: duration, animations: {
                        self.loadingView.alpha = 0.0
                    }, completion: { finished in
                        if finished {
                            uiView.isUserInteractionEnabled = true
                            self.activityIndicator.stopAnimating()
                            self.loadingView.removeFromSuperview()
                            self.label.text = ""
                        }
                    })
                } else {
                    uiView.isUserInteractionEnabled = true
                    self.activityIndicator.stopAnimating()
                    self.loadingView.removeFromSuperview()
                    self.label.text = ""
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                if self.loadingView.isDescendant(of: uiView) {
                    if animated {
                        UIView.animate(withDuration: duration, animations: {
                            self.loadingView.alpha = 0.0
                        }, completion: { finished in
                            if finished {
                                uiView.isUserInteractionEnabled = true
                                self.activityIndicator.stopAnimating()
                                self.loadingView.removeFromSuperview()
                                self.label.text = ""
                            }
                        })
                    } else {
                        uiView.isUserInteractionEnabled = true
                        self.activityIndicator.stopAnimating()
                        self.loadingView.removeFromSuperview()
                        self.label.text = ""
                    }
                }
            }
        }
    }
    
    func hide(uiView: UIView, delay: Double, animated: Bool = false, duration: Double = 1.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if self.loadingView.isDescendant(of: uiView) {
                if animated {
                    UIView.animate(withDuration: duration, animations: {
                        self.loadingView.alpha = 0.0
                    }, completion: { finished in
                        if finished {
                            uiView.isUserInteractionEnabled = true
                            self.activityIndicator.stopAnimating()
                            self.loadingView.removeFromSuperview()
                            self.label.text = ""
                        }
                    })
                } else {
                    uiView.isUserInteractionEnabled = true
                    self.activityIndicator.stopAnimating()
                    self.loadingView.removeFromSuperview()
                    self.label.text = ""
                }
            }
        }
    }
}

extension UIView {
    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
}

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
