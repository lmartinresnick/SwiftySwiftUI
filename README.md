# SwiftySwiftUI

A Swift package for common SwiftUI components and helper methods. 

## Requirements 

- iOS 13, macOS 10.15, tvOS 13, or watchOS 6 
- Swift 5.5+
- Xcode 13.0+

## Installation

The preferred way of installing SwiftySwiftUI is via the [Swift Package Manager](https://swift.org/package-manager/).

>Xcode 11 integrates with libSwiftPM to provide support for iOS, watchOS, macOS and tvOS platforms.

1. In Xcode, open your project and navigate to **File** → **Swift Packages** → **Add Package Dependency...**
2. Paste the repository URL `https://github.com/lmartinresnick/SwiftySwiftUI` and click **Next**.
3. For **Rules**, select **Branch**, with branch set to `main`.
4. Click **Finish**.

## Usage

### `NavigationView` Wrapper

- Instantly embed your `View` in `NavigationView`

```swift
    VStack {
        List {
            NavigationLink("Purple", destination: ColorDetail(color: .purple))
            NavigationLink("Pink", destination: ColorDetail(color: .pink))
            NavigationLink("Orange", destination: ColorDetail(color: .orange))
        }
        .navigationTitle("Colors")
    }
    .embedInNavigationView()
```

```swift
extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
```

### `AnyView` Wrapper

- Instantly "erase" your `View` to `AnyView`

```swift
    VStack {
        Text("Erase to AnyView")
    }
    .eraseToAnyView()
```

```swift
extension View {
    func eraseToAnyView() -> some View {
        AnyView()
    }
}
```


