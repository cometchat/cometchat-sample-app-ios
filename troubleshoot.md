
## Facing an issue while running the app? 

# Cocoapods

1. Unable to open file (in target "CometChatPro-swift-sampleApp" in project "CometChatPro-swift-sampleApp") (in target 'CometChatPro-swift-sampleApp')

- This issue occurs somethings if the pods dosen't linked properly with project. Kindly, perform below steps to resolve the issue:
 ```
1. pod deintegrate
2. sudo gem install cocoapods-clean
3. pod clean
4. Open the project and delete the "Pods" folder that should be red.
5. pod setup
6. pod install
```


2. Unable to find a specification for `CometChatPro`

- out-of-date source repos which you can update with `pod repo update` or with `pod install --repo-update`.


# Swift Versions

## Not able to find correct version for your Xcode? Using below links you can navigate to sample apps: 

1. [Swift 5.0](https://github.com/cometchat-pro-samples/ios-swift-chat-app) 
2. [Swift 4.2](https://github.com/cometchat-pro-samples/ios-swift-chat-app-swift-4.2)
