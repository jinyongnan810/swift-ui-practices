# 🎨 SwiftUI Practices

A comprehensive collection of **36+ iOS/macOS practice projects** demonstrating SwiftUI components, UIKit patterns, and advanced Apple frameworks. This repository serves as a learning resource with real-world examples ranging from beginner to advanced topics.

![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20macOS-lightgrey.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-✓-blue.svg)

---

## 📚 Table of Contents

- [Technologies Used](#-technologies-used)
- [Main Practices](#-main-practices)
- [Feature Categories](#-feature-categories)
  - [SwiftUI Core Features](#1-swiftui-core-features)
  - [Data Visualization & ML](#2-data-visualization--machine-learning)
  - [Location & Maps](#3-location--maps)
  - [Visual Effects & Canvas](#4-visual-effects--canvas)
  - [Cross-Platform & Localization](#5-cross-platform--localization)
  - [Legacy UIKit & Storyboard](#6-legacy-uikit--storyboard-projects)
- [Setup & Development](#-setup--development)

---

## 🛠 Technologies Used

### Core Frameworks

- [SwiftUI](https://developer.apple.com/xcode/swiftui/) - Modern declarative UI framework
- [Swift](https://github.com/apple/swift) - Programming language
- [UIKit](https://developer.apple.com/documentation/uikit) - Legacy UI framework
- [Combine](https://developer.apple.com/documentation/combine) - Reactive programming

### Data & Persistence

- [SwiftData](https://developer.apple.com/documentation/swiftdata) - Modern data persistence (iOS 17+)
- [Core Data](https://developer.apple.com/documentation/coredata) - Object graph management
- [CloudKit](https://developer.apple.com/icloud/cloudkit/) - Cloud database

### Machine Learning

- [CoreML](https://developer.apple.com/documentation/coreml) - On-device ML inference
- [CreateML](https://developer.apple.com/documentation/createml) - ML model training
- [Vision](https://developer.apple.com/documentation/vision) - Computer vision framework

### Location & Maps

- [MapKit](https://developer.apple.com/documentation/mapkit) - Maps and location services
- [Core Location](https://developer.apple.com/documentation/corelocation) - Location data

### Graphics & Media

- [AVFoundation](https://developer.apple.com/av-foundation/) - Audio/video playback and capture
- [Metal](https://developer.apple.com/metal/) - GPU-accelerated graphics
- [SceneKit](https://developer.apple.com/scenekit/) - 3D graphics
- [ARKit](https://developer.apple.com/augmented-reality/arkit/) - Augmented reality

### Third-Party

- [Firebase](https://github.com/firebase/firebase-ios-sdk) - Auth & Firestore database
- [Lottie](https://github.com/airbnb/lottie-ios) - Animation library by Airbnb

---

## 🌟 Main Practices

| Practice                                                                                           | Type    | Description                                       | Key Features                                                                                                                                                                                                                                  |
| -------------------------------------------------------------------------------------------------- | ------- | ------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [SwiftUIPractices](https://github.com/jinyongnan810/swift-ui-practices/tree/main/SwiftUIPractices) | SwiftUI | **Flagship comprehensive demo** with 27+ features | Navigation & Transition, Custom ViewModifier, Mesh Gradient & Timer & Animation, Scroll Transition & Effects, Observation, SF Symbol Animation, Phase/KeyFrame Animation, Gestures, Text Styling, Shader, Gauges, Clock, Custom UI Components |

---

## 📂 Feature Categories

### 1. SwiftUI Core Features

| Project                                                                                        | Description                  | Key Technologies                                                  |
| ---------------------------------------------------------------------------------------------- | ---------------------------- | ----------------------------------------------------------------- |
| [MyCard](https://github.com/jinyongnan810/swift-ui-practices/tree/main/MyCard)                 | Personal business card UI    | Custom fonts, View extraction, Toast notifications, State binding |
| [HackerNews](https://github.com/jinyongnan810/swift-ui-practices/tree/main/HackerNews)         | Display hacker news feed     | SwiftUI List, Navigation, REST API, WebView, Loading states       |
| [Todoey](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Todoey)                 | Todo list manager            | Core Data integration, CRUD operations                            |
| [Calculator](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Calculator)         | Functional calculator        | NSExpression, NumberFormatter, Adaptive layouts                   |
| [HotkeysManager](https://github.com/jinyongnan810/swift-ui-practices/tree/main/HotkeysManager) | XCode hotkeys reference      | List sections, Search, macOS/iPad themes                          |
| [Shuzi](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Shuzi)                   | Chinese number guessing game | Unit testing, Text-to-speech, AVFoundation, Sheet/Fullscreen      |
| [FizzBuzz](https://github.com/jinyongnan810/swift-ui-practices/tree/main/FizzBuzz)             | FizzBuzz code generator      | Raw strings, Context menus, Clipboard operations                  |
| [AddingGame](https://github.com/jinyongnan810/swift-ui-practices/tree/main/AddingGame)         | Math practice game           | Repeated animations, SwiftData migration, @Observable macro       |
| [Alarm](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Alarm)                   | Alarm clock app              | Date components, Global fonts, Unit testing, SwiftData            |
| [BodyShape](https://github.com/jinyongnan810/swift-ui-practices/tree/main/BodyShape)           | Body shape UI implementation | Custom layouts, ViewModifiers                                     |

### 2. Data Visualization & Machine Learning

| Project                                                                                                                | Description                            | Key Technologies                                 |
| ---------------------------------------------------------------------------------------------------------------------- | -------------------------------------- | ------------------------------------------------ |
| [ChartsPractices](https://github.com/jinyongnan810/swift-ui-practices/tree/main/ChartsPractices)                       | Custom and OS-native charts            | Swift Charts, Custom chart implementations       |
| [ActivityTracker](https://github.com/jinyongnan810/swift-ui-practices/tree/main/ActivityTracker)                       | Activity time tracking with pie charts | SwiftData, Pie/Doughnut charts, Data persistence |
| [Titanic](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Titanic)                                       | ML survival prediction                 | CoreML, CreateML, Tabular data                   |
| [SeeAndRecognize](https://github.com/jinyongnan810/swift-ui-practices/tree/main/SeeAndRecognize)                       | Photo object recognition               | Camera integration, CoreML, Vision framework     |
| [TwitterSentimentModelMaker](https://github.com/jinyongnan810/swift-ui-practices/tree/main/TwitterSentimentModelMaker) | NLP sentiment analysis (CLI)           | CreateML, NLP classification, Model training     |

### 3. Location & Maps

| Project                                                                                        | Description                | Key Technologies                                              |
| ---------------------------------------------------------------------------------------------- | -------------------------- | ------------------------------------------------------------- |
| [MapKitExamples](https://github.com/jinyongnan810/swift-ui-practices/tree/main/MapKitExamples) | Comprehensive MapKit demos | Markers, Polylines, Circles, Look-around, Routing, UI Testing |
| [Clima](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Clima)                   | Weather forecast app       | Weather API, Core Location, JSON parsing, Permissions         |

### 4. Visual Effects & Canvas

| Project                                                                                                                          | Description                    | Key Technologies                                                |
| -------------------------------------------------------------------------------------------------------------------------------- | ------------------------------ | --------------------------------------------------------------- |
| [camera-practices](https://github.com/jinyongnan810/swift-ui-practices/tree/main/camera-practices)                               | Camera capture with effects    | AVFoundation, Vision framework, Buffer rendering, Image masking |
| [spider-effect](https://github.com/jinyongnan810/swift-ui-practices/tree/main/spider-effect)                                     | Interactive spider web effect  | Canvas drawing, Dot/line rendering, Noise algorithms            |
| [Game of Life](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Game%20Of%20Life)                                   | Conway's Game of Life          | Canvas rendering, Cellular automata                             |
| [Game of Life Pattern Editor](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Game%20Of%20Life%20Pattern%20Editor) | Pattern creator with drag/drop | NSItemProvider, Drag & drop, Pattern serialization              |

### 5. Cross-Platform & Localization

| Project                                                                                                              | Description                   | Key Technologies                                                          |
| -------------------------------------------------------------------------------------------------------------------- | ----------------------------- | ------------------------------------------------------------------------- |
| [Greetings](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Greetings)                                 | Multi-language greeting cards | Light/Dark mode, Localization, @AppStorage, iPad detection, macOS sharing |
| [ThirdPartyPackageExamples](https://github.com/jinyongnan810/swift-ui-practices/tree/main/ThirdPartyPackageExamples) | Third-party library demos     | [Lottie animations](https://github.com/airbnb/lottie-ios)                 |

### 6. In-App Purchases

| Project                                                                                  | Description                    | Key Technologies                               |
| ---------------------------------------------------------------------------------------- | ------------------------------ | ---------------------------------------------- |
| [InspoQuotes](https://github.com/jinyongnan810/swift-ui-practices/tree/main/InspoQuotes) | Quote app with premium content | StoreKit, In-app purchases, Purchase detection |

### 7. Legacy UIKit & Storyboard Projects

<details>
<summary><b>Click to expand UIKit/Storyboard examples (11 projects)</b></summary>

These projects demonstrate UIKit patterns and are useful for understanding iOS development evolution:

| Project                                                                                          | Description                 | Key Concepts                                                                                                                   |
| ------------------------------------------------------------------------------------------------ | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| [I am Rich](https://github.com/jinyongnan810/swift-ui-practices/tree/main/I%20am%20Rich)         | Basic image display         | Storyboard basics, Assets                                                                                                      |
| [Dicee](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Dicee)                     | Dice rolling app            | IBOutlet/IBAction, Constraints, Random numbers                                                                                 |
| [Xylophone](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Xylophone)             | Musical instrument          | AVAudioPlayer, Bundle resources, UIView.animate                                                                                |
| [EggTimer](https://github.com/jinyongnan810/swift-ui-practices/tree/main/EggTimer)               | Cooking timer with progress | Timer, UIProgressView, Animations                                                                                              |
| [Quizzler](https://github.com/jinyongnan810/swift-ui-practices/tree/main/Quizzler)               | Quiz application            | MVC pattern, Structs, Mutating functions                                                                                       |
| [BMI Calculator](https://github.com/jinyongnan810/swift-ui-practices/tree/main/BMI%20Calculator) | Body mass index calculator  | Multiple ViewControllers, Segues, Modal presentation                                                                           |
| [FlashChat](https://github.com/jinyongnan810/swift-ui-practices/tree/main/FlashChat)             | Real-time chat app          | Firebase Auth, Firestore, TableView, Keyboard handling, [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager) |
| [ARDicee](https://github.com/jinyongnan810/swift-ui-practices/tree/main/ARDicee)                 | AR dice rolling             | ARKit, SceneKit, Plane detection, 3D objects                                                                                   |

</details>

---

## 🚀 Setup & Development

### Prerequisites

- **Xcode 15.0+** (for iOS 17+ features)
- **macOS Sonoma** or later
- **Swift 5.9+**
- **iOS 17.0+** deployment target (for SwiftData projects)

### Getting Started

1. **Clone the repository**

   ```bash
   git clone https://github.com/jinyongnan810/swift-ui-practices.git
   cd swift-ui-practices
   ```

2. **Open a specific project**

   ```bash
   open SwiftUIPractices/SwiftUIPractices.xcodeproj
   ```

3. **For Firebase projects** (FlashChat)
   ```bash
   cd FlashChat
   pod install
   open FlashChat.xcworkspace
   ```

### Code Quality

This repository uses [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) for code formatting:

```bash
# Run formatting
make lint

# Install SwiftFormat
brew install swiftformat
```

### Development Tips

- **Toggle Dark Mode in Simulator:** `Cmd + Shift + A`
- **Swift 6 Compatibility:** See [trouble-shooting.md](trouble-shooting.md) for migration notes
- **UI Testing:** MapKitExamples includes UI test recording examples

---

## 📖 Project Structure

```
swift-ui-practices/
├── SwiftUIPractices/          # 🌟 Main comprehensive demo
├── ChartsPractices/
├── MapKitExamples/
├── camera-practices/
├── [30+ other projects]/
├── readme.md
├── tips.md
├── trouble-shooting.md
├── Makefile
└── .swiftformat
```

---

## 🤝 Contributing

This is a personal learning repository, but suggestions and improvements are welcome! Feel free to:

- Open an issue for bugs or suggestions
- Submit a PR for improvements
- Star the repo if you find it useful

---

## 📝 License

This project is available for educational purposes. Individual projects may use different frameworks and libraries - check their respective licenses.

---

## 🔗 Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Swift.org](https://www.swift.org/)
- [Hacking with Swift](https://www.hackingwithswift.com/)

---

**Made with ❤️ for learning iOS development**
