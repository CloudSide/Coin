//
//  CoinAppDelegate.h
//  Coin
//
//  Created by xiaoli on 10-4-19.
//  Copyright bict 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoinViewController;

@interface CoinAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    CoinViewController *viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) CoinViewController *viewController;

@end

