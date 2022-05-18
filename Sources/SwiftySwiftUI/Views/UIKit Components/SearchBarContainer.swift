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

public struct SearchBarContainer: UIViewRepresentable {
    public typealias SearchButtonAction = (String) -> Void
    
    @Binding public var text: String
    @Binding public var isSearching: Bool
    public var font: UIFont
    public var placeholder: String
    public var searchButtonPressed: SearchButtonAction
    
    public func makeUIView(context: UIViewRepresentableContext<SearchBarContainer>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.setCenteredPlaceholder()
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.font = font
        return searchBar
    }

    public func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBarContainer>) {
        uiView.text = text
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isSearching: $isSearching, searchButtonPressed: searchButtonPressed)
    }

    public class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var isSearching: Bool
        var searchButtonPressed: (String) -> Void

        public init(text: Binding<String>, isSearching: Binding<Bool>, searchButtonPressed: @escaping (String) -> Void) {
            self._text = text
            self._isSearching = isSearching
            self.searchButtonPressed = searchButtonPressed
        }

        public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
            searchBar.setPositionAdjustment(.zero, for: .search)
            isSearching = true
        }
        
        public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchButtonPressed(text)
            searchBar.endEditing(true)
            searchBar.cancelButton?.isEnabled = true
        }

        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.endEditing(true)
            searchBar.cancelButton?.isEnabled = true
            return true
        }

        public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            isSearching = false
            
            searchBar.setShowsCancelButton(false, animated: true)
            searchBar.endEditing(true)
            searchBar.setCenteredPlaceholder()
            
            searchButtonPressed(text)
        }
    }
}
