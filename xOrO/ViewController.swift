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
    var grid: [[String]] = []
    var gridArray: [Cell] = []
    let range = 0...2
    
    var gridDisebledState = false {
        
        didSet {
            if gridDisebledState {
                gridArray.forEach({ $0.cellDisebled() })
            }
        }
    }
    
    var newGameState = false {
        
        didSet {
            if newGameState {
                gridArray.forEach({ $0.removeCellText() })
                newGameState = false
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVerticalStack()
        initGrid()
        initNewGameButton()
        activateConstraint()
        presentTheWinner()
    }
    
    func initGrid() {
        for i in range {
            let horizontalStackView = initHorizontalStack()
            verticalStack.addArrangedSubview(horizontalStackView)
            
            grid.append([])
            for j in range {
                let cell = Cell()
                horizontalStackView.addArrangedSubview(cell)
                
                cell.onButtonSelection = {
                    if self.player {
                        self.grid[i][j].append("X")
                        cell.set(value: "X")
                    }
                    else {
                        self.grid[i][j].append("O")
                        cell.set(value: "O")
                    }
                        self.player.toggle()
                    self.findWinner()
                }
                
                grid[i].append("")
                gridArray.append(cell)
            }
        }
    }
    
    func findWinner() {
        var drow = 0
        for i in range {
            var row = 0
            var column = 0
            var diagonal1 = 0
            var diagonal2 = 0
            for j in range {
                
                if grid[i][j] != "" {
                    drow += 1
                    print(drow)
                    if drow == 9 {
                    playerWinLabel.text = "The game ended in a draw"
                    }
                }
                
                if grid[i][i] == grid[i][j], grid[i][j] != "" {
                    row += 1
                    if row == range.count {
                        gridDisebled()
                    }
                }
                
                if grid[i][i] == grid[j][i], grid[j][i] != "" {
                    column += 1
                    if column == range.count {
                        gridDisebled()
                    }
                }
                
                if grid[i][i] == grid[j][j], grid[j][j] != "" {
                    diagonal1 += 1
                    if diagonal1 == range.count {
                        gridDisebled()
                    }
                }
                
                if grid[range.count - 1][0] == grid[range.count - 1 - diagonal2][j], grid[range.count - 1 - diagonal2][j] != "" {
                    diagonal2 += 1
                    if diagonal2 == range.count {
                        gridDisebled()
                    }
                }
            }
        }
        
    }
    @objc func newGame() {
        for i in range {
            for j in range {
                grid[i][j] = ""
            }
        }
        newGameState = true
        player = true
        if playerWinLabel.text != nil {
        playerWinLabel.text = nil
       }
    }
}

private extension ViewController {
    
    func gridDisebled() {
        playerWinLabel.text = "Player is winner"
        gridDisebledState = true
    }
    
    func presentTheWinner() {
        playerWinLabel = UILabel()
        playerWinLabel.translatesAutoresizingMaskIntoConstraints = false
        playerWinLabel.textColor = .green
        playerWinLabel.font = UIFont.systemFont(ofSize: 30)
        
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
        horizontalStack.spacing = 5
        horizontalStack.distribution = .fillEqually
        return horizontalStack
    }
    
    func initVerticalStack() {
        verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = 5
        verticalStack.backgroundColor = .black
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
