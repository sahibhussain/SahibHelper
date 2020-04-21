//
//  SahibSwitch.swift
//  SahibHelper
//
//  Created by Sahib Hussain on 21/04/20.
//  Copyright © 2020 Sahib Hussain. All rights reserved.
//

import UIKit

@IBDesignable
public class CustomSwitch: UIControl {
    
    @IBInspectable public var OffColor: UIColor! = .white
    @IBInspectable public var onColor: UIColor! = .green
    @IBInspectable public var isOn: Bool = true
    
    private var ball: UIView = UIView()
    private var ballwidth: CGFloat!
    
    private var height: CGFloat = 0.0
    private var width: CGFloat = 0.0
    private var x: CGFloat = 0.0
    private var y: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSwitch()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSwitch()
    }
    
    private func setupSwitch() {
        
        height = self.frame.height
        width = self.frame.width
        x = self.frame.origin.x
        y = self.frame.origin.y
        
        if isOn {
            backgroundColor = onColor
        }else {
            backgroundColor = OffColor
        }
        
        self.layer.cornerRadius = height/2
        setupBall()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
        
    }
    
    private func setupBall() {
        ballwidth = height-2
        ball.frame = .init(x: 1, y: 1, width: ballwidth, height: ballwidth)
        ball.layer.cornerRadius = ballwidth/2
        ball.backgroundColor = .white
        
        if isOn {
            self.ball.frame.origin.x = self.width - self.ballwidth - 1
        }else {
            self.ball.frame.origin.x = 1
        }
        
        self.addSubview(ball)
    }
    
    public func set(_ on: Bool, animated: Bool) {
        isOn = on
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                if self.isOn {
                    self.ball.frame.origin.x = self.width - self.ballwidth - 1
                    self.backgroundColor = self.onColor
                }else {
                    self.ball.frame.origin.x = 1
                    self.backgroundColor = self.OffColor
                }
            }
        }else{
            if isOn {
                ball.frame.origin.x = width - ballwidth - 1
                backgroundColor = onColor
            }else {
                ball.frame.origin.x = 1
                backgroundColor = OffColor
            }
        }
        
        self.sendActions(for: .valueChanged)
        
    }
    
    public func toggle(_ animated: Bool) {
        
        isOn = !isOn
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                if self.isOn {
                    self.ball.frame.origin.x = self.width - self.ballwidth - 1
                    self.backgroundColor = self.onColor
                }else {
                    self.ball.frame.origin.x = 1
                    self.backgroundColor = self.OffColor
                }
            }
        }else{
            if isOn {
                ball.frame.origin.x = width - ballwidth - 1
                backgroundColor = onColor
            }else {
                ball.frame.origin.x = 1
                backgroundColor = OffColor
            }
        }
        
        self.sendActions(for: .valueChanged)
    }
    
    @objc private func tapped(_ gesture: UIGestureRecognizer) {
        toggle(true)
    }
    
    
}

