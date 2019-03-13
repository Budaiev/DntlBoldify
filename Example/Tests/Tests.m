//
//  ConceptAttributedStringHelperTests.m
//  ConceptAttributedStringHelperTests
//
//  Created by Aleksandr Budaiev on 3/6/19.
//  Copyright © 2019 DNTL. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSAttributedString+Boldify.h"
#import "AttributesTheme.h"

@interface ConceptAttributedStringHelperTests : XCTestCase

@end

@interface NSAttributedString ()
- (NSAttributedString *)transformWithTag:(NSString *)tag tagAttributes:(NSDictionary *)tagAttributes;
@end

@implementation ConceptAttributedStringHelperTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

//=============================================================================

/**
 * Approve the helper correctly works with invalid parameters.
 Helper has @try-@catch handling exceptions.
 
 * Unit under test:
 Helper NSAttributedString+Boldify.
 Method - (void)transformWithMultipleTag:...
 
 * Parameters to test:
 Check: helper method catch exceptions for the failure entrances.
 
 * Test scenario:
 Prepare AttributesTheme.defaultTheme.
 Fire method with wrong attributes.
 
 * Verify
 The helper method is throwing exception.
 */
- (void)test_TryCatch_FailExamples {
    
    __block NSAttributedString * expression =
    [[NSAttributedString alloc] initWithString:@"<u>sdgf<i>gfdgfd <u> gdfsgsg f <b> sf</b> text </i>text</b> text dfgsgdg</i>text tgdfge<u>xt <u>tgdfgdfg</i>ext text </b> dfgsg <g> gdg <g> ____g&%&%(*(%($#%#%_^*($*^#<u> djkghhggshgh sdghk hksdg sdhkghs ksdkg dsggd hsk hksdhgksd"];
    
    __block AttributesTheme * theme = AttributesTheme.defaultTheme;
    
    //-----------------------------------------------------------------------------
    void (^failWithExc1)(void) = ^{
        
        expression = [expression transformWithTag:@"g"
                                    tagAttributes:nil];
    };
    
    XCTAssertThrows(failWithExc1());
    //-----------------------------------------------------------------------------
    
    void (^failWithExc2)(void) = ^{
        
        expression = [expression transformWithMultipleTags:@[@"</b>",@"<i",@"<u>",@"<g>"]
                                         primaryAttributes:nil//theme.primary
                                            tagAttributes : @[theme.bold, theme.italic, theme.underlined ]]; //theme.highlighted
    };
    
    XCTAssertThrows(failWithExc2());
    //-----------------------------------------------------------------------------
    
    
    
    void (^failWithExc3)(void) = ^{
        
        
        expression = [expression transformWithTag:@"g"
                                    tagAttributes:nil];
    };
    
    
    XCTAssertThrowsSpecificNamed(failWithExc3(),
                                 NSException, @"DNTL_NSRangeException", @"should throw DNTL_NSRangeException");
}

//=============================================================================

/**
 * Assure the needed attributes is performed correctly.
 
 * Unit under test:
 Helper NSAttributedString+Boldify.
 Method - (void)transformWithSingleTag:...
 
 
 * Parameters to test:
 Check if helper proceed correct attributes for defined tags.
 Single bold tag in pair with primary attributes.
 
 * Test scenario:
 Prepare AttributesTheme.defaultTheme.
 Fire helper method for expression under test.
 Make the attributes manually step-by-step.
 
 * Verify
 Result expression (maded via helper) and expectation maked manually should be equal.
 */
- (void)test_proofSingleExample {
    
    AttributesTheme * theme = AttributesTheme.defaultTheme;
    
    NSAttributedString * expression =
    [[NSAttributedString alloc] initWithString:@"primary1 <b>b(o,ld 1 %^&*(./][=+$#@!)</b>\\ primary 2<b>bold 2 bold</b> primary3<b>bold4</b>4 primary,<b> </b> primary \n\n \nprimary."];
    
    expression =
    [expression transformWithSingleTag:@"<b>" primaryAttributes:theme.primary tagAttributes:theme.bold];
    
    /// Compose etalon.
    NSMutableAttributedString * etalon = NSMutableAttributedString.new;
    [etalon beginEditing];
    [etalon appendAttributedString:[self appendStr:@"primary1 "               attributes: theme.primary]];
    [etalon appendAttributedString:[self appendStr:@"b(o,ld 1 %^&*(./][=+$#@!)"                attributes: theme.bold]];
    [etalon appendAttributedString:[self appendStr:@"\\ primary 2"            attributes: theme.primary]];
    [etalon appendAttributedString:[self appendStr:@"bold 2 bold"             attributes: theme.bold]];
    [etalon appendAttributedString:[self appendStr:@" primary3"               attributes: theme.primary]];
    [etalon appendAttributedString:[self appendStr:@"bold4"                   attributes: theme.bold]];
    [etalon appendAttributedString:[self appendStr:@"4 primary,"              attributes: theme.primary]];
    [etalon appendAttributedString:[self appendStr:@" "                       attributes: theme.bold]];
    [etalon appendAttributedString:[self appendStr:@" primary \n\n \nprimary." attributes: theme.primary]];
    [etalon endEditing];
    NSAttributedString * finishEtalon = [[NSAttributedString alloc] initWithAttributedString:etalon];
    
    /// Check string.
    XCTAssertTrue([finishEtalon.string isEqualToString:expression.string]);
    
    /// Check string all attributes.
    XCTAssertTrue([expression isEqualToAttributedString:finishEtalon]);
}

//=============================================================================


/**
 * Assure the needed attributes is performed correctly.
 
 * Unit under test:
 Helper NSAttributedString+Boldify.
 Method - (void)transformWithMultipleTags:...
 
 
 * Parameters to test:
 Check if helper proceed correct attributes for defined tags.
 There are bold, italic, underlined, highlighted tags works together with primary.
 
 * Test scenario:
 Prepare AttributesTheme.defaultTheme.
 Fire helper method for expression under test.
 Make the attributes manually step-by-step.

 * Verify
 Result expression (maded via helper) and expectation maked manually should be equal.
 */
- (void)test_proofMultipleExample {
    
    AttributesTheme * theme = AttributesTheme.defaultTheme;
    
    NSAttributedString * expression =
    [[NSAttributedString alloc] initWithString:@"primary1 <b>bold 1</b> primary 2<g>highlighted1</g> primary3 <b>bold2</b> 4primary<u>underlined</u> primary\n 4\nprimary <i>italic</i><g>@highlighted</g> <b> bold ,</b><g> highlighted highlighted</g> primary \n \nprimary."];
    
    expression =
    [expression transformWithMultipleTags: @[@"<b>",@"<i>",@"<u>",@"<g>"]
                        primaryAttributes: theme.primary
                           tagAttributes : @[theme.bold, theme.italic, theme.underlined, theme.highlighted]];
    
    /// Compose etalon.
    NSMutableAttributedString * expectation = NSMutableAttributedString.new;
    [expectation beginEditing];
    [expectation appendAttributedString:[self appendStr:@"primary1 "     attributes: theme.primary]];
    [expectation appendAttributedString:[self appendStr:@"bold 1"        attributes: theme.bold]];
    [expectation appendAttributedString:[self appendStr:@" primary 2"    attributes: theme.primary]];
    [expectation appendAttributedString:[self appendStr:@"highlighted1"  attributes:theme.highlighted]];
    [expectation appendAttributedString:[self appendStr:@" primary3 "    attributes: theme.primary]];
    [expectation appendAttributedString:[self appendStr:@"bold2"         attributes: theme.bold]];
    [expectation appendAttributedString:[self appendStr:@" 4primary"     attributes: theme.primary]];
    [expectation appendAttributedString:[self appendStr:@"underlined"    attributes: theme.underlined]];
    [expectation appendAttributedString:[self appendStr:@" primary\n 4\nprimary " attributes: theme.primary]];
    [expectation appendAttributedString:[self appendStr:@"italic"        attributes: theme.italic]];
    [expectation appendAttributedString:[self appendStr:@"@highlighted"  attributes: theme.highlighted]];
    [expectation appendAttributedString:[self appendStr:@" "             attributes: theme.primary]];
    [expectation appendAttributedString:[self appendStr:@" bold ,"       attributes: theme.bold]];
    [expectation appendAttributedString:[self appendStr:@" highlighted highlighted"  attributes: theme.highlighted]];
    [expectation appendAttributedString:[self appendStr:@" primary \n \nprimary."    attributes: theme.primary]];
    [expectation endEditing];
    NSAttributedString * finishExp = [[NSAttributedString alloc] initWithAttributedString:expectation];
    
    /// Check string.
    XCTAssertTrue([finishExp.string isEqualToString:expression.string]);
    
    /// Verify string all attributes.
    XCTAssertTrue([expression isEqualToAttributedString:finishExp]);
}

- (NSAttributedString *)appendStr:(NSString *)string
                       attributes:(NSDictionary *)attributes {
    return [NSAttributedString.alloc initWithString:string
                                         attributes: attributes];
}

//=============================================================================

/**
 * Used helper to make needed cleanings after tags
 
 * Unit under test:
 Helper NSMutableAttributedString (Cleanup).
 Method - (NSMutableAttributedString *)cleanupTag:(NSString *)tag
 substituteWithString:(NSString *)string;
 
 * Parameters to test:
 Check if helper proceed valid cleanup (remove tags).
 
 * Test scenario:
 Prepared (NSMutableAttributedString *) expression - with tags.
 Prepared (NSMutableAttributedString *) expectation - without tags.
 
 * Verify expression string should be equal to expectation.
 */
- (void)test_recursiveTagsCleanup {
    
    NSMutableAttributedString * expression =
    [[NSMutableAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, commune <b>tacimates</b> cu duo. Id quo erat regione menandri. Per ex eros zril apeirian, ad vel velit putant, ne agam referrentur mel. Timeam diceret vel at, cu sit <b>tacimates</b> omittantur. Ne mei probo noster inermis, putent inimicus te est. Duo te veniam denique.\n\nVim oratio ubique ea, has cu debet animal. His cu bonorum percipit apeirian, vim ne ludus accusata. <i>Qui hinc nemore civibus ex, mollis intellegat ea eam. Assum summo suscipiantur nam ad.</i> <b>Quo dictas latine definitiones ad</b>, in homero <u>eleifend vim, ponderum facilisi per </u>ad."];
    
    NSMutableAttributedString * expectation =
    [[NSMutableAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, commune tacimates cu duo. Id quo erat regione menandri. Per ex eros zril apeirian, ad vel velit putant, ne agam referrentur mel. Timeam diceret vel at, cu sit tacimates omittantur. Ne mei probo noster inermis, putent inimicus te est. Duo te veniam denique.\n\nVim oratio ubique ea, has cu debet animal. His cu bonorum percipit apeirian, vim ne ludus accusata. Qui hinc nemore civibus ex, mollis intellegat ea eam. Assum summo suscipiantur nam ad. Quo dictas latine definitiones ad, in homero uTageleifend vim, ponderum facilisi per tagUad."];
    
    expression = [expression cleanupTag:@"<b>" substituteWithString:@""];
    expression = [expression cleanupTag:@"</b>" substituteWithString:@""];
    
    expression = [expression cleanupTag:@"<i>" substituteWithString:@""];
    expression = [expression cleanupTag:@"</i>" substituteWithString:@""];
    
    expression = [expression cleanupTag:@"<u>" substituteWithString:@"uTag"];
    expression = [expression cleanupTag:@"</u>" substituteWithString:@"tagU"];
    
    /// Verify
    XCTAssertTrue([expectation isEqualToAttributedString:expression], @"all attributes should be equal");
}

//=============================================================================

/**
 * Test for the future helper.
 Goal:findout all links.
 
 * Unit under test:
 That Helper is not implemented yet.
 
 * Parameters to test:
 Check if regex (NSTextCheckingResult*) find all existed links.
 
 * Test scenario:
 Prepared (NSMutableAttributedString *) expression - with links.
 Fire NSRegularExpression.
 
 * Verify:
 array contains needed links.
 */
- (void)test_exampleRegexForLinks {
    
    NSMutableAttributedString * httpLine =
    [NSMutableAttributedString.alloc initWithString:@"Lorem ipsum dolor sit amet, commune <b>tacimates</b> cu duo. Id quo erat regione menandri. Per ex eros zril apeirian, ad vel velit putant, ne agam referrentur mel. Timeam diceret vel at, cu sit <b>tacimates</b> omittantur. Ne mei probo noster inermis, putent https://www.lipsum.com inimicus te est. Duo te veniam denique.\n\nVim oratio ubique ea, has cu debet animal. His cu bonorum percipit apeirian, vim ne ludus accusata. <i>Qui https://loremipsum.io hinc nemore civibus ex, mollis intellegat ea eam. Assum summo suscipiantur nam ad.</i> <b>Quo dictas latine definitiones ad</b>, in homero eleifend vim, ponderum facilisi per ad."];
    
    NSError * error;
    NSRegularExpression *regex =
    [NSRegularExpression regularExpressionWithPattern:@"https?://([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?" options:NSRegularExpressionCaseInsensitive
                                                error:&error];
    
    NSArray *arrayOfAllMatches = [regex matchesInString:httpLine.string options:0 range:NSMakeRange(0, [httpLine length])];
    
    NSMutableArray *arrayOfURLs = [[NSMutableArray alloc] init];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches) {
        NSString* substringForMatch = [httpLine.string substringWithRange:match.range];
        //NSLog(@"Extracted URL: %@",substringForMatch);
        
        [arrayOfURLs addObject:substringForMatch];
    }
    
    XCTAssertTrue(arrayOfURLs.count == 2,@"should be equal 2");
    XCTAssertTrue([arrayOfURLs containsObject:@"https://www.lipsum.com"],@"should contain");
    XCTAssertTrue([arrayOfURLs containsObject:@"https://loremipsum.io"],@"should contain");
}



@end
