//
//  CoinViewController.h
//  Coin
//
//  Created by xiaoli on 10-4-19.
//  Copyright bict 2010. All rights reserved.
//

#define AD_REFRESH_PERIOD 12.5 // display fresh ads every 12.5 seconds

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "AdMobDelegateProtocol.h"

@class CoinView;
@class CoinTypeViewController;
@class AdMobView;

@interface CoinViewController : UIViewController <AVAudioPlayerDelegate,UIAccelerometerDelegate,AdMobDelegate> {
	
	NSArray *freeCoins;
	UIImageView *imgView;
	UIImageView *imgViewFooter;
	NSTimer *animationTimer;
	
	UIImage *imgA;
	UIImage *imgB;
	
	CGFloat offset;
	char flagM; //正反面标示
	char flagW; //增减标示
	char flagH; //高度标示
	int flagS;
	BOOL status;
	
	int index;
	
	CoinTypeViewController *coinType;
	UINavigationController *coinTypeNavigationController;
	
	
	AdMobView *adMobAd;
	NSTimer *refreshTimer;

}

- (void)startAnimation;
- (void)stopAnimation;
- (void)update:(NSTimer*)theTimer;
- (void)goToSetup;
- (void)changeCoin:(int)INDEX;


@property(nonatomic,retain) NSArray *freeCoins;
@property(nonatomic,retain) UIImageView *imgView;
@property(nonatomic,retain) UIImageView *imgViewFooter;
@property(nonatomic,retain) UIImage *imgA;
@property(nonatomic,retain) UIImage *imgB;
@property BOOL status;
@property(nonatomic,retain) CoinTypeViewController *coinType;
@property(nonatomic,retain) UINavigationController *coinTypeNavigationController;

@end

