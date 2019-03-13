//
//  NSAttributedString+Boldify.m
//  ConceptAttributedStringHelper
//
//  Created by Aleksandr Budaiev on 3/6/19.
//  Copyright © 2019 test.name. All rights reserved.
//

#import "NSAttributedString+Boldify.h"

@implementation NSAttributedString (Boldify)

- (NSAttributedString *)transformWithMultipleTags:(NSArray *)tags
                                primaryAttributes:(NSDictionary *)primaryAttributes
                                    tagAttributes:(NSArray *)tagAttributes {
    /// TODO: assure via try-catch.
    NSRange fullRange = NSMakeRange(0, [self length]);
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:self.mutableCopy];
    [attrString addAttributes:primaryAttributes range:fullRange];
    
    NSAttributedString * finalResult = attrString;
    for (NSInteger i = 0; i< tags.count ; i++) {
        
        @try {
            finalResult = [finalResult transformWithTag:tags[i] tagAttributes:tagAttributes[i]];
        } @catch (NSException *exception) {
            NSLog(@"Exception: %@\nReason: %@",exception.name , exception.reason);
        }
    }
    
    return finalResult;
}


//=============================================================================


- (NSAttributedString *)transformWithTag:(NSString *)tag
                           tagAttributes:(NSDictionary *)tagAttributes {
    
    NSString * openTag = tag;
    NSString * closeTag = [tag stringByReplacingOccurrencesOfString:@"<" withString:@"</"];
    NSString * regexFormat = [NSString stringWithFormat:@"\\%@.*?\\%@", openTag, closeTag];
    
    NSRange fullRange = NSMakeRange(0, [self length]);
    
    //=============================================================================
    
    NSRegularExpression *tagsRegex = [NSRegularExpression regularExpressionWithPattern:regexFormat
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
    NSArray *matches = [tagsRegex matchesInString:self.string
                                          options:0
                                            range:fullRange];
    
    
    NSMutableArray *mRanges = @[].mutableCopy;
    
    [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL *stop) {
        
        for (NSInteger i = 0; i< [obj numberOfRanges]; i++) {
            
            NSRange range = [obj rangeAtIndex:i];
            range = NSMakeRange(range.location+3, range.length-7);
            [mRanges addObject:[NSValue valueWithRange:range]];
        }
    }];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithAttributedString:self.mutableCopy];
    
    //=============================================================================
    [attrString beginEditing];
    for (NSInteger ridx = 0; ridx < mRanges.count; ridx ++) {
        
        NSRange range = [mRanges[ridx] rangeValue];
        
        /// if range doesn't found
        if (range.length < self.length) {
            
            [attrString addAttributes:tagAttributes range:range];
        } else {

            NSString * startsAs = [self.string substringWithRange:NSMakeRange(range.location-3, 6)];
            NSString * reason = [NSString stringWithFormat:@"NSRange for tag: %@ goes out of the bounds at: %@.\nWrong part: %@",
                                 tag , @(range.location), startsAs];

            @throw [NSException exceptionWithName:@"DNTL_NSRangeException"
                                           reason:reason
                                         userInfo:@{}];
        }
    
    }
    [attrString endEditing];
    
    [attrString cleanupTag:openTag
      substituteWithString:@""];
    [attrString cleanupTag:closeTag
      substituteWithString:@""];
    
    return attrString;
}


//=============================================================================


- (NSAttributedString *)transformWithSingleTag:(NSString *)tag
                                   primaryAttributes:(NSDictionary *)primaryAttributes
                                       tagAttributes:(NSArray *)tagAttributes {

    return [self transformWithMultipleTags:@[tag]
                         primaryAttributes:primaryAttributes
                             tagAttributes:@[tagAttributes]];
}

@end


//=============================================================================

#pragma mark - Helper

@implementation NSMutableAttributedString (Cleanup)

- (NSMutableAttributedString *)cleanupTag:(NSString *)tag
                     substituteWithString:(NSString *)string {
    
    NSRange updatedRange = NSMakeRange(0, [self length]);
    
    NSRegularExpression *tagRegex =
    [NSRegularExpression regularExpressionWithPattern:[NSRegularExpression escapedPatternForString:tag]
                                              options:NSRegularExpressionCaseInsensitive
                                                error:nil];
    
    NSArray * matches = [tagRegex matchesInString:self.string
                                          options:0
                                            range:updatedRange];
    
    NSMutableArray *singleRange = @[].mutableCopy;
    
    if (matches.count > 0) {
        
        [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL *stop) {
            NSRange range = [obj rangeAtIndex:0];
            [singleRange addObject:[NSValue valueWithRange:range]];
        }];
        
        NSRange range = [singleRange[0] rangeValue];
        
        [self replaceCharactersInRange:range withString:string];
        
        [self cleanupTag:tag substituteWithString:string];
    }
    
    return self;
}

//=============================================================================

@end
