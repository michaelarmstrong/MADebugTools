MADebugTools
============

A set of unusual categories that every iOS developer needs in his dev and testing toolkit.

So far two categories are included, the ability to display the class name of every UIViewController, useful for debugging retro-code and figuring out what class is responsible for what and a simple Javascript Console for debugging UIWebViews on the device. Very useful if you're wrapping content.


# Usage:

- Drop UIView+MADebugTools.h/m into your Project
- Build + GO!

- Or just `pod install MADebugTools`

## Optionally 

You can disable MADebugTools in your Podspec file by adding

`post_install do |installer|`  
`  installer.project.targets.each do |target|`  
`    target.build_configurations.each do |config|`  
`      s = config.build_settings['GCC_PREPROCESSOR_DEFINITIONS']`  
`      if s==nil then`  
`        s = ['$(inherited)']`  
`      end`  
`      # Disable MADebugTools UIWebView debugging.`  
`      s.push('MA_DEBUG_TOOLS_DISABLE_WEB_DEBUG=1');`  
`      # Disable MADebugTools UIViewController Debugging`  
`      s.push('MA_DEBUG_TOOLS_DISABLE_VIEW_DEBUG=1');`  
`      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = s`  
`    end`  
`  end`  

Before your end tag


###     Debug UIViewController heirarchies and UIStoryboards.
![Example of UIViewController Debugging](http://mike.kz/demoCategory.png "Usage of UIViewController Debugging")

###     Debug UIWebView on device without Web Inspector using a simple Javascript Console.
![Example of UIWebView Debugging](http://mike.kz/webviewDebug.png "Usage of UIWebView Debugging")


