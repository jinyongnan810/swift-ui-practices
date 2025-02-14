//
//  FontHelper.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/15.
//
import SwiftUI

extension Font {
    static let customFont = Font.custom("DarumadropOne-Regular", size: 16)
}

// reference: https://medium.com/@maysam.shahsavari/changing-the-app-font-globally-in-for-swiftui-views-a-workaround-97e57a2f3e86
extension Font {
    private static var regularFontName: String {
        "DarumadropOne-Regular"
    }

    private static var mediumFontName: String {
        "DarumadropOne-Regular"
    }

    private static var boldFontName: String {
        "DarumadropOne-Regular"
    }

    private static var semiBoldFontName: String {
        "DarumadropOne-Regular"
    }

    private static var extraBoldFontName: String {
        "DarumadropOne-Regular"
    }

    private static var heavyFontName: String {
        "DarumadropOne-Regular"
    }

    private static var lightFontName: String {
        "DarumadropOne-Regular"
    }

    private static var thinFontName: String {
        "DarumadropOne-Regular"
    }

    private static var ultraThinFontName: String {
        "DarumadropOne-Regular"
    }

    /// Sizes
    private static var preferredSizeTitle: CGFloat {
        UIFont.preferredFont(forTextStyle: .title1).pointSize
    }

    private static var preferredLargeTitle: CGFloat {
        UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
    }

    private static var preferredExtraLargeTitle: CGFloat {
        if #available(iOS 17.0, *) {
            UIFont.preferredFont(forTextStyle: .extraLargeTitle).pointSize
        } else {
            UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        }
    }

    private static var preferredExtraLargeTitle2: CGFloat {
        if #available(iOS 17.0, *) {
            UIFont.preferredFont(forTextStyle: .extraLargeTitle2).pointSize
        } else {
            UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        }
    }

    private static var preferredTitle1: CGFloat {
        UIFont.preferredFont(forTextStyle: .title1).pointSize
    }

    private static var preferredTitle2: CGFloat {
        UIFont.preferredFont(forTextStyle: .title2).pointSize
    }

    private static var preferredTitle3: CGFloat {
        UIFont.preferredFont(forTextStyle: .title3).pointSize
    }

    private static var preferredHeadline: CGFloat {
        UIFont.preferredFont(forTextStyle: .headline).pointSize
    }

    private static var preferredSubheadline: CGFloat {
        UIFont.preferredFont(forTextStyle: .subheadline).pointSize
    }

    private static var preferredBody: CGFloat {
        UIFont.preferredFont(forTextStyle: .body).pointSize
    }

    private static var preferredCallout: CGFloat {
        UIFont.preferredFont(forTextStyle: .callout).pointSize
    }

    private static var preferredFootnote: CGFloat {
        UIFont.preferredFont(forTextStyle: .footnote).pointSize
    }

    private static var preferredCaption: CGFloat {
        UIFont.preferredFont(forTextStyle: .caption1).pointSize
    }

    private static var preferredCaption2: CGFloat {
        UIFont.preferredFont(forTextStyle: .caption2).pointSize
    }

    /// Styles
    public static var title: Font {
        Font.custom(regularFontName, size: preferredTitle1)
    }

    public static var title2: Font {
        Font.custom(regularFontName, size: preferredTitle2)
    }

    public static var title3: Font {
        Font.custom(regularFontName, size: preferredTitle3)
    }

    public static var largeTitle: Font {
        Font.custom(regularFontName, size: preferredLargeTitle)
    }

    public static var body: Font {
        Font.custom(regularFontName, size: preferredBody)
    }

    public static var headline: Font {
        Font.custom(regularFontName, size: preferredHeadline)
    }

    public static var subheadline: Font {
        Font.custom(regularFontName, size: preferredSubheadline)
    }

    public static var callout: Font {
        Font.custom(regularFontName, size: preferredCallout)
    }

    public static var footnote: Font {
        Font.custom(regularFontName, size: preferredFootnote)
    }

    public static var caption: Font {
        Font.custom(regularFontName, size: preferredCaption)
    }

    public static var caption2: Font {
        Font.custom(regularFontName, size: preferredCaption2)
    }

    public static func system(_ style: Font.TextStyle, design _: Font.Design? = nil, weight: Font.Weight? = nil) -> Font {
        var size: CGFloat
        var font: String

        switch style {
        case .largeTitle:
            size = preferredLargeTitle
        case .title:
            size = preferredTitle1
        case .title2:
            size = preferredTitle2
        case .title3:
            size = preferredTitle3
        case .headline:
            size = preferredHeadline
        case .subheadline:
            size = preferredSubheadline
        case .body:
            size = preferredBody
        case .callout:
            size = preferredCallout
        case .footnote:
            size = preferredFootnote
        case .caption:
            size = preferredCaption
        case .caption2:
            size = preferredCaption2
        case .extraLargeTitle:
            size = preferredExtraLargeTitle
        case .extraLargeTitle2:
            size = preferredExtraLargeTitle2
        default:
            size = preferredBody
        }

        switch weight {
        case .bold:
            font = boldFontName
        case .regular:
            font = regularFontName
        case .heavy:
            font = heavyFontName
        case .light:
            font = lightFontName
        case .medium:
            font = mediumFontName
        case .semibold:
            font = semiBoldFontName
        case .thin:
            font = thinFontName
        case .ultraLight:
            font = ultraThinFontName
        default:
            font = regularFontName
        }

        return Font.custom(font, size: size)
    }

    public static func system(size: CGFloat, weight: Font.Weight = .regular, design _: Font.Design = .default) -> Font {
        var font: String = switch weight {
        case .bold:
            boldFontName
        case .regular:
            regularFontName
        case .heavy:
            heavyFontName
        case .light:
            lightFontName
        case .medium:
            mediumFontName
        case .semibold:
            semiBoldFontName
        case .thin:
            thinFontName
        case .ultraLight:
            ultraThinFontName
        default:
            regularFontName
        }

        return Font.custom(font, size: size)
    }
}
