//
//  CoinView.m
//  Coin
//
//  Created by xiaoli on 10-4-19.
//  Copyright 2010 bict. All rights reserved.
//

#import "CoinView.h"
#import "CoinViewController.h"


@implementation CoinView


//- (id)initWithFrame:(CGRect)frame {
//    if ((self = [super initWithFrame:frame])) {
//        // Initialization code
//    }
//    return self;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)init:(CoinViewController *)cvc {

	if ((self = [super initWithFrame:CGRectMake(0, 0, 320, 480)])) {
		
		_cvc = cvc;

	}
	return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

	[_cvc startAnimation];
}

- (void)dealloc {
    [super dealloc];
}


@end
