//
//  ShuziTests.swift
//  ShuziTests
//
//  Created by Yuunan kin on 2025/01/31.
//

@testable import Shuzi
import Testing

struct ShuziTests {
    @Test func testNumberToShuzi() async throws {
        let viewModel = GameViewModel()
        #expect(viewModel.numberToShuzi(-1) == "")
        #expect(viewModel.numberToShuzi(0) == "零")
        #expect(viewModel.numberToShuzi(1) == "一")
        #expect(viewModel.numberToShuzi(2) == "二")
        #expect(viewModel.numberToShuzi(3) == "三")
        #expect(viewModel.numberToShuzi(4) == "四")
        #expect(viewModel.numberToShuzi(5) == "五")
        #expect(viewModel.numberToShuzi(6) == "六")
        #expect(viewModel.numberToShuzi(7) == "七")
        #expect(viewModel.numberToShuzi(8) == "八")
        #expect(viewModel.numberToShuzi(9) == "九")
        #expect(viewModel.numberToShuzi(10) == "十")
        #expect(viewModel.numberToShuzi(11) == "十一")
        #expect(viewModel.numberToShuzi(12) == "十二")
        #expect(viewModel.numberToShuzi(50) == "五十")
        #expect(viewModel.numberToShuzi(99) == "九十九")
        #expect(viewModel.numberToShuzi(100) == "")
    }
}
