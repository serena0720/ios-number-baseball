//
//  Game.swift
//  NumberBaseball
//
//  Created by Karen, Serena, Whales on 2023/04/28.
//

import Foundation

func createRandomNumbers() -> [Int] {
    var randomNumbers: [Int] = []
    
    while randomNumbers.count < 3 {
        let randomNumber = Int.random(in: 1...9)
        if !randomNumbers.contains(randomNumber) {
            randomNumbers.append(randomNumber)
        }
    }
    return randomNumbers
}

func checkBallCount(to randomNumbers: [Int], from userNumbers: [Int]) -> Int {
    var ballCount = 0
    
    for index in 0...2 {
        if randomNumbers.contains(userNumbers[index]) {
            ballCount += 1
        }
    }
    return ballCount
}

func checkStrikeCount(to randomNumbers: [Int], from userNumbers: [Int]) -> Int {
    var strikeCount = 0
    
    for (a, b) in zip(randomNumbers, userNumbers) {
        if a == b {
            strikeCount += 1
        }
    }
    return strikeCount
}

func getNumbers() {
    var inputNumbers: [Int] = []
    
    print("""
            숫자 세개를 띄어쓰기를 구분하여 입력하세요.
            중복숫자는 허용하지 않습니다.
            입력 :
            """, terminator: " ")
    
    if let input = readLine()?.split(separator: " "),
       input.count == 3,
       input.allSatisfy({str in str.count == 1 && str >= "1" && str <= "9"}),
       Set(input).count == 3
    {
        inputNumbers = input.compactMap({Int($0)})
        playBall(of: inputNumbers)
    } else {
        print("입력이 잘못되었습니다.")
        getNumbers()
    }
}

func playBall(of userNumbers: [Int]) {
    strikeCount = checkStrikeCount(to: randomNumbers, from: userNumbers)
    ballCount = checkBallCount(to: randomNumbers, from: userNumbers) - strikeCount
    attemptCount -= 1

    print("""
        \(strikeCount) 스트라이크, \(ballCount) 볼
        남은 기회 : \(attemptCount)
        """)

    if strikeCount == 3 {
        print("사용자 승리!")
        executeGame(of: selectMenu())
    } else if attemptCount == 0 {
        print("컴퓨터 승리...!")
        executeGame(of: selectMenu())
    }
}
