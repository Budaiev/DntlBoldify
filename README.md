# DntlBoldify

[![CI Status](https://img.shields.io/travis/Budaiev/DntlBoldify.svg?style=flat)](https://travis-ci.org/Budaiev/DntlBoldify)
[![Version](https://img.shields.io/cocoapods/v/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)
[![License](https://img.shields.io/cocoapods/l/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)
[![Platform](https://img.shields.io/cocoapods/p/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

AttributesTheme * theme = AttributesTheme.defaultTheme;

NSAttributedString * aText =
[[NSAttributedString alloc] initWithString:NSLocalizedString(@"1 paragraph", @"some text")];

NSAttributedString *aaText =
[aText transformWithMultipleTags: @[@"<b>",@"<i>",@"<u>",@"<g>"]
primaryAttributes: theme.primary
tagAttributes: @[theme.bold, theme.italic, theme.underlined, theme.highlighted]];

## Requirements

## Installation
Category for NSAttributesString. Apply needed attributes for tagged text.
Usefull for cases when you have different attributes for Localizable.strings.
Convenient to work with same texts for other targets in the project.

DntlBoldify is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DntlBoldify'
```

## Author

Budaiev, budaiev@dnt-lab.com

## License

DntlBoldify is available under the MIT license. See the LICENSE file for more info.
