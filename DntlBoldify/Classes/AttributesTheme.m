//
//  AttributesTheme.m
//  ConceptAttributedStringHelper
//
//  Created by Aleksandr Bydaiev on 3/12/19.
//  Copyright © 2019 test.name. All rights reserved.
//

#import "AttributesTheme.h"

@implementation AttributesTheme

+ (AttributesTheme *)defaultTheme {
    
    return [[AttributesTheme alloc] initDefaultTheme];
}

//=============================================================================

+ (AttributesTheme *)boldThemeWithPrimary:(NSDictionary *)primary
                                     bold:(NSDictionary *)bold {
    
    return [AttributesTheme.alloc initDefaultThemeWithPrimary:primary
                                                         bold:bold
                                                       italic:nil
                                                   underlined:nil
                                                  highlighted:nil];
}

+ (AttributesTheme *)customThemeWithPrimary:(NSDictionary *)primary
                                       bold:(NSDictionary *)bold
                                     italic:(NSDictionary *)italic {
    
    return [AttributesTheme.alloc initDefaultThemeWithPrimary:primary
                                                         bold:bold
                                                       italic:italic
                                                   underlined:nil
                                                  highlighted:nil];
}

+ (AttributesTheme *)customThemeWithPrimary:(NSDictionary *)primary
                                       bold:(NSDictionary *)bold
                                     italic:(NSDictionary *)italic
                                 underlined:(NSDictionary *)underlined
                                highlighted:(NSDictionary *)highlighted {
    
    return [AttributesTheme.alloc initDefaultThemeWithPrimary:primary
                                                         bold:bold
                                                       italic:italic
                                                   underlined:underlined
                                                  highlighted:highlighted];
}

//=============================================================================

- (instancetype)initDefaultThemeWithPrimary:(NSDictionary *)primary
                                       bold:(NSDictionary *)bold
                                     italic:(NSDictionary *)italic
                                 underlined:(NSDictionary *)underlined
                                highlighted:(NSDictionary *)highlighted {
    self = [super init];
    
    _primary = primary;
    _bold = bold;
    _italic = italic;
    _underlined = underlined;
    _highlighted = highlighted;
    
    return self;
}

//=============================================================================

- (instancetype)initDefaultTheme {
    self = [super init];
    _primary = @{
                 NSFontAttributeName:[UIFont fontWithName:@"GillSans" size:15],
                 };
    
    
    _bold = @{
              NSFontAttributeName:[UIFont fontWithName:@"GillSans-BoldItalic" size:15],
              };
    
    _italic = @{
                NSFontAttributeName:[UIFont fontWithName:@"GillSans-Italic" size:16],
                };
    
    
    _underlined = @{
                     NSFontAttributeName:[UIFont fontWithName:@"GillSans" size:16],
                     NSUnderlineStyleAttributeName : @(1)
                     };
    
    _highlighted = @{
                     NSFontAttributeName:[UIFont fontWithName:@"GillSans" size:15],
                     NSBackgroundColorAttributeName : UIColor.yellowColor
                     };
    
    return self;
    
}

@end
