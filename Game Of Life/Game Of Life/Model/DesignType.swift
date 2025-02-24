//
//  DesignType.swift
//  Game Of Life
//
//  Created by Ron Erez on 18/02/2025.
//

enum DesignType: String, CaseIterable {
    case block, beehive, loaf, boat, tub // Still life
    case blinker, toad, beacon, pulsar, pentaDecathlon // Oscillators
    case glider, LWSS, MWSS, HWSS // Space Ships

    var offsetDesign: [(x: Int, y: Int)] {
        switch self {
        // Still life
        case .block:
            [(0, -1), (0, 0), (1, -1), (1, 0)]

        case .beehive:
            [
                (-1, -1),
                (0, -1),
                (-2, 0),
                (1, 0),
                (-1, 1),
                (0, 1),
            ]

        case .loaf:
            [
                (-1, -1),
                (0, -1),
                (-2, 0),
                (1, 0),
                (-1, 1),
                (1, 1),
                (0, 2),
            ]

        case .boat:
            [
                (-1, -1),
                (0, -1),
                (-1, 0),
                (1, 0),
                (0, 1),
            ]

        case .tub:
            [
                (0, -1),
                (-1, 0),
                (1, 0),
                (0, 1),
            ]

        // Oscillators
        case .blinker:
            [
                (0, -1),
                (0, 0),
                (0, 1),
            ]

        case .toad:
            [
                (1, -2),
                (-1, -1),
                (2, -1),
                (-1, 0),
                (2, 0),
                (0, 1),
            ]

        case .beacon:
            [
                (-2, -2),
                (-1, -2),
                (-2, -1),
                (-1, -1),
                (0, 0),
                (1, 0),
                (0, 1),
                (1, 1),
            ]

        case .pulsar:
            [
                (-4, -6),
                (-3, -6),
                (-2, -6),
                (2, -6),
                (3, -6),
                (4, -6),
                (-6, -4),
                (-1, -4),
                (1, -4),
                (6, -4),
                (-6, -3),
                (-1, -3),
                (1, -3),
                (6, -3),
                (-6, -2),
                (-1, -2),
                (1, -2),
                (6, -2),
                (-4, -1),
                (-3, -1),
                (-2, -1),
                (2, -1),
                (3, -1),
                (4, -1),
                (-4, 1),
                (-3, 1),
                (-2, 1),
                (2, 1),
                (3, 1),
                (4, 1),
                (-6, 2),
                (-1, 2),
                (1, 2),
                (6, 2),
                (-6, 3),
                (-1, 3),
                (1, 3),
                (6, 3),
                (-6, 4),
                (-1, 4),
                (1, 4),
                (6, 4),
                (-4, 6),
                (-3, 6),
                (-2, 6),
                (2, 6),
                (3, 6),
                (4, 6),
            ]

        case .pentaDecathlon:
            [
                (-1, -4),
                (0, -4),
                (1, -4),
                (-1, -3),
                (1, -3),
                (-1, -2),
                (0, -2),
                (1, -2),
                (-1, -1),
                (0, -1),
                (1, -1),
                (-1, 0),
                (0, 0),
                (1, 0),
                (-1, 1),
                (0, 1),
                (1, 1),
                (-1, 2),
                (1, 2),
                (-1, 3),
                (0, 3),
                (1, 3),
            ]

        // Spaceships
        case .glider:
            [
                (0, -1),
                (1, 0),
                (-1, 1),
                (0, 1),
                (1, 1),
            ]

        case .LWSS:
            [
                (0, -1),
                (1, -1),
                (-2, 0),
                (-1, 0),
                (1, 0),
                (2, 0),
                (-2, 1),
                (-1, 1),
                (0, 1),
                (1, 1),
                (-1, 2),
                (0, 2),
            ]

        case .MWSS:
            [
                (-2, -2),
                (-1, -2),
                (0, -2),
                (1, -2),
                (2, -2),
                (-3, -1),
                (2, -1),
                (2, 0),
                (-3, 1),
                (1, 1),
                (-1, 2),
            ]

        case .HWSS:
            [
                (-3, -2),
                (-2, -2),
                (-1, -2),
                (0, -2),
                (1, -2),
                (2, -2),
                (-4, -1),
                (2, -1),
                (2, 0),
                (-4, 1),
                (1, 1),
                (-2, 2),
                (-1, 2),
            ]
        }
    }

    static let stillLifeDesign: [DesignType] = [.block, .beehive, .loaf, .boat, .tub]
    static let oscillatorsDesign: [DesignType] = [.blinker, .toad, .beacon, .pulsar, .pentaDecathlon]
    static let spaceShipsDesign: [DesignType] = [.glider, .LWSS, .MWSS, .HWSS]
}
