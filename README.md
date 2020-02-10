# DSSlider

### Fully customized Double Sided Slide to Unlock Control, written on Swift under the short name - DSSlider.

![DSSlider](https://github.com/codeit-ios/DSSlider/blob/develop/dsslider.png)

- [Features](#features)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Features

- [x] Test Text

## Requirements

- iOS 10.0+
- Xcode 10.2+
- Swift 5+

## Communication
- If you'd like to **contact us** write to (codeit email)
- If you **found a bug**, open an issue here on GitHub and follow the guide. The more detail the better!
- If you **want to contribute**, submit a pull request.

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Alamofire into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'DSSlider', '~> 0.0.1'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate Alamofire into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "DSSlider/DSSlider" "0.0.1"
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but Alamofire does support its use on supported platforms.

Once you have your Swift package set up, adding Alamofire as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/DSSlider/DSSlider.git", from: "0.0.1")
]
```

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate DSSlider into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add DSSlider as a git [submodule](https://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/DSSlider/DSSlider.git
  ```

- Open the new `DSSlider` folder, and drag the `DSSlider.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `DSSlider.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `DSSlider.xcodeproj` folders each with two different versions of the `DSSlider.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `DSSlider.framework`.

- Select the top `DSSlider.framework` for iOS and the bottom one for macOS.

- And that's it!

  > The `DSSlider.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.
  
## Usage

### DSSlider

```swift
import DSSlider
```

The slider can be inserted in a view hierarchy as a subview. Appearance can be configured with a number of public attributes:

```swift
let slider = DSSlider(frame: sliderContainer.frame, delegate: self)

slider.isDoubleSideEnabled = true
slider.isImageViewRotating = true
slider.isTextChangeAnimating = true
slider.isDebugPrintEnabled = false
slider.isShowSliderText = true
slider.isEnabled = true

slider.sliderAnimationVelocity = 0.2
slider.sliderViewTopDistance = 0.0
slider.sliderImageViewTopDistance = 5
slider.sliderImageViewStartingDistance = 5
slider.sliderTextLabelLeadingDistance = 0
slider.sliderCornerRadius = sliderContainer.frame.height / 2

slider.sliderBackgroundColor = UIColor.white
slider.sliderBackgroundViewTextColor = UIColor.dsSliderRedColor
slider.sliderDraggedViewTextColor = UIColor.dsSliderRedColor
slider.sliderDraggedViewBackgroundColor = UIColor.white
slider.sliderImageViewBackgroundColor = UIColor.dsSliderRedColor

slider.sliderTextFont = UIFont.systemFont(ofSize: 15.0)

slider.sliderImageView.image = UIImage(named: "arrow-icon")
slider.sliderBackgroundViewTextLabel.text = "SLIDE TO TURN ON!"
slider.sliderDraggedViewTextLabel.text = "SLIDE TO TURN OFF!"

view.addSubview(slider)
```

Take a look at the `Example` project for an integration example.

## License

Alamofire is released under the MIT license. [See LICENSE](https://github.com/Alamofire/Alamofire/blob/master/LICENSE) for details.
