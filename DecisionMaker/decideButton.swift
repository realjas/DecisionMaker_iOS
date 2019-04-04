//
//  decideButton.swift
//  DecisionMaker
//
//  Created by JAS on 4/4/19.
//  Copyright © 2019 decisionmakerproject. All rights reserved.
//

import UIKit

class decideButton: UIButton {
    
    var isOn = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        layer.borderWidth = 2.0
        layer.cornerRadius = frame.size.height/2
        addTarget(self, action: #selector(decideButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        //activateButton()
    }
    
    func activateButton(title: String) {
        //let title = bool ? "FLIP COIN" : "DECIDE"
        setTitle(title, for: .normal)
    }
}
