# DntlBoldify

[![CI Status](https://img.shields.io/travis/Budaiev/DntlBoldify.svg?style=flat)](https://travis-ci.org/Budaiev/DntlBoldify)
[![Version](https://img.shields.io/cocoapods/v/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)
[![License](https://img.shields.io/cocoapods/l/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)
[![Platform](https://img.shields.io/cocoapods/p/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)


Purpose
--------------
Category for NSAttributesString.
Usefull for cases when you have a different attributes for text.
Specify needed attributes via tagging text in the single localized key.

Motivation
--------------
Whole paragraphs of attributed text handled easily, even for multiple targets in the project.
No need to gather separated NSAttributedString strings into the NSMutableAttributedString.

## Installation

DntlBoldify is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DntlBoldify'
```

## Example

![Preview](preview.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Methods
---------------------------

AttributesTheme * theme = AttributesTheme.defaultTheme;

NSAttributedString * aText =
[[NSAttributedString alloc] initWithString:NSLocalizedString(@"1 paragraph text", @"1 part")];

NSAttributedString *aaText =
[aText transformWithMultipleTags: @[@"html-like-tag1",@"html-like-tag2",@"html-like-tag3",@"html-like-tag4"]
primaryAttributes: theme.primary
tagAttributes: @[theme.bold, theme.italic, theme.underlined, theme.highlighted]];


## Created

DntlBoldify helper is created at Design and Test lab company [DNTL](https://www.dnt-lab.com).

Idea, mentor: Krasylnikov, krasylnikov@dnt-lab.com

Developer: Budaiev, budaiev@dnt-lab.com

## License

DntlBoldify is available under the MIT license. See the LICENSE file for more info.
