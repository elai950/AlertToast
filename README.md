# AlertToast-SwiftUI

**Popup from Apple Music & Feedback in AppStore**.
Contains `Done/Complete`, `Image`, `Error` and `Message`.
* Supports Light & Dark Mode.

I tried to recreate Apple's alerts as much as possible to be suitable for SwiftUI.
You can find these alerts in the AppStore after feedback and after you add a song to your library in Apple Music.

<p float="left">
    <img src="https://user-images.githubusercontent.com/37900883/107416158-d4e58500-6b1c-11eb-8b37-9701d275e9a7.gif" width="222" />
</p>

If you like the project, don't forget to `put star ★`.

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `AlertToast` into your Xcode project using Xcode 12, specify it in `File > Swift Packages > Add Package Dependency...`:

```ogdl
https://github.com/elai950/AlertToast.git
```

### Manually

If you prefer not to use any of dependency managers, you can integrate `AlertToast` into your project manually. Put `Sources/AlertToast` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## Usage

The usage is very simple. Use the `.alertDialog` view modifier that expects returning `AlertToast`.

- Assign a state variable to `show`.
- Return `AlertToast` and fulfill the parameters: `type`, `title`, and `subTitle` (Optional).

For showing a simple alert text message:

```swift 
import AlertToast
import SwiftUI

struct ContentView: View{

    @State private var showAlert = false

    var body: some View{
        VStack{

            Button("Show Alert"){
                withAnimation(.spring()){
                    showAlert.toggle()
                }
            }
        }
        .alertDialog(show: $showAlert){
            AlertToast(type: .none, title: "Message Sent!", subTitle: nil)
        }
    }
}
```

For showing a complete/error alert message with animations:
You need to choose a `Color`.

```swift 
.alertDialog(show: $showComplete){
    AlertToast(type: .complete(.green), title: "Complete", subTitle: nil)
}
.alertDialog(show: $showError){
    AlertToast(type: .error(.red), title: "Error", subTitle: "Error code: 404")
}
```

You can add as many `.alertDialog` as you like.

For showing a image/system image alert message:

```swift
.alertDialog(show: $showSystemImage){
    AlertToast(type: .systemImage("star.fill", .yellow), title: "Favorite", subTitle: nil)
}
.alertDialog(show: $showSystemImage){
    AlertToast(type: .image("star.fill"), title: "Favorited", subTitle: nil)
}
```
