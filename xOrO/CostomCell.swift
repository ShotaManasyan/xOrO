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
        cellButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        onButtonSelection?()
    }
    
    func set(value: String) {
        if !isValueSet {
            cellButton.setTitle(value , for: .normal)
            cellButton.isEnabled = false
        }
        isValueSet = true
    }
    
    func removeCellText() {
        cellButton.setTitle("", for: .normal)
        cellButton.isEnabled = true
        isValueSet = false
        cellButton.backgroundColor = .white
    }
    func cellDisebled() {
        cellButton.isEnabled = false
    }
    
    func cellbackgroundColor() {
        cellButton.backgroundColor = .green
    }
}

private extension Cell {
    
    func initButton() {
        cellButton = UIButton()
        cellButton.backgroundColor = .white
        cellButton.setTitleColor(.black, for: .normal)
        cellButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
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



