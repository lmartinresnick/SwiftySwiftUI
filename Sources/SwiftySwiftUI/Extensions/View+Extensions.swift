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

@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
extension View {
    /// A `NavigationView` wrapper
    ///
    /// The following example presents three links to color detail
    ///
    ///     VStack {
    ///         List {
    ///             NavigationLink("Purple", destination: ColorDetail(color: .purple))
    ///             NavigationLink("Pink", destination: ColorDetail(color: .pink))
    ///             NavigationLink("Orange", destination: ColorDetail(color: .orange))
    ///         }
    ///         .navigationTitle("Colors")
    ///     }
    ///     .embedInNavigationView()
    ///
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
    /// An `AnyView` wrapper
    /// Transform any `SwiftUI.View` to `AnyView` instantly
    ///
    /// The following example presents text
    ///
    ///     VStack {
    ///         Text("Hello World")
    ///     }
    ///     .eraseToAnyView()
    ///
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
    /// Positions this view within an invisible frame with the same width and height
    ///
    /// The following example presents a circle
    ///
    ///     VStack {
    ///         Circle()
    ///             .frame(50)
    ///     }
    ///
    func frame(_ dimensions: CGFloat) -> some View {
        self
            .frame(width: dimensions, height: dimensions)
    }
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
