//
//  CoinView.h
//  Coin
//
//  Created by xiaoli on 10-4-19.
//  Copyright 2010 bict. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoinViewController;

@interface CoinView : UIView {
	
	
	CoinViewController *_cvc;

}


- (id)init:(CoinViewController *)cvc;

@end
