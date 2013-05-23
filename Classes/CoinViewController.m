//
//  CoinViewController.m
//  Coin
//
//  Created by xiaoli on 10-4-19.
//  Copyright bict 2010. All rights reserved.
//

#import "CoinViewController.h"
#import "CoinView.h"
#import "CoinTypeViewController.h"
#import "AdMobView.h"

@implementation CoinViewController

@synthesize freeCoins,imgView,imgViewFooter,imgB,imgA,status,coinType,coinTypeNavigationController;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (id)init {

	if (self = [super init]) {
		
		
		
		adMobAd = [AdMobView requestAdWithDelegate:self]; // start a new ad request
		[adMobAd retain]; // this will be released when it loads (or fails to load)
		
		
		
		
		self.status = YES;
		
		CoinView *cv = [[CoinView alloc] init:self];
		[self setView:cv];
		[cv release];
		
		
		//背景颜色
		[self.view setBackgroundColor:[UIColor blackColor]];
		
		//数组
		NSString *path = [[NSBundle mainBundle] pathForResource:@"FreeCoins.plist" ofType:nil];
		freeCoins = [[NSArray arrayWithContentsOfFile:path] retain];
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *path_index = [documentsDirectory stringByAppendingPathComponent:@"selected_data.plist"];
		NSArray *selected_data = [NSArray arrayWithContentsOfFile:path_index];
		index = 0;
		if (selected_data == nil) {
			
			index = 0;
			
		} else {
			
			index = [[selected_data objectAtIndex:0] intValue];
		}
		
		
		
		NSLog(@"%@",freeCoins);
		
		
		//图片A面
		imgA = [[UIImage imageNamed:[[freeCoins objectAtIndex:index] objectForKey:@"big_image_obverse"]] retain];
		//图片B面
		imgB = [[UIImage imageNamed:[[freeCoins objectAtIndex:index] objectForKey:@"big_image_reverse"]] retain];
		
		
		imgView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 260, 160, 160)];
		[imgView setImage:imgA];
		[self.view addSubview:imgView];
		
		imgViewFooter = [[UIImageView alloc] initWithFrame:CGRectMake(80, 420, 160, 160)];
		[imgViewFooter setImage:imgA];
		imgViewFooter.alpha = 0.3;
		[self.view addSubview:imgViewFooter];

		CGAffineTransform transform = self.imgViewFooter.transform;
		transform = CGAffineTransformMake(-1,0,0,1,0,0);
		transform = CGAffineTransformRotate(transform, M_PI);
		
		self.imgViewFooter.transform = transform;
		
		
		UIButton *setup_btn = [[UIButton alloc] initWithFrame:CGRectMake(320-42-5, 480-54-5, 42, 54)];
		[setup_btn setImage:[UIImage imageNamed:@"free_adv_money_bag.png"] forState:UIControlStateNormal];
		[setup_btn setImage:[UIImage imageNamed:@"free_adv_money_bag_open.png"] forState:UIControlStateHighlighted];
		[setup_btn addTarget:self action:@selector(goToSetup) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:setup_btn];
		[setup_btn release];
		
		UIAccelerometer *acc = [UIAccelerometer sharedAccelerometer];
		acc.delegate = self;
		acc.updateInterval = 1.0 / 6.0;

		
	}
	
	return self;
}

- (void)setAnimationTimer:(NSTimer *)newTimer 
{
	[animationTimer invalidate];
	animationTimer = newTimer;
}

- (void)startAnimation {
	
	if (self.status) {
		
		offset = 8;
		flagM = 'A'; //正反面标示
		flagW = '-'; //增减标示
		flagH = '^'; //高度标示
		flagS = 99;
		
		self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.003 target:self selector:@selector(update:) userInfo:nil repeats:YES];
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"CoinStart" ofType:@"wav"];
		AVAudioPlayer *switchAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
		//switchAudio.numberOfLoops = 1;
		switchAudio.delegate = self;
		[switchAudio play];
		self.status = NO;
	}
	
}


- (id)coinType {

	if (coinType == nil) {
		
		coinType = [[CoinTypeViewController alloc] _init:freeCoins CVC:self];
	}
	return coinType;
}


- (UINavigationController *)coinTypeNavigationController {
    if (coinTypeNavigationController == nil) {
        coinTypeNavigationController = [[UINavigationController alloc] initWithRootViewController:self.coinType];
		UIBarButtonItem *doneItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.coinType action:@selector(returnToIndex)] autorelease];
		self.coinType.navigationItem.rightBarButtonItem = doneItem;
		self.coinType.title = @"Coin Type";
    }
    return coinTypeNavigationController;
}

- (void)changeCoin:(int)INDEX {

	index = INDEX;
	[imgA release];
	[imgB release];
	//图片A面
	imgA = [[UIImage imageNamed:[[freeCoins objectAtIndex:index] objectForKey:@"big_image_obverse"]] retain];
	//图片B面
	imgB = [[UIImage imageNamed:[[freeCoins objectAtIndex:index] objectForKey:@"big_image_reverse"]] retain];
	
	[imgView setImage:imgA];
	[imgViewFooter setImage:imgA];
}


- (void)goToSetup {

	[self presentModalViewController:self.coinTypeNavigationController animated:YES];
}

- (void)stopAnimation {

	//[animationTimer invalidate];
	self.animationTimer = nil;
	//[animationTimer release];
	self.status = YES;

	
}

- (void)update:(NSTimer*)theTimer {
	
	CGRect rect = imgView.frame;
	CGRect rect_footer = imgViewFooter.frame;
	
	if (flagM == 'A') {
		
		[imgView setImage:imgA];
		if (flagW == '-') {
			
			rect.size.height = rect.size.height - offset;
			rect.origin.y = rect.origin.y + offset / 2;
			if (rect.size.height <= 0.0) {
				
				flagM = 'B';
				flagW = '+';
			}
		}
		
		if (flagW == '+') {
			
			rect.size.height = rect.size.height + offset;
			rect.origin.y = rect.origin.y - offset / 2;
			if (rect.size.height >= 160.0) {
				
				flagW = '-';
			}
		}
	}
	
	if (flagM == 'B') {
		
		[imgView setImage:imgB];
		
		
		if (flagW == '-') {
			
			rect.size.height = rect.size.height - offset;
			rect.origin.y = rect.origin.y + offset / 2;
			if (rect.size.height <= 0.0) {
				
				flagM = 'A';
				flagW = '+';
			}
		}
		
		if (flagW == '+') {
			
			rect.size.height = rect.size.height + offset;
			rect.origin.y = rect.origin.y - offset / 2;
			if (rect.size.height >= 160.0) {
				
				flagW = '-';
			}
		}
	}
	
	if (flagH == '^') {
		
		
		
		if(rect.origin.y <= 120.0) {
			
			rect.origin.y = rect.origin.y - offset / 160;
			rect_footer.origin.y = rect_footer.origin.y + offset / 160;
			
		} else {
			
			rect.origin.y = rect.origin.y - offset / 10;
			rect_footer.origin.y = rect_footer.origin.y + offset / 10;
		}

		
		if (rect.origin.y <= 60.0) {
			
			flagH = '_';
		}
	}
	
	if (flagH == '_') {
		
		
		
		if(rect.origin.y <= 120.0) {
			
			rect.origin.y = rect.origin.y + offset / 160;
			rect_footer.origin.y = rect_footer.origin.y - offset / 160;
			
		} else {
			
			rect.origin.y = rect.origin.y + offset / 10;
			rect_footer.origin.y = rect_footer.origin.y - offset / 10;
		}
		
		
		if (rect.origin.y >= 260.0) {
			
			flagH = 'Z';
			flagM = 'Z';
			//[self stopAnimation];
			flagS = 0;
			
		}
	}
	
	
	
	if (flagS == 0) {
		
		int rand = time((time_t *)NULL);
		if(rand % 2)
		{
			[imgView setImage:imgA];
			[imgViewFooter setImage:imgA];
			
		} else {
			
			[imgView setImage:imgB];
			[imgViewFooter setImage:imgB];
		}

		
		rect = CGRectMake(80, 260, 160, 160);
		rect_footer = CGRectMake(80, 420, 160, 160);
		flagS = 1;
		NSString *path = [[NSBundle mainBundle] pathForResource:@"EndCoin-small" ofType:@"wav"];
		AVAudioPlayer *switchAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
		//switchAudio.numberOfLoops = 1;
		switchAudio.delegate = self;
		[switchAudio play];
	}
	
	else if (flagS == 1) {
		
		
		if(rect.origin.y <= 190.0) {
			
			rect.origin.y = rect.origin.y - 0.05;
			rect_footer.origin.y = rect_footer.origin.y + 0.05;
			
			
		} else {
			
			rect.origin.y = rect.origin.y - 0.5;
			rect_footer.origin.y = rect_footer.origin.y + 0.5;
		}
		
		if (rect.origin.y <= 200) {
			
			flagS = 2;
		}
	}
	
	else if (flagS == 2) {
		
		
		if(rect.origin.y <= 190.0) {
			
			rect.origin.y = rect.origin.y + 0.05;
			rect_footer.origin.y = rect_footer.origin.y - 0.05;
			
		} else {
			
			rect.origin.y = rect.origin.y + 0.5;
			rect_footer.origin.y = rect_footer.origin.y - 0.5;
		}
		
		if (rect.origin.y >= 260.0) {
			
			flagS = 3;
			
		}
	}
	
	else if (flagS == 3) {
		
		rect.origin.y = rect.origin.y - 0.5;
		rect_footer.origin.y = rect_footer.origin.y + 0.5;
		if (rect.origin.y <= 240) {
			
			flagS = 4;
		}
	}
	
	else if (flagS == 4) {
		
		rect.origin.y = rect.origin.y + 0.5;
		rect_footer.origin.y = rect_footer.origin.y - 0.5;
		if (rect.origin.y >= 260) {
			
			flagS = 5;
		}
	}
	
	else if (flagS == 5) {
		
		[self stopAnimation];
	}

	
	
	imgView.frame = rect;
	imgViewFooter.frame = rect_footer;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
	[self stopAnimation];
	[freeCoins release];
	[imgView release];
	[imgViewFooter release];
	[imgB release];
	[imgA release];
	[coinType release];
	[coinTypeNavigationController release];
	[adMobAd release];
	[refreshTimer invalidate];
    [super dealloc];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)audio successfully:(BOOL)sflag {
	
    [audio release];
}




//ACC DELEGATE

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {

	
	if (fabsf(acceleration.x) > 2.0 || fabsf(acceleration.y) > 2.0 || fabsf(acceleration.z) > 2.0) {
		
		[self startAnimation];
	}
	
	
}






// Request a new ad. If a new ad is successfully loaded, it will be animated into location.
- (void)refreshAd:(NSTimer *)timer {
	[adMobAd requestFreshAd];
}

#pragma mark -
#pragma mark AdMobDelegate methods

- (NSString *)publisherId {
	return @"a14bd1a8846ef86"; // this should be prefilled; if not, get it from www.admob.com
}

- (UIViewController *)currentViewController {
	return self;
}

- (UIColor *)adBackgroundColor {
	return [UIColor colorWithRed:0 green:0 blue:0 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (UIColor *)primaryTextColor {
	return [UIColor colorWithRed:1 green:1 blue:1 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

- (UIColor *)secondaryTextColor {
	return [UIColor colorWithRed:1 green:1 blue:1 alpha:1]; // this should be prefilled; if not, provide a UIColor
}

// To receive test ads rather than real ads...
/*
 // Test ads are returned to these devices.  Device identifiers are the same used to register
 // as a development device with Apple.  To obtain a value open the Organizer 
 // (Window -> Organizer from Xcode), control-click or right-click on the device's name, and
 // choose "Copy Device Identifier".  Alternatively you can obtain it through code using
 // [UIDevice currentDevice].uniqueIdentifier.
 //
 // For example:
 //    - (NSArray *)testDevices {
 //      return [NSArray arrayWithObjects:
 //              ADMOB_SIMULATOR_ID,                             // Simulator
 //              //@"28ab37c3902621dd572509110745071f0101b124",  // Test iPhone 3GS 3.0.1
 //              //@"8cf09e81ef3ec5418c3450f7954e0e95db8ab200",  // Test iPod 2.2.1
 //              nil];
 //    }
 
 - (NSArray *)testDevices {
 return [NSArray arrayWithObjects: ADMOB_SIMULATOR_ID, nil];
 }
 
 - (NSString *)testAdAction {
 return @"url"; // see AdMobDelegateProtocol.h for a listing of valid values here
 }
 */

// Sent when an ad request loaded an ad; this is a good opportunity to attach
// the ad view to the hierachy.
- (void)didReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did receive ad");
	// get the view frame
	CGRect frame = self.view.frame;
	
	// put the ad at the bottom of the screen
	adMobAd.frame = CGRectMake(0, 0, frame.size.width, 48);
	
	[self.view addSubview:adMobAd];
	[refreshTimer invalidate];
	refreshTimer = [NSTimer scheduledTimerWithTimeInterval:AD_REFRESH_PERIOD target:self selector:@selector(refreshAd:) userInfo:nil repeats:YES];
}

// Sent when an ad request failed to load an ad
- (void)didFailToReceiveAd:(AdMobView *)adView {
	NSLog(@"AdMob: Did fail to receive ad");
	[adMobAd removeFromSuperview];  // Not necessary since never added to a view, but doesn't hurt and is good practice
	[adMobAd release];
	adMobAd = nil;
	// we could start a new ad request here, but in the interests of the user's battery life, let's not
}


@end
