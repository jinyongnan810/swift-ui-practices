//
//  DynamicIslandToast.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/01/11.
//
//  ============================================================================
//  概要 (Overview):
//  このファイルは、iPhone 14 Pro以降のDynamic Islandからトースト通知が
//  展開するアニメーションを実装しています。
//  Dynamic Islandがないデバイスでは、画面上部からスライドインするフォールバック
//  アニメーションが適用されます。
//
//  主要コンポーネント:
//  1. DynamicIslandToast - デモ用のメインView
//  2. DynamicIslandToastViewModifier - トースト機能を追加するViewModifier
//  3. ToastView - 実際のトースト表示を担当するView
//  4. PassthroughWindow - タッチイベントを透過する特殊なUIWindow
//  5. CustomHostingView - ステータスバーの表示/非表示を制御
//  ============================================================================

import Observation
import SwiftUI

// MARK: - メインのデモView

/// Dynamic Island トーストのデモ画面
/// ボタンをタップすることでトーストの表示/非表示を切り替えられる
struct DynamicIslandToast: View {
    /// トーストの表示状態を管理する状態変数
    @State private var isPresented: Bool = false

    var body: some View {
        ZStack {
            // 背景のグラデーション（装飾目的）
            LinearGradient(
                colors: [.cyan, .blue, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()

            VStack {
                // トースト表示/非表示を切り替えるボタン
                Button {
                    isPresented.toggle()
                } label: {
                    Text(isPresented ? "Hide Toast" : "Show Toast")
                }.buttonStyle(.glass)
            }.onChange(of: isPresented) { _, _ in
                // 自動非表示機能（コメントアウト中）
                // 有効にすると3秒後に自動的にトーストが消える
                //                if newValue {
                //                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                //                        isPresented = false
                //                    }
                //                }
            }

        }.navigationTitle("Dynamic Island Toast")
            .toolbarTitleDisplayMode(.inline)
            // カスタムViewModifierでトースト機能を追加
            .dynamicIslandToast(isPresented: $isPresented, text: "Hello World!")
    }
}

// MARK: - View Extension

/// 任意のViewにDynamic Islandトースト機能を追加するための拡張
extension View {
    /// Dynamic Islandスタイルのトーストを表示するModifierを適用
    /// - Parameters:
    ///   - isPresented: トーストの表示状態をバインディング
    ///   - text: トーストに表示するテキスト
    @ViewBuilder
    func dynamicIslandToast(isPresented: Binding<Bool>, text: String) -> some View {
        modifier(DynamicIslandToastViewModifier(isPresented: isPresented, text: text))
    }
}

// MARK: - ViewModifier

/// トースト表示のロジックを担当するViewModifier
/// オーバーレイウィンドウを作成し、トーストの状態を管理する
struct DynamicIslandToastViewModifier: ViewModifier {
    /// 親Viewからのバインディング（トースト表示状態）
    @Binding var isPresented: Bool
    /// トーストに表示するテキスト
    var text: String

    /// トーストを表示するための透過ウィンドウ
    /// 通常のViewの上に別レイヤーとして表示される
    @State private var overlayWindow: PassthroughWindow?

    /// ステータスバーの表示制御用のHostingController
    @State private var overlayController: CustomHostingView?

    func body(content: Content) -> some View {
        content
            // WindowExtractorで現在のUIWindowを取得
            .background(WindowExtractor(getResult: { window in
                createOverlayWindow(window)
            }))
            // isPresented の変更を監視してオーバーレイウィンドウを更新
            .onChange(of: isPresented, initial: true) { _, newValue in
                guard let overlayWindow else { return }
                // トースト表示時にテキストを設定
                if newValue {
                    overlayWindow.text = text
                }
                // ウィンドウの表示状態を更新
                overlayWindow.isPresented = newValue
                // ステータスバーの表示/非表示を切り替え
                // トースト表示中はステータスバーを隠す（Dynamic Islandとの一体感のため）
                overlayController?.isStatusBarHidden = newValue
            }
            // オーバーレイウィンドウ側からの状態変更を監視
            // （ドラッグジェスチャーで閉じた場合など）
            .onChange(of: overlayWindow?.isPresented) { _, newValue in
                if let newValue, let _ = overlayWindow, newValue != isPresented {
                    isPresented = newValue
                }
            }
    }

    /// オーバーレイウィンドウを作成または取得する
    /// - Parameter window: 現在のUIWindow（参照用）
    func createOverlayWindow(_ window: UIWindow) {
        guard let windowScene = window.windowScene else {
            return
        }

        // 既存のオーバーレイウィンドウがあれば再利用（tag: 1009で識別）
        // これにより複数のトーストModifierが同じウィンドウを共有できる
        if let window = windowScene.windows.first(
            where: { $0.tag == 1009 }
        ) as? PassthroughWindow {
            overlayWindow = window
            overlayController = window.rootViewController as? CustomHostingView
        } else {
            // 新しいオーバーレイウィンドウを作成
            let overlayWindow = PassthroughWindow(windowScene: windowScene)
            overlayWindow.backgroundColor = .clear // 背景を透明に
            overlayWindow.isHidden = false // 表示状態にする
            overlayWindow.isUserInteractionEnabled = true // タッチイベントを有効化
            createRootController(overlayWindow)

            self.overlayWindow = overlayWindow
        }
    }

    /// オーバーレイウィンドウのルートViewControllerを設定
    /// - Parameter window: 設定対象のPassthroughWindow
    func createRootController(_ window: PassthroughWindow) {
        let hostingController = CustomHostingView(rootView: ToastView(window: window))
        hostingController.view.backgroundColor = .clear
        window.rootViewController = hostingController
        overlayController = hostingController
    }
}

// MARK: - ToastView

/// 実際のトースト表示を担当するView
/// Dynamic Islandからの展開アニメーションを実装
struct ToastView: View {
    /// 親のPassthroughWindowへの参照（状態の読み取り用）
    var window: PassthroughWindow

    /// トーストが展開されているかどうか
    var isExpanded: Bool {
        window.isPresented
    }

    var body: some View {
        GeometryReader { geo in
            let safeArea = geo.safeAreaInsets
            let size = geo.size

            // Dynamic Islandの有無を判定
            // iPhone 14 Pro以降はsafeArea.topが59pt以上
            let hasDynamicIsland = safeArea.top >= 59

            // ============================================
            // Dynamic Islandの初期サイズ（折りたたみ時）
            // ============================================
            let dynamicIslandWidth: CGFloat = 120 // Dynamic Islandの幅
            let dynamicIslandHeight: CGFloat = 36 // Dynamic Islandの高さ
            // Dynamic Islandの位置オフセット（ノッチ部分との位置合わせ）
            let offset: CGFloat = 11 + max(safeArea.top - 59, 0)

            // ============================================
            // 展開時のサイズ
            // ============================================
            let expandedWidth: CGFloat = size.width - 20 // 画面幅 - 余白
            let expandedHeight: CGFloat = 90 // 展開時の高さ

            // スケール係数の計算
            // 折りたたみ時は小さく、展開時は1.0（等倍）
            let scaleX: CGFloat = isExpanded ? 1 : dynamicIslandWidth / expandedWidth
            let scaleY: CGFloat = isExpanded ? 1 : dynamicIslandHeight / expandedHeight

            ZStack {
                // トーストの背景（角丸の黒い矩形）
                // ConcentricRectangleは角丸が同心円的に変化するカスタムShape
                ConcentricRectangle(
                    corners: .concentric(minimum: .fixed(30)),
                    isUniform: true
                )
                .fill(.black)
                .overlay {
                    // トーストのコンテンツ（テキストとアイコン）
                    ToastContent(hasDynamicIsland: hasDynamicIsland)
                        .frame(
                            width: expandedWidth,
                            height: expandedHeight
                        )
                        // コンテンツもスケールして折りたたみ効果を実現
                        .scaleEffect(x: scaleX, y: scaleY)
                }
                .frame(
                    // 展開状態に応じてフレームサイズを変更
                    width: isExpanded ? expandedWidth : dynamicIslandWidth,
                    height: isExpanded ? expandedHeight : dynamicIslandHeight
                )
                .offset(
                    // Y方向のオフセット
                    // Dynamic Islandあり: 固定位置（Dynamic Islandと重なる位置）
                    // Dynamic Islandなし: 展開時は画面上部、折りたたみ時は画面外（-80）
                    y: hasDynamicIsland ? offset : (isExpanded ? safeArea.top + 10 : -80)
                )
                // 透明度の制御
                .opacity(hasDynamicIsland ? 1 : (isExpanded ? 1 : 0))
                // 透明度のアニメーション（遅延付き）
                // 折りたたみ時は0.3秒遅延してフェードアウト
                .animation(.linear(duration: 0.2).delay(isExpanded ? 0 : 0.30)) { content in
                    content.opacity(hasDynamicIsland ? 1 : (isExpanded ? 1 : 0))
                }
                // geometryGroupでアニメーションの一貫性を確保
                .geometryGroup()
                // タッチ領域を矩形に設定
                .contentShape(.rect)
                // 上方向へのスワイプでトーストを閉じる
                .gesture(DragGesture().onEnded { value in
                    if value.translation.height < 0 {
                        window.isPresented = false
                    }
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .ignoresSafeArea()
            // 展開/折りたたみのメインアニメーション（バウンス効果付き）
            .animation(
                .bouncy(duration: 0.3, extraBounce: 0),
                value: isExpanded
            )
        }
    }

    /// トーストの内部コンテンツ（アイコンとテキスト）
    /// - Parameter hasDynamicIsland: Dynamic Islandの有無
    @ViewBuilder
    func ToastContent(hasDynamicIsland: Bool) -> some View {
        if let text = window.text {
            HStack(spacing: 10) {
                // 成功を示すチェックマークアイコン
                Image(systemName: "checkmark.circle")
                    .foregroundStyle(.green)
                    // 展開時にアイコンが揺れるアニメーション（3回繰り返し）
                    .symbolEffect(
                        .wiggle,
                        options: .repeat(3),
                        value: isExpanded
                    )
                    .font(.largeTitle)

                VStack(alignment: .leading, spacing: 4) {
                    // Dynamic Islandありの場合、上部にスペースを追加
                    // （ノッチ部分との位置調整）
                    if hasDynamicIsland {
                        Spacer(minLength: 0)
                    }
                    // トーストのメッセージテキスト
                    Text(text)
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                }
                .frame(width: .infinity, alignment: .leading)
                // Dynamic Islandありの場合、下部にパディングを追加
                .padding(.bottom, hasDynamicIsland ? 12 : 0)
                .lineLimit(1) // 1行に制限
            }
            .padding(.horizontal, 20)
            // compositingGroupでブラー効果を正しく適用
            .compositingGroup()
            // 折りたたみ時はコンテンツをぼかす（フェードアウト効果）
            .blur(radius: isExpanded ? 0 : 10)
            .opacity(isExpanded ? 1 : 0)
        } else {
            // テキストが設定されていない場合のフォールバック
            Text("No Text?").foregroundStyle(.white)
        }
    }
}

// MARK: - WindowExtractor

/// SwiftUIのView階層から現在のUIWindowを取得するためのUIViewRepresentable
/// UIKitのwindowプロパティにアクセスするために必要
struct WindowExtractor: UIViewRepresentable {
    /// UIWindowを取得した際に呼ばれるコールバック
    var getResult: (UIWindow) -> Void

    func makeUIView(context _: Context) -> some UIView {
        let view = UIView()
        view.backgroundColor = .clear
        // 次のRunLoopでwindowを取得（Viewがwindow階層に追加された後）
        DispatchQueue.main.async {
            if let window = view.window {
                getResult(window)
            }
        }
        return view
    }

    func updateUIView(_: UIViewType, context _: Context) {}
}

// MARK: - PassthroughWindow

/// タッチイベントを選択的に透過する特殊なUIWindow
/// トーストエリア以外のタッチは下のViewに伝播される
///
/// @Observable マクロにより、プロパティの変更がSwiftUIに自動的に通知される
@Observable
class PassthroughWindow: UIWindow {
    /// トーストに表示するテキスト
    var text: String? = nil
    /// トーストの表示状態
    var isPresented: Bool = false

    /// タッチイベントのヒットテストをオーバーライド
    /// トーストエリア以外のタッチは透過（nilを返す）
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event),
              let rootView = rootViewController?.view
        else {
            return nil
        }

        // iOS 26以降の処理
        if #available(iOS 26, *) {
            // レイヤーのヒットテストでnameがnilの場合はrootViewを返す
            if rootView.layer.hitTest(point)?.name == nil {
                return rootView
            }
            return nil
        } else {
            // iOS 18未満の処理
            if #unavailable(iOS 18) {
                // hitViewがrootViewと同じなら透過（nil）、そうでなければhitViewを返す
                return hitView == rootView ? nil : hitView
            } else {
                // iOS 18〜26未満の処理
                // サブビューを逆順（手前から）にチェック
                for subView in rootView.subviews.reversed() {
                    let pointInSubView = subView.convert(point, from: rootView)
                    if subView.hitTest(pointInSubView, with: event) != nil {
                        return hitView
                    }
                }
                // どのサブビューにもヒットしなければ透過
                return nil
            }
        }
    }
}

// MARK: - CustomHostingView

/// ステータスバーの表示/非表示を制御するカスタムUIHostingController
/// トースト表示中はステータスバーを隠すことで、
/// Dynamic Islandとの一体感を演出する
class CustomHostingView: UIHostingController<ToastView> {
    /// ステータスバーを隠すかどうか
    var isStatusBarHidden: Bool = false {
        didSet {
            // ステータスバーの表示状態を更新するようシステムに通知
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    /// ステータスバーを隠すかどうかを返すプロパティ
    override var prefersStatusBarHidden: Bool {
        isStatusBarHidden
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        DynamicIslandToast()
    }
}
