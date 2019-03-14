# DntlBoldify

[![CI Status](https://img.shields.io/travis/Budaiev/DntlBoldify.svg?style=flat)](https://travis-ci.org/Budaiev/DntlBoldify)
[![Version](https://img.shields.io/cocoapods/v/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)
[![License](https://img.shields.io/cocoapods/l/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)
[![Platform](https://img.shields.io/cocoapods/p/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)


Purpose
--------------
Category for NSAttributesString. Apply needed attributes for tagged text.
Usefull for cases when you have different attributes for Localizable.strings.
Convenient to work with same texts for other targets in the project.

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
[aText transformWithMultipleTags: @[@"<qw>",@"<we>",@"<rt>"]
primaryAttributes: theme.primary
tagAttributes: @[theme.bold, theme.italic, theme.underlined, theme.highlighted]];


## Created

DntlBoldify helper is created at Design and Test lab company [DNTL](https://www.dnt-lab.com).

Idea, mentoring: Krasylnikov, krasylnikov@dnt-lab.com 
Developer: Budaiev, budaiev@dnt-lab.com

## License

DntlBoldify is available under the MIT license. See the LICENSE file for more info.
