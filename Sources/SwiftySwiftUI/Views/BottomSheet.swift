//
//  SwiftySwiftUI
//
//  Copyright (c) 2022 - Present Luke Martin-Resnick
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SwiftUI
// swiftlint:disable line_length
public enum BottomSheetHeight {
    case half
    case quarter
    case threeQuarter
    case custom(height: CGFloat)
    
    var value: CGFloat {
        switch self {
        case .half:
            return UIScreen.main.bounds.height / 2
        case .quarter:
            return UIScreen.main.bounds.height / 4
        case .threeQuarter:
            return UIScreen.main.bounds.height * 0.75
        case .custom(let height):
            return height
        }
    }
}

private struct BottomSheetControls {
    var draggedOffset: CGFloat = 0
    var previousDragValue: DragGesture.Value?
}

public struct BottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    @State private var controls = BottomSheetControls()
    
    private let height: BottomSheetHeight
    private let topBarHeight: CGFloat
    private let topBarCornerRadius: CGFloat
    private let content: Content
    private let contentBackgroundColor: Color
    private let topBarBackgroundColor: Color
    private let showTopIndicator: Bool
    private let animation: Animation
    
    private var dragToDismissThreshold: CGFloat {
        height.value * 0.2
    }
    
    private var grayBackgroundOpacity: Double {
        isPresented ? (0.4 - Double(controls.draggedOffset) / 600) : 0
    }
    
    public init(
        isPresented: Binding<Bool>,
        height: BottomSheetHeight = .half,
        topBarHeight: CGFloat = 30,
        topBarCornerRadius: CGFloat? = nil,
        topBarBackgroundColor: Color = Color(.systemBackground),
        contentBackgroundColor: Color = Color(.systemBackground),
        showTopIndicator: Bool,
        animation: Animation = .bottomSheetAnimation(),
        @ViewBuilder content: () -> Content
    ) {
        self.topBarBackgroundColor = topBarBackgroundColor
        self.contentBackgroundColor = contentBackgroundColor
        self._isPresented = isPresented
        self.height = height
        self.topBarHeight = topBarHeight
        if let topBarCornerRadius = topBarCornerRadius {
            self.topBarCornerRadius = topBarCornerRadius
        } else {
            self.topBarCornerRadius = topBarHeight / 3
        }
        self.showTopIndicator = showTopIndicator
        self.animation = animation
        self.content = content()
    }
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                lightGrayBaseOverlay
                VStack(spacing: 0) {
//                    buildTopBar(with: geometry)
//                    VStack(spacing: -8) {
//                        Spacer()
//                        content
//                            .padding(.bottom, geometry.safeAreaInsets.bottom)
//                        Spacer()
//                    }
                    if showTopIndicator {
                        buildTopBar(with: geometry)
                    }
                    
                    content
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                    //Spacer() - min(controls.draggedOffset * 2, 0)
                }
                .frame(height: height.value)
                .background(contentBackgroundColor)
                .cornerRadius(topBarCornerRadius, corners: [.topLeft, .topRight])
                .offset(y: calculateYOffsetForPresentedView(with: geometry))
            }
            .gesture(
                DragGesture()
                    .onChanged(onChangedAction)
                    .onEnded(onEndedAction)
            )
        }
    }
    
    // MARK: - Private views
    
    private var lightGrayBaseOverlay: some View {
        Color.black
            .opacity(grayBackgroundOpacity)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                withAnimation(animation) {
                    isPresented = false
                }
            }
    }
    
    private func buildTopBar(with geometry: GeometryProxy) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.secondary)
                .frame(width: 40, height: 6)
                // .opacity(showTopIndicator ? 1 : 0)
        }
        .frame(width: geometry.size.width, height: topBarHeight)
        .background(topBarBackgroundColor)
    }
    
    // MARK: - Private methods
    
    private func onChangedAction(value: DragGesture.Value) {
        let offsetY = value.translation.height
        controls.draggedOffset = offsetY
        
        if let previousValue = controls.previousDragValue {
            let previousOffsetY = previousValue.translation.height
            let timeDiff = Double(value.time.timeIntervalSince(previousValue.time))
            let heightDiff = Double(offsetY - previousOffsetY)
            let velocityY = heightDiff / timeDiff
            if velocityY > 1400 {
                isPresented = false
                return
            }
        }
        
        controls.previousDragValue = value
    }
    
    private func onEndedAction(value: DragGesture.Value) {
        let offsetY = value.translation.height
        if offsetY > dragToDismissThreshold {
            isPresented = false
        }
        controls.draggedOffset = 0
    }
    
    private func calculateYOffsetForPresentedView(with geometry: GeometryProxy) -> CGFloat {
        isPresented ? (geometry.size.height / 2 - height.value / 2 + geometry.safeAreaInsets.bottom + controls.draggedOffset) : (geometry.size.height / 2 + height.value / 2 + geometry.safeAreaInsets.bottom)
    }
}

public extension Animation {
    static func bottomSheetAnimation() -> Animation {
        Animation.spring(response: 0.35, dampingFraction: 0.86, blendDuration: 0.25)
    }
}

public extension View {
    func bottomSheet<Content: View>(
        isPresented: Binding<Bool>,
        height: BottomSheetHeight,
        topBarHeight: CGFloat = 30,
        topBarCornerRadius: CGFloat? = nil,
        contentBackgroundColor: Color = Color(.systemBackground),
        topBarBackgroundColor: Color = Color(.systemBackground),
        showTopIndicator: Bool = true,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ZStack {
            self
            BottomSheet(isPresented: isPresented,
                        height: height,
                        topBarHeight: topBarHeight,
                        topBarCornerRadius: topBarCornerRadius,
                        topBarBackgroundColor: topBarBackgroundColor,
                        contentBackgroundColor: contentBackgroundColor,
                        showTopIndicator: showTopIndicator,
                        content: content)
        }
    }
}
