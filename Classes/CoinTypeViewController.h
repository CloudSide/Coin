//
//  CoinTypeViewController.h
//  Coin
//
//  Created by xiaoli on 10-4-21.
//  Copyright 2010 bict. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CoinViewController;

@interface CoinTypeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	
	NSArray *_arr;

	NSIndexPath *coinSelection;
	
	CoinViewController *cvc;
}


- (id)_init:(NSArray *)arr CVC:(CoinViewController *)CVC;
- (void)returnToIndex;

@property(nonatomic,retain) NSIndexPath *coinSelection;

@end
