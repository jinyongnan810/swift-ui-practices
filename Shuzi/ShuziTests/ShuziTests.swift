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
        #expect(0.toShuzi() == (chinese: "零", pinyin: "líng"))
        #expect(1.toShuzi() == (chinese: "一", pinyin: "yī"))
        #expect(2.toShuzi() == (chinese: "二", pinyin: "èr"))
        #expect(3.toShuzi() == (chinese: "三", pinyin: "sān"))
        #expect(4.toShuzi() == (chinese: "四", pinyin: "sì"))
        #expect(5.toShuzi() == (chinese: "五", pinyin: "wǔ"))
        #expect(6.toShuzi() == (chinese: "六", pinyin: "liù"))
        #expect(7.toShuzi() == (chinese: "七", pinyin: "qī"))
        #expect(8.toShuzi() == (chinese: "八", pinyin: "bā"))
        #expect(9.toShuzi() == (chinese: "九", pinyin: "jiǔ"))
        #expect(10.toShuzi() == (chinese: "十", pinyin: "shí"))
        #expect(11.toShuzi() == (chinese: "十 一", pinyin: "shí yī"))
        #expect(12.toShuzi() == (chinese: "十 二", pinyin: "shí èr"))
        #expect(13.toShuzi() == (chinese: "十 三", pinyin: "shí sān"))
        #expect(14.toShuzi() == (chinese: "十 四", pinyin: "shí sì"))
        #expect(15.toShuzi() == (chinese: "十 五", pinyin: "shí wǔ"))
        #expect(16.toShuzi() == (chinese: "十 六", pinyin: "shí liù"))
        #expect(17.toShuzi() == (chinese: "十 七", pinyin: "shí qī"))
        #expect(18.toShuzi() == (chinese: "十 八", pinyin: "shí bā"))
        #expect(19.toShuzi() == (chinese: "十 九", pinyin: "shí jiǔ"))
        #expect(20.toShuzi() == (chinese: "二 十", pinyin: "èr shí"))
        #expect(21.toShuzi() == (chinese: "二 十 一", pinyin: "èr shí yī"))
        #expect(22.toShuzi() == (chinese: "二 十 二", pinyin: "èr shí èr"))
        #expect(23.toShuzi() == (chinese: "二 十 三", pinyin: "èr shí sān"))
        #expect(24.toShuzi() == (chinese: "二 十 四", pinyin: "èr shí sì"))
        #expect(25.toShuzi() == (chinese: "二 十 五", pinyin: "èr shí wǔ"))
        #expect(26.toShuzi() == (chinese: "二 十 六", pinyin: "èr shí liù"))
        #expect(27.toShuzi() == (chinese: "二 十 七", pinyin: "èr shí qī"))
        #expect(28.toShuzi() == (chinese: "二 十 八", pinyin: "èr shí bā"))
        #expect(29.toShuzi() == (chinese: "二 十 九", pinyin: "èr shí jiǔ"))
        #expect(30.toShuzi() == (chinese: "三 十", pinyin: "sān shí"))
        #expect(31.toShuzi() == (chinese: "三 十 一", pinyin: "sān shí yī"))
        #expect(32.toShuzi() == (chinese: "三 十 二", pinyin: "sān shí èr"))
        #expect(33.toShuzi() == (chinese: "三 十 三", pinyin: "sān shí sān"))
        #expect(34.toShuzi() == (chinese: "三 十 四", pinyin: "sān shí sì"))
        #expect(35.toShuzi() == (chinese: "三 十 五", pinyin: "sān shí wǔ"))
        #expect(36.toShuzi() == (chinese: "三 十 六", pinyin: "sān shí liù"))
        #expect(37.toShuzi() == (chinese: "三 十 七", pinyin: "sān shí qī"))
        #expect(38.toShuzi() == (chinese: "三 十 八", pinyin: "sān shí bā"))
        #expect(39.toShuzi() == (chinese: "三 十 九", pinyin: "sān shí jiǔ"))
        #expect(40.toShuzi() == (chinese: "四 十", pinyin: "sì shí"))
        #expect(41.toShuzi() == (chinese: "四 十 一", pinyin: "sì shí yī"))
        #expect(42.toShuzi() == (chinese: "四 十 二", pinyin: "sì shí èr"))
        #expect(43.toShuzi() == (chinese: "四 十 三", pinyin: "sì shí sān"))
        #expect(44.toShuzi() == (chinese: "四 十 四", pinyin: "sì shí sì"))
        #expect(45.toShuzi() == (chinese: "四 十 五", pinyin: "sì shí wǔ"))
        #expect(46.toShuzi() == (chinese: "四 十 六", pinyin: "sì shí liù"))
        #expect(47.toShuzi() == (chinese: "四 十 七", pinyin: "sì shí qī"))
        #expect(48.toShuzi() == (chinese: "四 十 八", pinyin: "sì shí bā"))
        #expect(49.toShuzi() == (chinese: "四 十 九", pinyin: "sì shí jiǔ"))
        #expect(50.toShuzi() == (chinese: "五 十", pinyin: "wǔ shí"))
        #expect(51.toShuzi() == (chinese: "五 十 一", pinyin: "wǔ shí yī"))
        #expect(52.toShuzi() == (chinese: "五 十 二", pinyin: "wǔ shí èr"))
        #expect(53.toShuzi() == (chinese: "五 十 三", pinyin: "wǔ shí sān"))
        #expect(54.toShuzi() == (chinese: "五 十 四", pinyin: "wǔ shí sì"))
        #expect(55.toShuzi() == (chinese: "五 十 五", pinyin: "wǔ shí wǔ"))
        #expect(56.toShuzi() == (chinese: "五 十 六", pinyin: "wǔ shí liù"))
        #expect(57.toShuzi() == (chinese: "五 十 七", pinyin: "wǔ shí qī"))
        #expect(58.toShuzi() == (chinese: "五 十 八", pinyin: "wǔ shí bā"))
        #expect(59.toShuzi() == (chinese: "五 十 九", pinyin: "wǔ shí jiǔ"))
        #expect(60.toShuzi() == (chinese: "六 十", pinyin: "liù shí"))
        #expect(61.toShuzi() == (chinese: "六 十 一", pinyin: "liù shí yī"))
        #expect(62.toShuzi() == (chinese: "六 十 二", pinyin: "liù shí èr"))
        #expect(63.toShuzi() == (chinese: "六 十 三", pinyin: "liù shí sān"))
        #expect(64.toShuzi() == (chinese: "六 十 四", pinyin: "liù shí sì"))
        #expect(65.toShuzi() == (chinese: "六 十 五", pinyin: "liù shí wǔ"))
        #expect(66.toShuzi() == (chinese: "六 十 六", pinyin: "liù shí liù"))
        #expect(67.toShuzi() == (chinese: "六 十 七", pinyin: "liù shí qī"))
        #expect(68.toShuzi() == (chinese: "六 十 八", pinyin: "liù shí bā"))
        #expect(69.toShuzi() == (chinese: "六 十 九", pinyin: "liù shí jiǔ"))
        #expect(70.toShuzi() == (chinese: "七 十", pinyin: "qī shí"))
        #expect(71.toShuzi() == (chinese: "七 十 一", pinyin: "qī shí yī"))
        #expect(72.toShuzi() == (chinese: "七 十 二", pinyin: "qī shí èr"))
        #expect(73.toShuzi() == (chinese: "七 十 三", pinyin: "qī shí sān"))
        #expect(74.toShuzi() == (chinese: "七 十 四", pinyin: "qī shí sì"))
        #expect(75.toShuzi() == (chinese: "七 十 五", pinyin: "qī shí wǔ"))
        #expect(76.toShuzi() == (chinese: "七 十 六", pinyin: "qī shí liù"))
        #expect(77.toShuzi() == (chinese: "七 十 七", pinyin: "qī shí qī"))
        #expect(78.toShuzi() == (chinese: "七 十 八", pinyin: "qī shí bā"))
        #expect(79.toShuzi() == (chinese: "七 十 九", pinyin: "qī shí jiǔ"))
        #expect(80.toShuzi() == (chinese: "八 十", pinyin: "bā shí"))
        #expect(81.toShuzi() == (chinese: "八 十 一", pinyin: "bā shí yī"))
        #expect(82.toShuzi() == (chinese: "八 十 二", pinyin: "bā shí èr"))
        #expect(83.toShuzi() == (chinese: "八 十 三", pinyin: "bā shí sān"))
        #expect(84.toShuzi() == (chinese: "八 十 四", pinyin: "bā shí sì"))
        #expect(85.toShuzi() == (chinese: "八 十 五", pinyin: "bā shí wǔ"))
        #expect(86.toShuzi() == (chinese: "八 十 六", pinyin: "bā shí liù"))
        #expect(87.toShuzi() == (chinese: "八 十 七", pinyin: "bā shí qī"))
        #expect(88.toShuzi() == (chinese: "八 十 八", pinyin: "bā shí bā"))
        #expect(89.toShuzi() == (chinese: "八 十 九", pinyin: "bā shí jiǔ"))
        #expect(90.toShuzi() == (chinese: "九 十", pinyin: "jiǔ shí"))
        #expect(91.toShuzi() == (chinese: "九 十 一", pinyin: "jiǔ shí yī"))
        #expect(92.toShuzi() == (chinese: "九 十 二", pinyin: "jiǔ shí èr"))
        #expect(93.toShuzi() == (chinese: "九 十 三", pinyin: "jiǔ shí sān"))
        #expect(94.toShuzi() == (chinese: "九 十 四", pinyin: "jiǔ shí sì"))
        #expect(95.toShuzi() == (chinese: "九 十 五", pinyin: "jiǔ shí wǔ"))
        #expect(96.toShuzi() == (chinese: "九 十 六", pinyin: "jiǔ shí liù"))
        #expect(97.toShuzi() == (chinese: "九 十 七", pinyin: "jiǔ shí qī"))
        #expect(98.toShuzi() == (chinese: "九 十 八", pinyin: "jiǔ shí bā"))
        #expect(99.toShuzi() == (chinese: "九 十 九", pinyin: "jiǔ shí jiǔ"))
    }
}
