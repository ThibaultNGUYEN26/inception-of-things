// Tic Tac Toe Game Logic
let gridSize = 3;
let board = [];
let currentPlayer = 'X';
let gameActive = true;

const statusDisplay = document.getElementById('gameStatus');
const currentPlayerDisplay = document.querySelector('.current-player');
const gameBoard = document.getElementById('gameBoard');

// Initialize board and winning combinations
function initializeBoard() {
    board = new Array(gridSize * gridSize).fill('');
}

// Check for winning sequence (5 in a row for large grids, full line for small grids)
function checkForWin() {
    const winLength = gridSize >= 6 ? 5 : gridSize; // 5 in a row for 6x6+, full line for smaller grids

    // Check all possible winning sequences
    for (let row = 0; row < gridSize; row++) {
        for (let col = 0; col < gridSize; col++) {
            const startIndex = row * gridSize + col;
            if (board[startIndex] === '') continue;

            const player = board[startIndex];

            // Check horizontal (right)
            if (col <= gridSize - winLength) {
                const sequence = [];
                let isWin = true;
                for (let i = 0; i < winLength; i++) {
                    const index = row * gridSize + col + i;
                    sequence.push(index);
                    if (board[index] !== player) {
                        isWin = false;
                        break;
                    }
                }
                if (isWin) return { winner: player, sequence };
            }

            // Check vertical (down)
            if (row <= gridSize - winLength) {
                const sequence = [];
                let isWin = true;
                for (let i = 0; i < winLength; i++) {
                    const index = (row + i) * gridSize + col;
                    sequence.push(index);
                    if (board[index] !== player) {
                        isWin = false;
                        break;
                    }
                }
                if (isWin) return { winner: player, sequence };
            }

            // Check diagonal (down-right)
            if (row <= gridSize - winLength && col <= gridSize - winLength) {
                const sequence = [];
                let isWin = true;
                for (let i = 0; i < winLength; i++) {
                    const index = (row + i) * gridSize + col + i;
                    sequence.push(index);
                    if (board[index] !== player) {
                        isWin = false;
                        break;
                    }
                }
                if (isWin) return { winner: player, sequence };
            }

            // Check diagonal (down-left)
            if (row <= gridSize - winLength && col >= winLength - 1) {
                const sequence = [];
                let isWin = true;
                for (let i = 0; i < winLength; i++) {
                    const index = (row + i) * gridSize + col - i;
                    sequence.push(index);
                    if (board[index] !== player) {
                        isWin = false;
                        break;
                    }
                }
                if (isWin) return { winner: player, sequence };
            }
        }
    }

    return null;
}// Create the visual board
function createBoard() {
    gameBoard.innerHTML = '';

    // Set CSS variables for responsive sizing based on grid size
    let cellSize, fontSize, gridGap;
    if (gridSize <= 3) {
        cellSize = '80px';
        fontSize = '3rem';
        gridGap = '8px';
    } else if (gridSize <= 5) {
        cellSize = gridSize === 4 ? '70px' : '60px';
        fontSize = gridSize === 4 ? '2.5rem' : '2rem';
        gridGap = '8px';
    } else if (gridSize <= 7) {
        cellSize = '50px';
        fontSize = '1.8rem';
        gridGap = '6px';
    } else if (gridSize <= 9) {
        cellSize = '45px';
        fontSize = '1.5rem';
        gridGap = '4px';
    } else {
        cellSize = '40px';
        fontSize = '1.3rem';
        gridGap = '3px';
    }

    document.documentElement.style.setProperty('--grid-size', gridSize);
    document.documentElement.style.setProperty('--cell-size', cellSize);
    document.documentElement.style.setProperty('--cell-font-size', fontSize);
    document.documentElement.style.setProperty('--grid-gap', gridGap);

    for (let i = 0; i < gridSize * gridSize; i++) {
        const cell = document.createElement('div');
        cell.className = 'cell';
        cell.dataset.index = i;
        cell.onclick = () => makeMove(i);
        gameBoard.appendChild(cell);
    }
}

// Make a move
function makeMove(cellIndex) {
    if (board[cellIndex] !== '' || !gameActive) {
        return;
    }

    board[cellIndex] = currentPlayer;
    updateBoard();
    checkResult();
}

// Update the visual board
function updateBoard() {
    const cells = document.querySelectorAll('.cell');
    cells.forEach((cell, index) => {
        cell.textContent = board[index];
        cell.className = 'cell';
        if (board[index] === 'X') {
            cell.classList.add('x');
        } else if (board[index] === 'O') {
            cell.classList.add('o');
        }
    });
}

// Check for win or tie
function checkResult() {
    const winResult = checkForWin();

    if (winResult) {
        const winLength = gridSize >= 6 ? 5 : gridSize;
        const winText = gridSize >= 6 ? `Player ${currentPlayer} Wins! (${winLength} in a row) 🎉` : `Player ${currentPlayer} Wins! 🎉`;
        statusDisplay.textContent = winText;
        statusDisplay.className = 'game-status winner';
        gameActive = false;
        highlightWinningCells(winResult.sequence);
        return;
    }

    if (!board.includes('')) {
        statusDisplay.textContent = "It's a Tie! 🤝";
        statusDisplay.className = 'game-status tie';
        gameActive = false;
        return;
    }

    currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
    currentPlayerDisplay.textContent = `Player ${currentPlayer}'s Turn`;
}// Highlight winning cells
function highlightWinningCells(combination) {
    const cells = document.querySelectorAll('.cell');
    combination.forEach(index => {
        cells[index].classList.add('winning');
    });
}

// Change grid size
function changeGridSize() {
    const selector = document.getElementById('gridSize');
    gridSize = parseInt(selector.value);
    initializeBoard();
    createBoard();
    resetGame();
}

// Reset the game
function resetGame() {
    initializeBoard();
    currentPlayer = 'X';
    gameActive = true;
    statusDisplay.textContent = '';
    statusDisplay.className = 'game-status';
    currentPlayerDisplay.textContent = `Player ${currentPlayer}'s Turn`;
    updateBoard();
}

// Initialize the game
document.addEventListener('DOMContentLoaded', function() {
    initializeBoard();
    createBoard();
    currentPlayerDisplay.textContent = `Player ${currentPlayer}'s Turn`;
});
