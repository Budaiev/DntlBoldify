//
//  AppDelegate.m
//  ConceptAttributedStringHelper
//
//  Created by Aleksandr Budaiev on 3/6/19.
//  Copyright © 2019 DNTL. All rights reserved.
//

#import "AppDelegate.h"
#import "InitialViewController.h"

@interface AppDelegate ()

@end

//=============================================================================

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [UIWindow.alloc initWithFrame:UIScreen.mainScreen.bounds];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:InitialViewController.new];
    
    if (@available(iOS 11.0, *)) {
        [nc.navigationBar setPrefersLargeTitles:YES];
        NSDictionary * largeTitleAttributes = @{
                                                NSFontAttributeName:[UIFont fontWithName:@"GillSans-Bold" size:25]
                                                };
        
        [nc.navigationBar setLargeTitleTextAttributes:largeTitleAttributes];
    } else {
        NSDictionary * titleAttributes = @{
                                           NSFontAttributeName:[UIFont fontWithName:@"GillSans-Bold" size:20]
                                           };
        
        [nc.navigationBar setTitleTextAttributes:titleAttributes];
    }
    
    _window.rootViewController = nc;
    
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
