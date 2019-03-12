//
//  ViewController.h
//  ConceptAttributedStringHelper
//
//  Created by Aleksandr Budaiev on 3/6/19.
//  Copyright © 2019 DNTL. All rights reserved.
//

#import <UIKit/UIKit.h>

//=============================================================================

/** Demonstration Root screen */
@interface InitialViewController : UIViewController

@end

//=============================================================================

#pragma mark - UI for InitialViewController

/** Setup views hierarchy. Instead basevc legacy */
@interface InitialViewController (UI)

/** Compose UI. */
- (void)setupViews;

@end
