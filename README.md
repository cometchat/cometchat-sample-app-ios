
<div style="width:100%">
    <div style="width:50%; display:inline-block">
        <p align="center">
        <img align="center" width="180" height="180" alt="" src="https://github.com/cometchat-pro/ios-swift-chat-app/blob/master/Screenshots/logo.png">    
        </p>    
    </div>    
</div>
</div>

</br>

# iOS Swift Chat App

<p align="left">

<a href=""><img src="https://img.shields.io/badge/Repo%20Size-13.6%20MB-brightgreen" /></a>
<a href=""> <img src="https://img.shields.io/badge/Contributors-5-yellowgreen" /></a>
<a href=" "> <img src="https://img.shields.io/badge/Version-3.0.914--pluto.beta.2.1-red" /></a>
<a href=""> <img src="https://img.shields.io/github/stars/cometchat-pro/ios-swift-chat-app?style=social" /></a>
<a href=""> <img src="https://img.shields.io/twitter/follow/cometchat?style=social" /></a>

</p>
</br></br>

<div>
<img align="left" src="https://github.com/cometchat-pro-samples/ios-swift-chat-app/blob/v2/Screenshots/appScreenshot.jpg">  </div>

<br></br><br></br>

CometChat Kitchen Sink Sample App (built using **CometChat UIKit**) is a fully functional messaging app capable of **one-on-one** (private) and **group** messaging as well as Calling. This sample app enables users to send **text** and **multimedia messages like  images, videos, documents**. Also, users can make  **Audio** and **Video** calls to other users or groups.

___

## Prerequisites :star:

Before you begin, ensure you have met the following requirements:

✅ &nbsp; macOS

✅ &nbsp; Xcode

✅ &nbsp; iOS 13.0 and later

✅ &nbsp; Swift 4.0+

___

## Installing iOS Swift Chat App
      
1. Simply clone the project from [ios-swift-chat-app](https://github.com/cometchat-pro-samples/ios-chat-ui-kit-app/archive/master.zip) repository. 
___

## Running the sample app

To Run to sample app you have to do the following changes by Adding **AppID**, **AuthKey** and  **Region**.
   
   You can obtain your  *App ID*, *Auth Key* and *Region* from [CometChat-Pro Dashboard](https://app.cometchat.io/). Create new app and head over to the Quick Start or API & Auth Keys section and note the `App ID`, `Auth Key`,  and  `Region`.
          
   - Open the project in Xcode. 
          
   - Go to CometChatSwift -->  **AppConstants.swift**.
                  
   - Modify *App ID* and *Auth Key*  and *Region* with your own **App ID**, **Auth Key** and **Region**.

   -  Select demo users or enter the **UID** at the time of login once the app is launched. 

![Studio Guide](https://github.com/cometchat-pro-samples/ios-swift-chat-app/blob/v2/Screenshots/Auth.png)    

---

## Add UI Kit to your project

## 1. Setup  :wrench:

To install iOS Chat UIKit, you  need to first register on CometChat Dashboard. [Click here to sign up](https://app.cometchat.com/login).

### i. Get your Application Keys :key:

* Create a new app
* Head over to the Quick Start or API & Auth Keys section and note the `App ID`, `Auth Key`,  and  `Region`.
---

### ii. You can install UIKit for iOS through Swift Package Manager.

* Go to your Swift Package Manager's File tab and select Add Packages.

* Add CometChatProUIKit into your Package Repository as below:
  * https://github.com/cometchat-pro/ios-swift-chat-ui-kit.git
  
* To add the package, select Version Rules, enter Up to Exact Version, [3.0.914-pluto.beta.2.1](https://github.com/cometchat-pro/ios-swift-chat-ui-kit/tree/pluto), and click Next

___

## 2. Calling Functionality

If you want calling functionality inside your application then you need to install calling SDK additionally inside your project. You can install CometChatProCalls Calling SDK for iOS through Swift Package Manager.

* Go to your Swift Package Manager's File tab and select Add Packages

* Add CometChatProCalls into your Package Repository as below:

  * https://github.com/cometchat-pro/ios-calls-sdk.git

* To add the package, select Version Rules, enter Up to Exact Version, 3.0.0, and click Next.

___

## 3. Configure CometChat inside your app

### i. Initialize CometChat :star2:

The `init()` method initializes the settings required for CometChat. We suggest calling the `init()` method on app startup, preferably in the `didFinishLaunchingWithOptions()` method of the Application class.

```swift
import CometChatPro

class AppDelegate: UIResponder, UIApplicationDelegate{

   var window: UIWindow?
   let appId: String = "ENTER APP ID"
   let region: String = "ENTER REGION CODE"
    
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

  let mySettings = AppSettings.AppSettingsBuilder().subscribePresenceForAllUsers().setRegion(region: region).build()
  CometChat(appId: appId ,appSettings: mySettings,onSuccess: { (isSuccess) in
  
                print("CometChat Pro SDK intialise successfully.")

        }) { (error) in
            print("CometChat Pro SDK failed intialise with error: \(error.errorDescription)")
        }
        return true
    }
}
```
**Note :**
Make sure you replace the APP_ID with your CometChat `appId` and `region` with your app region in the above code.

___

# Troubleshooting

- To read the full dcoumentation on UI Kit integration visit our [Documentation](https://prodocs.cometchat.com/docs/ios-ui-kit)  .

- Facing any issues while integrating or installing the UI Kit please <a href="https://app.cometchat.io/"> connect with us via real time support present in CometChat Dashboard.</a>

---

# Contributors

Thanks to the following people who have contributed to this project:

[@pushpsenairekar2911 👨‍💻](https://github.com/pushpsenairekar2911) <br>
[@ghanshyammansata 👨‍💻](https://github.com/ghanshyammansata)
<br>
[@jeetkapadia 👨‍💻](https://github.com/jeetkapadia)
<br>
[@NishantTiwarins 👨‍💻](https://github.com/NishantTiwarins)
<br>
[@darshanbhanushali 📝](https://github.com/darshanbhanushali)

---

# Contact

Contact us via real time support present in [CometChat Dashboard.](https://app.cometchat.io/)

---

# License

---

This project uses the following [license](https://github.com/cometchat-pro/ios-swift-chat-app/blob/master/License.md).
