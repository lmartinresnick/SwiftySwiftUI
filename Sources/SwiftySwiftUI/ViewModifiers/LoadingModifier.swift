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
@available(iOS 13.0, tvOS 13.0, macOS 10.15, *)
public struct LoadingModifier<LoadingContent: View>: ViewModifier {
    /// Boolean to show loading view
    private let isLoading: Bool
    /// View to show when `isLoading = true`
    private let loadingContent: LoadingContent
    /// Initializer to set properties
    public init(state isLoading: Bool, @ViewBuilder loadingContent: () -> LoadingContent) {
        self.isLoading = isLoading
        self.loadingContent = loadingContent()
    }
    /// A loading view modifier to indicate network or general activity and progress
    ///
    /// The following example demonstrates a list loading content
    ///
    ///         struct ContactListView: View {
    ///             @State private var isLoading: Bool = true
    ///
    ///             var body: some View {
    ///                 List {
    ///                     ForEach(contactsArray, id: \.id) { contact in
    ///                         VStack {
    ///                             Text(contact.name)
    ///                                 .font(.title)
    ///                                 .padding()
    ///                             Text(contact.phoneNumber)
    ///                                 .font(.headline)
    ///                                 .padding()
    ///                         }
    ///                     }
    ///                 }
    ///                 .loadingStyle(state: isLoading) {
    ///                     ProgressView()
    ///                 }
    ///             }
    ///         }
    ///
    ///
    ///
    public func body(content: Content) -> some View {
        if isLoading {
            loadingContent
                .padding()
        } else {
            content
        }
    }
}

extension View {
    /// Loading modifer `SwiftUI.View` extension
    ///
    /// The following example demonstrates view with the modifier
    ///
    ///      VStack {
    ///         Text("Hello World")
    ///      }
    ///      .loadingStyle(state: isLoading) {
    ///          ProgressView()
    ///      }
    ///
    ///
    func loadingStyle<Content: View>(state isLoading: Bool, content: @escaping () -> Content) -> some View {
        modifier(LoadingModifier(state: isLoading, loadingContent: content))
    }
}
