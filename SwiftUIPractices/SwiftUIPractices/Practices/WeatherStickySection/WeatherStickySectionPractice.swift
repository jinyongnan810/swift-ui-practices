// Learning from Kavsoft: https://youtu.be/wq9gQCKr57w
import SwiftUI

struct WeatherStickySectionPractice: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                WeatherSection {
                    HourlyForecastContent()
                } header: {
                    HStack {
                        Text("Sunny from 1am to 11am")
                        Spacer()
                        Image(systemName: "sun.max")
                            .font(.callout)
                    }
                } minimisedHeader: {
                    HStack {
                        Image(systemName: "sun.max")
                        Text("Hourly forecast")
                        Spacer()
                    }
                }
//                WeatherSection {
//                    TenDayForecastContent()
//                } header: {
//                    HStack {
//                        Text("Rain for next 2 days")
//                        Spacer()
//                        Image(systemName: "cloud.rain")
//                            .font(.callout)
//                    }
//                } minimisedHeader: {
//                    HStack {
//                        Image(systemName: "calendar")
//                        Text("10-day forecast")
//                        Spacer()
//                    }
//                }
//
//                WeatherSection {
//                    AirQualityContent()
//                } header: {
//                    HStack {
//                        Text("Air quality is moderate")
//                        Spacer()
//                        Image(systemName: "aqi.medium")
//                            .font(.callout)
//                    }
//                } minimisedHeader: {
//                    HStack {
//                        Image(systemName: "aqi.medium")
//                        Text("Air quality")
//                        Spacer()
//                    }
//                }
//
//                HStack(alignment: .top, spacing: 12) {
//                    WeatherSection {
//                        WeatherMetricContent(value: "5", label: "Moderate", symbolName: "sun.max.trianglebadge.exclamationmark")
//                    } header: {
//                        HStack {
//                            Text("UV Index")
//                            Spacer()
//                            Image(systemName: "sun.max")
//                                .font(.callout)
//                        }
//                    } minimisedHeader: {
//                        HStack {
//                            Image(systemName: "sun.max")
//                            Text("UV")
//                            Spacer()
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//
//                    WeatherSection {
//                        WeatherMetricContent(value: "9 mph", label: "NW", symbolName: "wind")
//                    } header: {
//                        HStack {
//                            Text("Wind")
//                            Spacer()
//                            Image(systemName: "wind")
//                                .font(.callout)
//                        }
//                    } minimisedHeader: {
//                        HStack {
//                            Image(systemName: "wind")
//                            Text("Wind")
//                            Spacer()
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//
//                HStack(alignment: .top, spacing: 12) {
//                    WeatherSection {
//                        WeatherMetricContent(value: "67%", label: "Humidity", symbolName: "humidity.fill")
//                    } header: {
//                        HStack {
//                            Text("Humidity")
//                            Spacer()
//                            Image(systemName: "humidity")
//                                .font(.callout)
//                        }
//                    } minimisedHeader: {
//                        HStack {
//                            Image(systemName: "humidity")
//                            Text("Humidity")
//                            Spacer()
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//
//                    WeatherSection {
//                        WeatherMetricContent(value: "74°", label: "Feels like", symbolName: "thermometer.medium")
//                    } header: {
//                        HStack {
//                            Text("Feels Like")
//                            Spacer()
//                            Image(systemName: "thermometer.medium")
//                                .font(.callout)
//                        }
//                    } minimisedHeader: {
//                        HStack {
//                            Image(systemName: "thermometer.medium")
//                            Text("Feels")
//                            Spacer()
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//
//                WeatherSection {
//                    PrecipitationContent()
//                } header: {
//                    HStack {
//                        Text("Precipitation fades by evening")
//                        Spacer()
//                        Image(systemName: "cloud.drizzle")
//                            .font(.callout)
//                    }
//                } minimisedHeader: {
//                    HStack {
//                        Image(systemName: "cloud.drizzle")
//                        Text("Precipitation")
//                        Spacer()
//                    }
//                }
            }
        }
        .background {
            LinearGradient(
                colors: [Color(red: 0.1, green: 0.2, blue: 0.4), Color(red: 0.3, green: 0.5, blue: 0.8)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }

        .safeAreaPadding(15)
        .preferredColorScheme(.dark)
    }
}

// MARK: - Reusable Custom Section Component (Kavsoft Architecture)

/// A reusable weather card that behaves like a sticky section while scrolling.
///
/// `WeatherSection` accepts three pieces of UI:
/// - `content`: the main body of the card, such as hourly forecast rows or metric details.
/// - `header`: the expanded header shown while the card is fully visible.
/// - `minimisedHeader`: the compact header shown once the expanded header scrolls into its sticky state.
///
/// The effect is built from three coordinated measurements:
/// 1. The header fades out as the card reaches the top of its named coordinate space.
/// 2. The minimized header fades in over the same distance, giving the section a sticky-title feel.
/// 3. The section body offsets, clips, scales, and fades as its bottom passes under the sticky header.
///
/// Each instance owns a named coordinate space so the geometry calculations are local to that card.
/// This keeps full-width cards and two-column cards independent even when they sit in the same scroll view.
struct WeatherSection<Content: View, Header: View, MinimizedHeader: View>: View {
    @ContentBuilder let content: Content
    @ContentBuilder let header: Header
    @ContentBuilder let minimisedHeader: MinimizedHeader
    let config: Config = .init()
    @State private var headerSize: CGSize = .zero

    struct Config {
        var sectionPadding: CGFloat = 16
        var cornerRadius: CGFloat = 20
        var background: AnyShapeStyle = .init(.fill.tertiary)
        var headerFadeDistance: CGFloat = 15
        var sectionFadeDistance: CGFloat = 45
        var sectionFadeScale: CGFloat = 0.1
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            header
                .visualEffect {
                    content,
                        proxy in
                    // means “give me this view’s current frame in the coordinate system named SECTION.”

                    // It does not necessarily mean “give me the unchanging layout position inside the original section.” With visualEffect, scroll views, offsets, scaling, and coordinate spaces involved, the returned frame can reflect the current rendered/visual position.
                    let rect = proxy.frame(in: .named("SECTION"))
                    let minY = max(
                        rect.minY - config.sectionPadding - config.headerFadeDistance,
                        0
                    )
                    // Progress moves from 0 to 1 as the expanded header reaches the sticky zone.
                    // The expanded header uses the inverse value so it disappears at the top.
                    let progress = max(min(minY / config.headerFadeDistance, 1), 0)
                    print("minY: \(minY), progress: \(progress)")
                    return content.opacity(1 - progress)
                }
                .background {
                    minimisedHeader
                        .frame(maxHeight: .infinity)
                        .visualEffect { content, proxy in
                            let rect = proxy.frame(in: .named("SECTION"))
                            let minY = max(rect.minY - config.sectionPadding, 0)
                            // The minimized header uses the same progress value in the opposite direction.
                            let progress = max(min(minY / config.headerFadeDistance, 1), 0)
                            return content.opacity(progress)
                        }
                }
                .padding([.horizontal, .top], config.sectionPadding)
                .onGeometryChange(for: CGSize.self) { proxy in
                    proxy.size
                } action: { newValue in
                    headerSize = newValue
                }

            content
                .padding([.horizontal, .bottom], config.sectionPadding)
                .visualEffect { content, proxy in
                    // Subtracting local and global gives a relative difference between the view’s local position inside the section and its current position inside the scroll view.
                    let rect = proxy.frame(in: .named("SECTION"))
                    let scrollMinY = proxy.frame(in: .scrollView(axis: .vertical)).minY
                    // As the card scrolls under its header, pull the body upward and clip it.
                    // That keeps the content from visually sliding over the sticky header area.
                    let minY = max(rect.minY - scrollMinY, 0)
                    return content
                        .offset(y: -minY)
                }
                .clipped()
        }
        .background {
            GeometryReader { proxy in
                let rect = proxy.frame(in: .named("SECTION"))
                let viewHeight = proxy.size.height
                let headerHeight = headerSize.height + config.sectionPadding
                // Shrink the glass background from the bottom as the card collapses.
                // The header height is preserved so the sticky header still has a visible surface.
                let bottomPadding = min(
                    max(rect.minY, 0),
                    viewHeight - headerHeight
                )
                Rectangle().fill(.clear)
                    .glassEffect(
                        .regular,
                        in: .rect(cornerRadius: config.cornerRadius)
                    ).padding(.bottom, bottomPadding)
            }
        }
        .compositingGroup()
        .visualEffect { [headerSize] content, proxy in
            let rect = proxy.frame(in: .scrollView(axis: .vertical))
            let minY = rect.minY

            let headerHeight = headerSize.height + config.sectionPadding
            let cutoffHeight = proxy.size.height - headerHeight
            // Once the section's body has scrolled past the header, fade and scale the whole card.
            // This creates the disappearing-card effect instead of abruptly removing the content.
            let distance = abs(min(cutoffHeight + minY, 0))
            let progress = max(min(distance / config.sectionFadeDistance, 1), 0)
            let scale = 1 - config.sectionFadeScale * progress
            let opacity = 1 - progress

            return content
                .scaleEffect(scale, anchor: .top)
                .opacity(opacity)
                .offset(y: minY < 0 ? -minY : 0)
        }
        .coordinateSpace(.named("SECTION"))
    }
}

// MARK: - Section Contents

// Removed all individual backgrounds and padding because WeatherSection handles it!

struct HourlyForecastContent: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 24) {
                ForEach(0 ..< 24) { hour in
                    VStack(spacing: 12) {
                        Text(hour == 0 ? "Now" : "\(hour % 12 == 0 ? 12 : hour % 12)\(hour < 12 ? "AM" : "PM")")
                            .font(.subheadline)
                            .fontWeight(hour == 0 ? .bold : .regular)

                        Image(systemName: hour % 3 == 0 ? "cloud.sun.fill" : "sun.max.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.title2)

                        Text("\(72 - hour % 5)°")
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.white)
                    // Fading scroll effects
                    .visualEffect { content, proxy in
                        let frame = proxy.frame(in: .scrollView(axis: .horizontal))
                        let screenWidth = UIScreen.main.bounds.width
                        let midX = frame.midX
                        let distanceFromCenter = abs(screenWidth / 2 - midX)
                        let scale = max(1 - (distanceFromCenter / screenWidth) * 0.4, 0.6)
                        let opacity = max(1 - (distanceFromCenter / screenWidth) * 0.6, 0.2)
                        return content
                            .scaleEffect(scale)
                            .opacity(opacity)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            .padding(.top, 16)
        }
    }
}

struct TenDayForecastContent: View {
    private let forecastDays: [ForecastDay] = [
        .init(day: "Today", symbolName: "cloud.rain.fill", low: 58, high: 71),
        .init(day: "Sun", symbolName: "cloud.sun.rain.fill", low: 56, high: 69),
        .init(day: "Mon", symbolName: "sun.max.fill", low: 60, high: 76),
        .init(day: "Tue", symbolName: "cloud.sun.fill", low: 61, high: 78),
        .init(day: "Wed", symbolName: "sun.max.fill", low: 64, high: 82),
        .init(day: "Thu", symbolName: "wind", low: 59, high: 73),
        .init(day: "Fri", symbolName: "cloud.bolt.rain.fill", low: 55, high: 68),
        .init(day: "Sat", symbolName: "cloud.fill", low: 57, high: 70),
        .init(day: "Sun", symbolName: "sun.max.fill", low: 62, high: 81),
        .init(day: "Mon", symbolName: "cloud.sun.fill", low: 63, high: 79),
    ]

    private let chartLow = 50
    private let chartHigh = 85

    var body: some View {
        VStack(spacing: 0) {
            ForEach(forecastDays) { forecastDay in
                HStack {
                    Text(forecastDay.day)
                        .frame(width: 60, alignment: .leading)
                        .fontWeight(forecastDay.day == "Today" ? .semibold : .regular)

                    Image(systemName: forecastDay.symbolName)
                        .symbolRenderingMode(.multicolor)

                    Spacer()

                    Text("\(forecastDay.low)°")
                        .foregroundColor(.white.opacity(0.5))

                    GeometryReader { proxy in
                        let chartRange = CGFloat(chartHigh - chartLow)
                        let lowOffset = CGFloat(forecastDay.low - chartLow) / chartRange
                        let temperatureRange = CGFloat(forecastDay.high - forecastDay.low) / chartRange

                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.white.opacity(0.2))
                            .overlay(
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(
                                        LinearGradient(colors: [.cyan, .yellow, .orange], startPoint: .leading, endPoint: .trailing)
                                    )
                                    .frame(width: proxy.size.width * temperatureRange)
                                    .offset(x: proxy.size.width * lowOffset),
                                alignment: .leading
                            )
                    }
                    .frame(width: 100, height: 4)

                    Text("\(forecastDay.high)°")
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)

                if forecastDay.id != forecastDays.last?.id {
                    Divider().background(Color.white.opacity(0.2))
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

private struct ForecastDay: Identifiable {
    let id = UUID()
    let day: String
    let symbolName: String
    let low: Int
    let high: Int
}

struct AirQualityContent: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .firstTextBaseline) {
                Text("52")
                    .font(.system(size: 44, weight: .semibold, design: .rounded))

                Text("AQI")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.65))
            }

            Text("Similar to yesterday at this time. Sensitive groups may want shorter outdoor activities.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.75))

            GeometryReader { proxy in
                RoundedRectangle(cornerRadius: 3)
                    .fill(
                        LinearGradient(
                            colors: [.green, .yellow, .orange, .red, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .overlay(alignment: .leading) {
                        Circle()
                            .fill(.white)
                            .frame(width: 10, height: 10)
                            .offset(x: proxy.size.width * 0.22)
                    }
            }
            .frame(height: 6)
        }
        .foregroundColor(.white)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct WeatherMetricContent: View {
    let value: String
    let label: String
    let symbolName: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: symbolName)
                .symbolRenderingMode(.multicolor)
                .font(.title2)

            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
                .minimumScaleFactor(0.7)
                .lineLimit(1)

            Text(label)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundColor(.white)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct PrecipitationContent: View {
    private let chances: [PrecipitationChance] = [
        .init(time: "Now", chance: 70),
        .init(time: "2PM", chance: 62),
        .init(time: "4PM", chance: 44),
        .init(time: "6PM", chance: 28),
        .init(time: "8PM", chance: 12),
    ]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(chances) { chance in
                HStack(spacing: 12) {
                    Text(chance.time)
                        .frame(width: 44, alignment: .leading)
                        .font(.subheadline)

                    GeometryReader { proxy in
                        RoundedRectangle(cornerRadius: 3)
                            .fill(.white.opacity(0.18))
                            .overlay(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(.cyan)
                                    .frame(width: proxy.size.width * CGFloat(chance.chance) / 100)
                            }
                    }
                    .frame(height: 6)

                    Text("\(chance.chance)%")
                        .frame(width: 42, alignment: .trailing)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.75))
                }
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

private struct PrecipitationChance: Identifiable {
    let id = UUID()
    let time: String
    let chance: Int
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 169
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    NavigationStack {
        WeatherStickySectionPractice()
    }
}
