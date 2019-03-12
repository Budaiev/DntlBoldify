//
//  InitialViewController.m
//  ConceptAttributedStringHelper
//
//  Created by Aleksandr Budaiev on 3/6/19.
//  Copyright © 2019 DNTL. All rights reserved.
//

#import "InitialViewController.h"
#import "AppDelegate.h"
#import "NSAttributedString+Boldify.h"
#import "AttributesTheme.h"

//=============================================================================

@interface InitialViewController ()

/// Swipe-able container.
@property UIScrollView * scrollView;

/// Flexible content container.
@property UIStackView * stackView;

@end

//=============================================================================

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"target localization",@"");
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupViews];
    
    AttributesTheme * theme = AttributesTheme.defaultTheme;
    
    NSAttributedString * aText =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"1 paragraph text", @"1 part")];
    
    NSAttributedString *aaText =
    [aText transformWithMultipleTags: @[@"<b>",@"<i>",@"<u>",@"<g>"]
                   primaryAttributes: theme.primary
                       tagAttributes: @[theme.bold, theme.italic, theme.underlined, theme.highlighted]];
    
    
    NSAttributedString * bText =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"2 paragraph text", @"2 part")];
    
    NSAttributedString *bbText =
    [bText transformWithSingleTag: @"<u>"
                primaryAttributes: theme.primary
                    tagAttributes: theme.underlined];
    
    
    NSAttributedString * cText =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"3 paragraph text", @"3 part")];
    
    NSAttributedString *ccText =
    [cText transformWithMultipleTags: @[@"<b>",@"<i>",@"<u>",@"<g>"]
                   primaryAttributes: theme.primary
                      tagAttributes : @[theme.bold, theme.italic, theme.underlined, theme.highlighted]];
    
    [self populateWithText:aaText];
    [self populateWithText:bbText];
    [self populateWithText:ccText];
    
    [self updateViewConstraints];
    
}

//=============================================================================

- (void)populateWithText:(NSAttributedString *)attrText {
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    aLabel.numberOfLines = 0;
    aLabel.attributedText = attrText;
    [self.stackView addArrangedSubview:aLabel];
}

@end


//=============================================================================

#pragma mark - UI for InitialViewController

@implementation InitialViewController (UI)

/// GuideLine margin.
static const CGFloat margin = 8;

//=============================================================================

- (void)setupViews {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.scrollView];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    [self.scrollView addSubview:self.stackView];
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
}

//=============================================================================

- (void)updateViewConstraints {
    
    [self addConstraintsForScrollView];
    [self addContraintsForStackView];
    
    [super updateViewConstraints];
}

- (void)addContraintsForStackView {
    
    [self addContraintsForView:self.stackView
                     container:self.scrollView
                        margin:0];
}

//=============================================================================

- (void)addConstraintsForScrollView {
    
    [self embeddingContraints:self.scrollView
                   isSafeArea:YES
                       margin:0];
}

//=============================================================================

- (void)embeddingContraints:(UIView *)rootClient
                 isSafeArea:(BOOL)isSafeArea
                     margin:(CGFloat)constant {
    
    id safeArea;
    if (@available(iOS 11.0, *)) {
        safeArea = isSafeArea ? self.view.safeAreaLayoutGuide : self.view;
    } else {
        safeArea = self.view;
    }
    
    /* Leading space to superview */
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:rootClient
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:safeArea
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:constant+margin];
    
    /* Trailing space to superview */
    NSLayoutConstraint * trailing = [NSLayoutConstraint constraintWithItem:rootClient
                                                                 attribute:NSLayoutAttributeTrailing
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:safeArea
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:constant-margin];
    
    /* Top space to superview */
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:rootClient
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:safeArea
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:constant+margin];
    
    /* Bottom space to superview */
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:rootClient
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:safeArea
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:constant+margin];
    
    /* Add the constraints to ROOT superview*/
    [self.view addConstraints:@[top, leading, bottom , trailing]];
}

//=============================================================================

- (void)addContraintsForView:(UIView *)client
                   container:(UIView *)container
                      margin:(CGFloat)constant {
    
    /* Same width as container */
    NSLayoutConstraint *sameWidthConstraint = [NSLayoutConstraint constraintWithItem:client
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:container
                                                                           attribute:NSLayoutAttributeWidth
                                                                          multiplier:1.0
                                                                            constant:0];
    
    //=============================================================================
    
    
    /* Leading space to container */
    NSLayoutConstraint *leftBorderConstraint = [NSLayoutConstraint constraintWithItem:client
                                                                            attribute:NSLayoutAttributeLeading
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:container
                                                                            attribute:NSLayoutAttributeLeading
                                                                           multiplier:1.0
                                                                             constant:constant];
    
    /* Trailing space to container */
    NSLayoutConstraint *rightBorderConstraint = [NSLayoutConstraint constraintWithItem:client
                                                                             attribute:NSLayoutAttributeTrailing
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:container
                                                                             attribute:NSLayoutAttributeTrailing
                                                                            multiplier:1.0
                                                                              constant:constant];
    
    /* Top space to container */
    NSLayoutConstraint *topBorderConstraint = [NSLayoutConstraint constraintWithItem:client
                                                                           attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:container
                                                                           attribute:NSLayoutAttributeTop
                                                                          multiplier:1.0
                                                                            constant:constant];
    
    /* Top space to container */
    NSLayoutConstraint *bottomBorderConstraint = [NSLayoutConstraint constraintWithItem:client
                                                                              attribute:NSLayoutAttributeBottom
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:container
                                                                              attribute:NSLayoutAttributeBottom
                                                                             multiplier:1.0
                                                                               constant:constant];
    
    /* Add the client constraints to container borders*/
    [self.view addConstraints:@[
                                sameWidthConstraint,
                                topBorderConstraint, leftBorderConstraint, rightBorderConstraint, bottomBorderConstraint]];
    
}

@end
