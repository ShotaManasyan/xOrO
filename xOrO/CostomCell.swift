//
//  Label.swift
//  Alphabet
//
//  Created by Shota Manasyan on 21.04.22.
//

import UIKit

class squareView: UIView {
    
    var squareButton: UIButton!
    var onButtonSelection:(() -> Void)?
    var isValueSet = false
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        initButton()
        setButtonAction()
        
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
    }
    
    func setButtonAction() {
        squareButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        onButtonSelection?()
    }
    
    func set(value: String) {
        if !isValueSet {
            squareButton.setTitle(value , for: .normal)
            squareButton.isEnabled = false
        }
        isValueSet = true
    }
    
    func removeSquareText() {
        squareButton.setTitle("", for: .normal)
        squareButton.isEnabled = true
        isValueSet = false
        squareButton.backgroundColor = .white
    }
    func SquareDisebled() {
        squareButton.isEnabled = false
    }
}

private extension squareView {
    
    func initButton() {
        squareButton = UIButton()
        squareButton.backgroundColor = .white
        squareButton.setTitleColor(.black, for: .normal)
        squareButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        squareButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(squareButton)
        
        NSLayoutConstraint.activate([
            squareButton.leftAnchor.constraint(equalTo: leftAnchor),
            squareButton.rightAnchor.constraint(equalTo: rightAnchor),
            squareButton.topAnchor.constraint(equalTo: topAnchor),
            squareButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
