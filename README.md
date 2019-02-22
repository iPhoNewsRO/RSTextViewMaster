# RSTextViewMaster
[![Version](https://img.shields.io/cocoapods/v/TextViewMaster.svg?style=flat)](https://github.com/iPhoNewsRO/RSTextViewMaster)
[![License: MIT](https://img.shields.io/badge/license-GNU-blue.svg?style=flat)](https://github.com/iPhoNewsRO/RSTextViewMaster/blob/master/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/TextViewMaster.svg?style=flat)](https://github.com/iPhoNewsRO/RSTextViewMaster)
[![Swift 4.2](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](https://github.com/iPhoNewsRO/RSTextViewMaster)
## Intro
<img width="300" alt="image" src="https://github.com/iPhoNewsRO/RSTextViewMaster/blob/master/intro.gif">

📱Easy custom placeholder and growing (iMessage-like) UITextView with customisation 

You can easily adjust the color, font, and position of the placeholder.
The height of the textview automatically changes every time you increase or decrease the line in the textview.
You can specify a maxHeight property so the textview can start to scroll.

## Requirements
* iOS 9.0 or newer
* Swift 4.2


## Installation
### Cocoapods

RSTextViewMaster is available through [CocoaPods](http://cocoapods.org).

```ruby
pod 'RSTextViewMaster'
```

## Usage

```ruby
import RSTextViewMaster
```
### Customization
```ruby
    isAnimate: Bool = true                                          
    maxLength: Int = 0                                              
    minHeight: CGFloat = 0                                          
    maxHeight: CGFloat = 0                                          

    placeHolder: String = ""                                        
    placeHolderFont: UIFont = UIFont.systemFont(ofSize: 17)         
    placeHolderColor: UIColor = UIColor(white: 0.8, alpha: 1.0)     
    placeHolderTopPadding: CGFloat = 0                              
    placeHolderBottomPadding: CGFloat = 0                           
    placeHolderRightPadding: CGFloat = 5                            
    placeHolderLeftPadding: CGFloat = 5                             
```
### Programmatically
```ruby
let textViewMaster = RSTextViewMaster()
textViewMaster.delegate = self       
inputView.addSubview(textViewMaster)
```

You will have to set constrains by code if you take this approach.
        
### Storyboard
1. TextView Set class to "RSTextViewMaster".
2. Set delegate to it's view controller
3. Set a height constraint but check "remove at runtime". This way Xcode won't bother you and the textview will work like magic

Check the demo for an example.

### Delegate
RSTextViewMaster inherits from UITextViewDelegate.
You can also use UITextViewDelegate by default.
Added or modified functions
```ruby
func growingTextView(growingTextView: RSTextViewMaster, shouldChangeTextInRange range:NSRange, replacementText text:String) -> Bool
func growingTextViewShouldReturn(growingTextView: RSTextViewMaster) 
func growingTextView(growingTextView: RSTextViewMaster, willChangeHeight height:CGFloat)
func growingTextView(growingTextView: RSTextViewMaster, didChangeHeight height:CGFloat)
```

## Author
[Radu Ursache](https://github.com/iPhoNewsRO)

## License
RSTextViewMaster is available under the GNU license.
