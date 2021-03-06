//
//  NSAttributedString+Boldify.h
//  ConceptAttributedStringHelper
//
//  Created by Aleksandr Budaiev on 3/6/19.
//  Copyright © 2019 test.name. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Category for NSAttributedString.
 Apply needed attributes inside special tags in your texts.
 Usefull for cases when you have different attributes for Localizable.strings.
 Convenient to work with same texts for other targets in the project.
 */
@interface NSAttributedString (Boldify)

//=============================================================================

/** Proceed with single tag.
 * @param tag The single string tag.
 * @param primaryAttributes The attributesfor common text.
 * @param tagAttributes The specified attributes for text inside tags.
 * @result modified NSAttributedString.
 */
- (NSAttributedString *)transformWithSingleTag:(NSString *)tag
                             primaryAttributes:(NSDictionary *)primaryAttributes
                                 tagAttributes:(NSDictionary *)tagAttributes;

//=============================================================================

/** Proceed with multiple tags.
 * @param tags An array with needed tags.
 * @param primaryAttributes The attributesfor common text.
 * @param tagAttributes The specified attributes for text inside tags.Index according to tag.
 * @result modified NSAttributedString.
 */
- (NSAttributedString *)transformWithMultipleTags:(NSArray *)tags
                                primaryAttributes:(NSDictionary *)primaryAttributes
                                    tagAttributes:(NSArray *)tagAttributes;

//=============================================================================

@end

#pragma mark - Helper

@interface NSMutableAttributedString (Cleanup)

/** Recursive trimming through NSRange.
 * @param tag The tag to proceed sanitizing.
 * @param string The string to replace tag. Oftenly is empty string.
 * @result clean string without tag.
 */
- (NSMutableAttributedString *)cleanupTag:(NSString *)tag
                     substituteWithString:(NSString *)string;

@end

//=============================================================================

NS_ASSUME_NONNULL_END
