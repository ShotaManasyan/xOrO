//
//  Label.swift
//  Alphabet
//
//  Created by Shota Manasyan on 21.04.22.
//

import UIKit

class Cell: UIView {
    
    var cellButton: UIButton!
    var onButtonSelection:(() -> Void)?
    var isNotValueSet = true
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        initButton()
        setButtonAction()
        
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    func setButtonAction() {
        cellButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc func buttonTapped() {
        onButtonSelection?()
    }
}

private extension Cell {
    
    func initButton() {
        cellButton = UIButton()
        cellButton.backgroundColor = .black
        cellButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(cellButton)
        
        NSLayoutConstraint.activate([
            cellButton.leftAnchor.constraint(equalTo: leftAnchor),
            cellButton.rightAnchor.constraint(equalTo: rightAnchor),
            cellButton.topAnchor.constraint(equalTo: topAnchor),
            cellButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}



