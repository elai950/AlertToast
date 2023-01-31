# AlertToast-SwiftUI [![Tweet](https://img.shields.io/twitter/url/http/shields.io.svg?style=social)](https://twitter.com/intent/tweet?text=Get%20over%20170%20free%20design%20blocks%20based%20on%20Bootstrap%204&url=https://froala.com/design-blocks&via=froala&hashtags=bootstrap,design,templates,blocks,developers)
### Present Apple-like alert & toast in SwiftUI

<p align="center">
   <img src="https://github.com/elai950/AlertToast/blob/master/Assets/GithubCoverNew.png" width="480"/>
</p>

## 🌄 Example

<p align="center">
    <img src="https://github.com/elai950/AlertToast/blob/master/Assets/onboarding.png" style="display: block; margin: auto;"/>
</p>

<p align="center">
    <img src="https://github.com/elai950/AlertToast/blob/master/Assets/ToastExample.gif" style="display: block; margin: auto;" width="180"/>
</p>

## 🔭 Overview

Currently in SwiftUI, the only way to inform the user about some process that finished for example, is by using `Alert`. Sometimes, you just want to pop a message that tells the user that something completed, or his message was sent. Apple doesn't provide any other method rather than using `Alert` even though Apple using all kinds of different pop-ups. The results are poor UX where the user would need to tap "OK/Dismiss" for every little information that he should be notified about.

Alert Toast is an open-source library in Github to use with SwiftUI. It allows you to present popups that don't need any user action to dismiss or to validate. Some great usage examples: `Message Sent`, `Poor Network Connection`, `Profile Updated`, `Logged In/Out`, `Favorited`, `Loading` and so on...

<img src="https://img.shields.io/badge/BUILD-1.3.8-green?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/PLATFORM-IOS%20|%20MACOS-lightgray?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/LICENSE-MIT-lightgray?style=for-the-badge" />&nbsp;&nbsp;&nbsp;<img src="https://img.shields.io/badge/MADE WITH-SWIFTUI-orange?style=for-the-badge" />

* Built with pure SwiftUI.
* 3 Display modes: `Alert` (pop at the center), `HUD` (drop from the top) and `Banner` (pop/slide from the bottom).
* `Complete`, `Error` `SystemImage`, `Image`, `Loading`, and `Regular` (Only Text).
* Supports Light & Dark Mode.
* Works with **any** kind of view builder.
* Localization support.
* Font & Background customization.

#### If you like the project, don't forget to `put star 🌟`.

<a href="mailto:elai950@gmail.com"><img src="https://img.shields.io/badge/EMAIL-ELAI-informational?style=for-the-badge&logo=minutemailer&logoColor=white"></a>&nbsp;&nbsp;&nbsp;<a href="https://www.linkedin.com/in/elai-zuberman-8120a073/" target="_blank"><img src="https://img.shields.io/badge/LINKEDIN-informational?style=for-the-badge&logo=linkedin&logoColor=white" ></a>&nbsp;&nbsp;&nbsp;<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=5JN5PT55NAHKU" target="_blank"><img src="https://img.shields.io/badge/Donate-informational?style=for-the-badge&logo=paypal&logoColor=white" ></a>

₿ Bitcoin donation address:
```
0xec48bfa813a773fa2394aec23f97da5cb4d5ff02
```
- Send only BTC to this deposit address.
- Ensure the network is BNB Smart Chain (BEP20).

## Navigation

- [Installation](#-installation)
    - [CocoaPods](#cocoapods)
    - [Swift Package Manager](#swift-package-manager)
    - [Manually](#manually)
- [Usage](#-usage)
    - [Usage example with regular alert](#usage-example-with-regular-alert)
    - [Complete Modifier Example](#complete-modifier-example)
    - [Alert Toast Parameters](#alert-toast-parameters)
 - [Article](#-article)
 - [Contributing](#-contributing)
 - [Author](#-author)
 - [License](#-license)

## 💻 Installation

### Cocoapods

[AlertToast Cocapods Website](https://cocoapods.org/pods/AlertToast)

CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate `AlertToast` into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
pod 'AlertToast'
```

------

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate `AlertToast` into your Xcode project using Xcode 12, specify it in `File > Swift Packages > Add Package Dependency...`:

```ogdl
https://github.com/elai950/AlertToast.git, :branch="master"
```

For Xcode 13, please refer [this article](https://iiroalhonen.medium.com/adding-a-swift-package-dependency-in-xcode-13-937b2caaf218) to install `AlertToast` 

------

### Manually

If you prefer not to use any of dependency managers, you can integrate `AlertToast` into your project manually. Put `Sources/AlertToast` folder in your Xcode project. Make sure to enable `Copy items if needed` and `Create groups`.

## 🧳 Requirements

- iOS 13.0+ | macOS 11+
- Xcode 12.0+ | Swift 5+

## 🛠 Usage

First, add `import AlertToast` on every `swift` file you would like to use `AlertToast`.

Then, use the `.toast` view modifier:

**Parameters:**

- `isPresenting`: (MUST) assign a `Binding<Bool>` to show or dismiss alert.
- `duration`: default is 2, set 0 to disable auto dismiss.
- `tapToDismiss`: default is `true`, set `false` to disable.
- `alert`: (MUST) expects `AlertToast`.

#### Usage example with regular alert

```swift 
import AlertToast
import SwiftUI

struct ContentView: View{

    @State private var showToast = false

    var body: some View{
        VStack{

            Button("Show Toast"){
                 showToast.toggle()
            }
        }
        .toast(isPresenting: $showToast){

            // `.alert` is the default displayMode
            AlertToast(type: .regular, title: "Message Sent!")
            
            //Choose .hud to toast alert from the top of the screen
            //AlertToast(displayMode: .hud, type: .regular, title: "Message Sent!")
            
            //Choose .banner to slide/pop alert from the bottom of the screen
            //AlertToast(displayMode: .banner(.slide), type: .regular, title: "Message Sent!")
        }
    }
}
```

#### Complete Modifier Example

```swift
.toast(isPresenting: $showAlert, duration: 2, tapToDismiss: true, alert: {
   //AlertToast goes here
}, onTap: {
   //onTap would call either if `tapToDismis` is true/false
   //If tapToDismiss is true, onTap would call and then dismis the alert
}, completion: {
   //Completion block after dismiss
})
```

### Alert Toast Parameters

```swift
AlertToast(displayMode: DisplayMode,
           type: AlertType,
           title: Optional(String),
           subTitle: Optional(String),
           style: Optional(AlertStyle))
           
//This is the available customizations parameters:
AlertStyle(backgroundColor: Color?,
            titleColor: Color?,
            subTitleColor: Color?,
            titleFont: Font?,
            subTitleFont: Font?)
```

#### Available Alert Types:
- **Regular:** text only (Title and Subtitle).
- **Complete:** animated checkmark.
- **Error:** animated xmark.
- **System Image:** name image from `SFSymbols`.
- **Image:** name image from Assets.
- **Loading:** Activity Indicator (Spinner).

#### Alert dialog view modifier (with default settings):
```swift
.toast(isPresenting: Binding<Bool>, duration: Double = 2, tapToDismiss: true, alert: () -> AlertToast , onTap: () -> (), completion: () -> () )
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
//When using loading, duration won't auto dismiss and tapToDismiss is set to false
AlertToast(type: .loading, title: Optional(String), subTitle: Optional(String))
```

You can add many `.toast` on a single view.

## 📖 Article

I wrote an article that contains more usage examples.

[Medium - How to toast an alert in SwiftUI](https://elaizuberman.medium.com/presenting-apples-music-alerts-in-swiftui-7f5c32cebed6)

## 👨‍💻 Contributors

All issue reports, feature requests, pull requests and GitHub stars are welcomed and much appreciated.

- [@barnard-b](https://github.com/barnard-b)

## ✍️ Author

Elai Zuberman

## 📃 License

`AlertToast` is available under the MIT license. See the [LICENSE](https://github.com/elai950/AlertToast/blob/master/LICENSE.md) file for more info.

---

- [Jump Up](#-overview)
