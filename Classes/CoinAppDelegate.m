//
//  CoinAppDelegate.m
//  Coin
//
//  Created by xiaoli on 10-4-19.
//  Copyright bict 2010. All rights reserved.
//

#import "CoinAppDelegate.h"
#import "CoinViewController.h"

@implementation CoinAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
	viewController = [[CoinViewController alloc] init];
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}




- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
