//
//  ViewController.swift
//  Alphabet
//
//  Created by Shota Manasyan on 20.04.22.
//

import UIKit

class ViewController: UIViewController {
    
    private var verticalStack: UIStackView!
    private var player = true
    var newGameButton: UIButton!
    var playerWinLabel: UILabel!
    var grid = [Cell]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVerticalStack()
        initGrid()
        initNewGameButton()
        activateConstraint()
        
    }
    
}

private extension ViewController {
    
    func initGrid() {
        let range = 0...2
        for _ in range {
            let horizontalStackView = initHorizontalStack()
            verticalStack.addArrangedSubview(horizontalStackView)
            for _ in range {
                let cell = Cell()
                horizontalStackView.addArrangedSubview(cell)
                
                cell.onButtonSelection = { [self] in
                    self.cellTapped(cell)
                }
                
                grid.append(cell)
            }
        }
    }
    
    func cellTapped(_ cell: Cell) {
        if player {
            player = false
            cell.set(value: "X")
        }
        else {
            player = true
            cell.set(value: "O")
        }
//        player.toggle()
        findWinner()
    }
    
    func findWinner() {
        
        
        if grid[0].cellButton.title(for: .normal) == grid[1].cellButton.title(for: .normal) && grid[0].cellButton.title(for: .normal) == grid[2].cellButton.title(for: .normal) && grid[0].cellButton.title(for: .normal) != nil {
            
            gridDisebled()
        }
        if grid[3].cellButton.title(for: .normal) == grid[4].cellButton.title(for: .normal) && grid[3].cellButton.title(for: .normal) == grid[5].cellButton.title(for: .normal) && grid[3].cellButton.title(for: .normal) != nil {
            
            gridDisebled()
        }
        if grid[6].cellButton.title(for: .normal) == grid[7].cellButton.title(for: .normal) && grid[6].cellButton.title(for: .normal) == grid[8].cellButton.title(for: .normal) && grid[6].cellButton.title(for: .normal) != nil {
            
            gridDisebled()
        }
        if grid[0].cellButton.title(for: .normal) == grid[3].cellButton.title(for: .normal) && grid[0].cellButton.title(for: .normal) == grid[6].cellButton.title(for: .normal) && grid[0].cellButton.title(for: .normal) != nil {
            
            gridDisebled()
        }
        if grid[1].cellButton.title(for: .normal) == grid[4].cellButton.title(for: .normal) && grid[1].cellButton.title(for: .normal) == grid[7].cellButton.title(for: .normal) && grid[1].cellButton.title(for: .normal) != nil {
            
            gridDisebled()
        }
        if grid[2].cellButton.title(for: .normal) == grid[5].cellButton.title(for: .normal) && grid[2].cellButton.title(for: .normal) == grid[8].cellButton.title(for: .normal) && grid[2].cellButton.title(for: .normal) != nil {
            
            gridDisebled()
        }
        if grid[0].cellButton.title(for: .normal) == grid[4].cellButton.title(for: .normal) && grid[0].cellButton.title(for: .normal) == grid[8].cellButton.title(for: .normal) && grid[0].cellButton.title(for: .normal) != nil {
            
            gridDisebled()
        }
        if grid[2].cellButton.title(for: .normal) == grid[4].cellButton.title(for: .normal) && grid[2].cellButton.title(for: .normal) == grid[6].cellButton.title(for: .normal) && grid[2].cellButton.title(for: .normal) != nil {
            
            gridDisebled()
        }
    }
    @objc func newGame() {
        for cell in grid {
            cell.cellButton.setTitle(nil, for: .normal)
            cell.cellButton.isEnabled = true
            cell.isValueSet = false
            player = true
            if (playerWinLabel != nil) {
                playerWinLabel.text = nil
            }
        }
    }
    func gridDisebled() {
        for cell in grid {
            cell.cellButton.isEnabled = false
        }
        presentTheWinner()
    }
    
    func presentTheWinner() {
        playerWinLabel = UILabel()
        playerWinLabel.translatesAutoresizingMaskIntoConstraints = false
        playerWinLabel.textColor = .green
        playerWinLabel.font = UIFont.systemFont(ofSize: 40)
        playerWinLabel.text = "Player is winner"
        
        view.addSubview(playerWinLabel)
        
        NSLayoutConstraint.activate([
            
            playerWinLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerWinLabel.bottomAnchor.constraint(equalTo: verticalStack.topAnchor, constant: -40)
        ])
    }
    
    func initNewGameButton() {
        newGameButton = UIButton()
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.backgroundColor = .green
        newGameButton.setTitleColor(.black, for: .normal)
        newGameButton.layer.cornerRadius = 12
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.addTarget(self, action: #selector(newGame), for: .touchUpInside)
        
        view.addSubview(newGameButton)
    }
    
    func initHorizontalStack() -> UIStackView {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 10
        horizontalStack.distribution = .fillEqually
        return horizontalStack
    }
    
    func initVerticalStack() {
        verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = 10
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(verticalStack)
    }
    
    func activateConstraint() {
        
        NSLayoutConstraint.activate([
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            verticalStack.heightAnchor.constraint(equalTo: verticalStack.widthAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            
            newGameButton.heightAnchor.constraint(equalToConstant: 50),
            newGameButton.widthAnchor.constraint(equalToConstant: 200),
            newGameButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor,constant: 30),
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            newGameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }
}
