# AlertToast-SwiftUI


   
<p align="center">
   <img src="https://github.com/elai950/AlertToast/blob/master/Assets/animation.gif" width="250"/>
   <img src="https://github.com/elai950/AlertToast/blob/master/Assets/AlertToastSignInDemo.gif" width="250"/>
</p>

<p align="center">
<!--        <img src="https://github.com/elai950/AlertToast/blob/master/Assets/regular.gif" width="150"/> -->
    <img src="https://github.com/elai950/AlertToast/blob/master/Assets/complete.gif" width="150"/>
    <img src="https://github.com/elai950/AlertToast/blob/master/Assets/error.gif" width="150"/>
    <img src="https://github.com/elai950/AlertToast/blob/master/Assets/systemImage.gif" width="150"/>
</p>


## 🔭 Overview
**Popup like Apple Music & Feedback in AppStore**.

<img src="https://img.shields.io/badge/BUILD-PASSING-green?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/PLATFORM-IOS%20|%20MACOS-lightgray?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/LICENSE-MIT-lightgray?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/MADE WITH-SWIFTUI-blue?style=for-the-badge" />

* Built with pure SwiftUI.
* `Complete`, `Error` `SystemImage`, `Image`, `Loading`, and `Regular` (Only Text).
* Supports Light & Dark Mode.
* Works with any kind of view builder.
* Localization support.
* Supports font customization.

I tried to recreate Apple's alerts appearance and behavior as much as possible to be suitable for SwiftUI.
You can find these alerts in the AppStore after feedback and after you add a song to your library in Apple Music.

If you like the project, don't forget to `put star ★`.

<a href="mailto:elai950@gmail.com"><img src="https://img.shields.io/badge/EMAIL-ELAI-informational?style=for-the-badge&logo=minutemailer&logoColor=white"></a>&nbsp;&nbsp;&nbsp;<a href="https://www.linkedin.com/in/elai-zuberman-8120a073/" target="_blank"><img src="https://img.shields.io/badge/LINKEDIN-informational?style=for-the-badge&logo=linkedin&logoColor=white" ></a>&nbsp;&nbsp;&nbsp;<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=5JN5PT55NAHKU" target="_blank"><img src="https://img.shields.io/badge/Donate-informational?style=for-the-badge&logo=paypal&logoColor=white" ></a>

## 💻 Installation

### Cocoapods

[AlertToast Cocapods Website](https://cocoapods.org/pods/AlertToast)

CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate `AlertToast` into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
platform :ios, '13.0'
use_frameworks!

pod 'AlertToast'
```
Don't forget to add `import AlertToast` on every `swift` file you would like to use `AlertToast`.

------

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `AlertToast` into your Xcode project using Xcode 12, specify it in `File > Swift Packages > Add Package Dependency...`:

```ogdl
https://github.com/elai950/AlertToast.git
```

------

### Manually

If you prefer not to use any of dependency managers, you can integrate `AlertToast` into your project manually. Put `Sources/AlertToast` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## 🧳 Requirements

- iOS 13.0+ | macOS 11+
- Xcode 12.0+ | Swift 5+

## 🛠 Usage

The usage is very simple. Use the `.presentAlert` view modifier that expects returning `AlertToast`.

After 2 seconds the alert will be dismissed or by tapping on the alert view.

- Assign a state variable to `isPresenting` parameter.
- Default duration is 2. Set 0 to disable auto dismiss.
- Set `tapToDismiss` to `false` to disable dismiss by tap.
- Return `AlertToast` and fulfill the parameters you want.

#### Usage example with regular alert

```swift 
import AlertToast
import SwiftUI

struct ContentView: View{

    @State private var showAlert = false

    var body: some View{
        VStack{

            Button("Show Alert"){
                 showAlert.toggle()
            }
        }
        .presentAlert(isPresenting: $showAlert){
            AlertToast(type: .regular, title: "Message Sent!")
        }
    }
}
```

#### Complete Modifier Example

```swift
.presentAlert(isPresenting: $showAlert, duration: 2, tapToDismiss: true, alert: {
   
   //AlertToast Goes Here
   
}, completion: { dismissed in
   //Completion block after dismiss (returns true)
})
```

### Parameters

#### Available Alert Types:
- **Regular:** text only (Title and Subtitle).
- **Complete:** animated checkmark.
- **Error:** animated xmark.
- **System Image:** name image from `SFSymbols`.
- **Image:** name image from Assets.
- **Loading:** Activity Indicator (Spinner).

#### Alert dialog view modifier (with default settings):
```swift
.presentAlert(isPresenting: Binding<Bool>, duration: Double = 2, tapToDismiss: true, alert: { () -> AlertToast }, completion: { (Bool) -> () })
```

#### A full AlertToast implementation:
```swift
AlertToast(type: AlertType, title: Optional(String), subTitle: Optional(String), titleFont: Optional(Font), subTitleFont: Optional(Font), boldTitle: Optional(Bool))
```

#### Simple Text Alert:
```swift
AlertToast(type: .regular, title: Optional(String), subTitle: Optional(String))
```

#### Complete/Error Alert:
```swift
AlertToast(type: .complete(Color)/.error(Color), title: Optional(String), subTitle: Optional(String))
```

#### System Image Alert:
```swift
AlertToast(type: .systemImage(String, Color), title: Optional(String), subTitle: Optional(String))
```

#### Image Alert:
```swift
AlertToast(type: .image(String), title: Optional(String), subTitle: Optional(String))
```

#### Loading Alert:
```swift
AlertToast(type: .loading, title: Optional(String), subTitle: Optional(String))
```

You can add many `.presentAlert` on a single view.

## 📖 Article

I wrote an article that contains more usage exmaples.

[Medium - Presenting Apple's Music Alerts in SwiftUI](https://elaizuberman.medium.com/presenting-apples-music-alerts-in-swiftui-7f5c32cebed6)

## 👨‍💻 Contributing

All issue reports, feature requests, pull requests and GitHub stars are welcomed and much appreciated.

## ✍️ Author

Elai Zuberman

## 📃 License

`AlertToast` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
