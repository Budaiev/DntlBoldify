//
//  ConceptAttributedStringHelperTests.m
//  ConceptAttributedStringHelperTests
//
//  Created by Aleksandr Budaiev on 3/6/19.
//  Copyright © 2019 test.name. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSAttributedString+Boldify.h"
#import "AttributesTheme.h"

@interface ConceptAttributedStringHelperTests : XCTestCase

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
 Test the transformWithSingleTag method
 Single bold tag in pair with primary attributes.
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

/**
 Test the transformWithMultipleTags method
 There are bold, italic, underlined, highlighted tags works together with primary.
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
    NSMutableAttributedString * etalon = NSMutableAttributedString.new;
    [etalon beginEditing];
    [etalon appendAttributedString:[self appendStr:@"primary1 "     attributes: theme.primary]];
    [etalon appendAttributedString:[self appendStr:@"bold 1"        attributes: theme.bold]];
    [etalon appendAttributedString:[self appendStr:@" primary 2"    attributes: theme.primary]];
    [etalon appendAttributedString:[self appendStr:@"highlighted1"  attributes:theme.highlighted]];
    [etalon appendAttributedString:[self appendStr:@" primary3 "    attributes: theme.primary]];
    [etalon appendAttributedString:[self appendStr:@"bold2"         attributes: theme.bold]];
    [etalon appendAttributedString:[self appendStr:@" 4primary"     attributes: theme.primary]];
    [etalon appendAttributedString:[self appendStr:@"underlined"    attributes: theme.underlined]];
    [etalon appendAttributedString:[self appendStr:@" primary\n 4\nprimary " attributes: theme.primary]];
    [etalon appendAttributedString:[self appendStr:@"italic"        attributes: theme.italic]];
    [etalon appendAttributedString:[self appendStr:@"@highlighted"  attributes: theme.highlighted]];
    [etalon appendAttributedString:[self appendStr:@" "             attributes: theme.primary]];
    [etalon appendAttributedString:[self appendStr:@" bold ,"       attributes: theme.bold]];
    [etalon appendAttributedString:[self appendStr:@" highlighted highlighted"  attributes: theme.highlighted]];
    [etalon appendAttributedString:[self appendStr:@" primary \n \nprimary."    attributes: theme.primary]];
    [etalon endEditing];
    NSAttributedString * finishEtalon = [[NSAttributedString alloc] initWithAttributedString:etalon];
    
    /// Check string.
    XCTAssertTrue([finishEtalon.string isEqualToString:expression.string]);
    
    /// Verify string all attributes.
    XCTAssertTrue([expression isEqualToAttributedString:finishEtalon]);
}

- (NSAttributedString *)appendStr:(NSString *)string
                       attributes:(NSDictionary *)attributes {
    return [NSAttributedString.alloc initWithString:string
                                         attributes: attributes];
}

//=============================================================================

/**
 NSMutableAttributedString (Cleanup)
 - (NSMutableAttributedString *)cleanupTag:(NSString *)tag
 substituteWithString:(NSString *)string;
 */
- (void)test_recursiveTagsCleanup {
    
    NSMutableAttributedString * expression =
    [[NSMutableAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, commune <b>tacimates</b> cu duo. Id quo erat regione menandri. Per ex eros zril apeirian, ad vel velit putant, ne agam referrentur mel. Timeam diceret vel at, cu sit <b>tacimates</b> omittantur. Ne mei probo noster inermis, putent inimicus te est. Duo te veniam denique.\n\nVim oratio ubique ea, has cu debet animal. His cu bonorum percipit apeirian, vim ne ludus accusata. <i>Qui hinc nemore civibus ex, mollis intellegat ea eam. Assum summo suscipiantur nam ad.</i> <b>Quo dictas latine definitiones ad</b>, in homero <u>eleifend vim, ponderum facilisi per </u>ad."];
    
    NSMutableAttributedString * etalon =
    [[NSMutableAttributedString alloc] initWithString:@"Lorem ipsum dolor sit amet, commune tacimates cu duo. Id quo erat regione menandri. Per ex eros zril apeirian, ad vel velit putant, ne agam referrentur mel. Timeam diceret vel at, cu sit tacimates omittantur. Ne mei probo noster inermis, putent inimicus te est. Duo te veniam denique.\n\nVim oratio ubique ea, has cu debet animal. His cu bonorum percipit apeirian, vim ne ludus accusata. Qui hinc nemore civibus ex, mollis intellegat ea eam. Assum summo suscipiantur nam ad. Quo dictas latine definitiones ad, in homero uTageleifend vim, ponderum facilisi per tagUad."];
    
    expression = [expression cleanupTag:@"<b>" substituteWithString:@""];
    expression = [expression cleanupTag:@"</b>" substituteWithString:@""];
    
    expression = [expression cleanupTag:@"<i>" substituteWithString:@""];
    expression = [expression cleanupTag:@"</i>" substituteWithString:@""];
    
    expression = [expression cleanupTag:@"<u>" substituteWithString:@"uTag"];
    expression = [expression cleanupTag:@"</u>" substituteWithString:@"tagU"];
    
    /// Verify
    XCTAssertTrue([etalon isEqualToAttributedString:expression], @"all attributes should be equal");
}

//=============================================================================

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
