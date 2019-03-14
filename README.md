# DntlBoldify

[![CI Status](https://img.shields.io/travis/Budaiev/DntlBoldify.svg?style=flat)](https://travis-ci.org/Budaiev/DntlBoldify)
[![Version](https://img.shields.io/cocoapods/v/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)
[![License](https://img.shields.io/cocoapods/l/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)
[![Platform](https://img.shields.io/cocoapods/p/DntlBoldify.svg?style=flat)](https://cocoapods.org/pods/DntlBoldify)


## Installation
DntlBoldify is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DntlBoldify'
```

## About
NSAttributedString category.
Most usefull for cases when you have a different attributes for your text.

## Demo

![Preview](preview.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Motivation
Whole paragraphs of attributed text handled easily, even for multiple targets in the project.
No routine to generate NSAttributedString one-by-one in the NSMutableAttributedString.

## Decision
Specify needed attributes via tagging.
The right place  for this - Localized.strings, even long and complex attributed texts just handled by the single localized key.

## Created by

DntlBoldify is created with love at the [Design and Test Lab](https://www.dnt-lab.com) company.

Idea, mentor: Krasylnikov Dmytriy, krasylnikov@dnt-lab.com.

Developer: Budaiev Aleksandr, budaiev@dnt-lab.com.

## License
DntlBoldify is available under the MIT license. See the LICENSE file for more info.
