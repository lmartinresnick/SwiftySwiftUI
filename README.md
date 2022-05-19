# SwiftySwiftUI

A Swift package for common SwiftUI components and helper methods. 

## Requirements 

- iOS 13, macOS 10.15, tvOS 13, or watchOS 6 
- Swift 5.5+
- Xcode 13.0+

## Installation

Install SwiftySwiftUI via [Swift Package Manager](https://swift.org/package-manager/).

1. In Xcode, open your project and navigate to **File** → **Swift Packages** → **Add Package Dependency...**
2. Paste the repository URL `https://github.com/lmartinresnick/SwiftySwiftUI` and click **Next**.
3. For **Rules**, select **Branch**, with branch set to `main`.
4. Click **Finish**.

## Usage

#### NavigationView Wrapper

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

#### AnyView Wrapper

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
        AnyView(self)
    }
}
```

#### 1:1 Ratio Frame

- Set `frame` with the same `width` and `height`

```swift
Circle()
    .frame(50)
```

```swift
extension View {
    func frame(_ dimensions) -> some View {
        self
            .frame(width: dimensions, height: dimensions)
    }
}
```

#### if View Modifier

- Use an `if` condition to show/hide a view modifier

```swift
@State private var usernameIsAvailable: Bool = false
var body: some View {
    Button("Check username") {
        // API call to check if username is available
    }
    .padding()
    .if(usernameIsAvailable) { view in
        view.background(Color.green)
    }
}
```

```swift
extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
```

#### Hidden View Modifier

- Use a `boolean` to show/hide a `View`

```swift
Text("Error message!")
    .isHidden(false)
        
Text("Error message!")
    .isHidden(true)
```

```swift
extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
```

