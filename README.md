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

-`.embedInNavigationView()`
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

#### AnyView Wrapper

-  `.eraseToAnyView()`
- Instantly "erase" your `View` to `AnyView`

```swift
VStack {
    Text("Erase to AnyView")
}
.eraseToAnyView()
```

#### 1:1 Ratio Frame

-  `.frame(_:)`
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

- `.if(_:transform:)`
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

#### Hidden View Modifier

- `.isHidden(_:remove:)`
- Use a `boolean` to show/hide a `View`

```swift
Text("Error message!")
    .isHidden(true)
        
Text("Error message!")
    .isHidden(false)
```

#### Loading View Modifier

- `.loadingStyle(state:loadingContent:)`
- Use a `@State` property to display a loading view

```swift
@State private var isFetchingAPI: Bool = true
var body: some View {
    AsyncImage(url: viewModel.url)
        .loadingStyle(state: isFetchingAPI) {
            CustomLoadingView()
        }
}

```

#### BottomSheet

- `.bottomSheet(isPresented:showBottomSheet:content:)`
- Customizable modal presented from the bottom of the screen
- Interacts the same way as `.sheet`, i.e. use a `@State` boolean to show `BottomSheet`

```swift
@State private var showBottomSheet: Bool = false
var body: some View {
    VStack {
        Text("Let's show a bottom sheet")
        Button("Tap me to show a bottom sheet") {
            showBottomSheet.toggle()
        }
    }
    .bottomSheet(isPresented: showBottomSheet, height: .half) {
        CustomBottomSheetView()
    }
}
```



