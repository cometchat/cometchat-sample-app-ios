
# Localization

Localization is the process of making your app adapt to different languages, regions, and cultures. Because a single language can be used in different parts of the world and your app should adapt to the regional and cultural conventions of where a person resides. you make your app with English user interface first and then localize the app to other languages such as Japanese. 

## Base Internationalization

* Before starting localization work, make sure you have “Use Base Internationalization” checkmark selected.

* When you create new XCode project, XCode will automatically generate resources and the file structure including them for the default language.

<img align="left" src="https://github.com/cometchat-pro-samples/ios-swift-chat-app/blob/master/Screenshots/1.png">
		

## Adding New Language
Add new language support using, click “+” button under Localizations section in Project Info tab. Then choose a language you want to support.

<img align="left" src="https://github.com/cometchat-pro-samples/ios-swift-chat-app/blob/master/Screenshots/2.png">	

##Separating Text From Code
iOS uses files with the .strings file extension to store all of the localized strings used within the app, one or more for each supported language. A simple function call will retrieve the requested string based on the current language in use on the device.

Choose **File --> New --> File** from the menu. In the resulting dialog, select **iOS --> Resource --> Strings** File and click Next.

<div style="width:100%">
	<div style="width:50%; display:inline-block">
		<p align="center">
		<img align="center" alt="" src="https://github.com/cometchat-pro-samples/ios-swift-chat-app/blob/master/Screenshots/3.png">	
		</p>	
	</div>	
</div>

Name the file **Localizable** and click Create.
The last step is to click Localize on the right panel:

<div style="width:100%">
	<div style="width:50%; display:inline-block">
		<p align="center">
		<img align="center"  alt="" src="https://github.com/cometchat-pro-samples/ios-swift-chat-app/blob/master/Screenshots/4.png">	
		</p>	
	</div>	
</div>

Now, check all languages you have configured in the Project Settings:

<div style="width:100%">
	<div style="width:50%; display:inline-block">
		<p align="center">
		<img align="center" alt="" src="https://github.com/cometchat-pro-samples/ios-swift-chat-app/blob/master/Screenshots/5.png">	
		</p>	
	</div>	
</div>

And open Localizable.strings in Hindi, then change the “hello” text to “ नमस्ते”:

<div style="width:100%">
	<div style="width:50%; display:inline-block">
		<p align="center">
		<img align="center" alt="" src="https://github.com/cometchat-pro-samples/ios-swift-chat-app/blob/master/Screenshots/6.png">	
		</p>	
	</div>	
</div>

In your view controller, 
```
 self.label.text =  NSLocalizedString("hello", comment: "")
```
## testing

It works some to switch your phone language every time you check localization results. XCode has a nice feature to switch languages only within the app when you run the app on iOS Simulator.

To do so, select **Edit Scheme** from the dropdown on the upper left corner of the XCode window, and change Application Language from System Language to Japanese (Refer the below screenshot if you got lost).
This configuration doesn’t change the phone language of the simulator, but only changes the language environment within the app to the specified language. This is convenient when you add a few languages and want to switch between languages to check your localization result.

<div style="width:100%">
	<div style="width:50%; display:inline-block">
		<p align="center">
		<img align="center"  alt="" src="https://github.com/cometchat-pro-samples/ios-swift-chat-app/blob/master/Screenshots/7.png">	
		</p>	
	</div>	
</div>

## Results

<div style="width:100%">
	<div style="width:50%; display:inline-block">
		<p align="center">
		<img align="center"  alt="" src="https://github.com/cometchat-pro-samples/ios-swift-chat-app/blob/master/Screenshots/8.png">	
		</p>	
	</div>	
</div>

