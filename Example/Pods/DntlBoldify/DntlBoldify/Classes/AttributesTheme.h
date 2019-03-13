//
//  AttributesTheme.h
//  ConceptAttributedStringHelper
//
//  Created by Aleksandr Bydaiev on 3/12/19.
//  Copyright © 2019 test.name. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 NSAttributedString decoration object.
 Mark needed attributes.
 */
@interface AttributesTheme : NSObject

/**  For common text. */
@property NSDictionary * primary;

/** Named attributes for special tags. */
@property NSDictionary * bold;
@property NSDictionary * italic;
@property NSDictionary * underlined;
@property NSDictionary * highlighted;

//=============================================================================

/**
 Prepared setup.
 Different attributes with GillSans font.
 * @result theme instance by default.
 */
+ (AttributesTheme *)defaultTheme;

/**
 * @param primary The common attributes.
 * @param bold The bold attributes.
 * @result theme instance by default.
 */
+ (AttributesTheme *)boldThemeWithPrimary:(NSDictionary *)primary
                                     bold:(NSDictionary *)bold;

/**
 * @param primary The common attributes.
 * @param bold The bold attributes.
 * @param italic The italic attributes.
 * @result theme instance by default.
 */
+ (AttributesTheme *)customThemeWithPrimary:(NSDictionary *)primary
                                       bold:(NSDictionary *)bold
                                     italic:(NSDictionary *)italic;

/**
 * @param primary The common attributes.
 * @param bold The bold attributes.
 * @param italic The italic attributes.
 * @param underlined The underlined attributes.
 * @param highlighted The highlighted attributes.
 * @result theme instance by default.
 */
+ (AttributesTheme *)customThemeWithPrimary:(NSDictionary *)primary
                                       bold:(NSDictionary *)bold
                                     italic:(NSDictionary *)italic
                                 underlined:(NSDictionary *)underlined
                                highlighted:(NSDictionary *)highlighted;
@end

NS_ASSUME_NONNULL_END
