
func fibonacci(n: Int) {
    var result: [Int] = [0, 1]

    for index in 2..<n {
        result.append(result[index-2] + result[index-1])
    }

    result
}

fibonacci(n: 12)
