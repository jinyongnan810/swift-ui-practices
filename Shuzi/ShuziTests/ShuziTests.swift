//
//  ShuziTests.swift
//  ShuziTests
//
//  Created by Yuunan kin on 2025/01/31.
//

@testable import Shuzi
import Testing

struct ShuziTests {
    @Test func testMax() async throws {
        #expect(getMax(a: 1, b: 2) == 2)
    }

    @Test func testMax2() async throws {
        #expect(getMax(a: 3, b: 2) == 3)
    }
}
