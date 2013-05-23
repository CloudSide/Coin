//
//  CoinTypeViewController.m
//  Coin
//
//  Created by xiaoli on 10-4-21.
//  Copyright 2010 bict. All rights reserved.
//

#import "CoinTypeViewController.h"
#import "CoinViewController.h"


@implementation CoinTypeViewController

@synthesize coinSelection;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/

- (id)_init:(NSArray *)arr CVC:(CoinViewController *)CVC{

	if (self = [super init]) {
		
		_arr = arr;
		cvc = CVC;
		
		UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 436) style:UITableViewStyleGrouped];
		table.delegate = self;
		table.dataSource = self;
		[self.view addSubview:table];
		[table release];
		
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		NSString *path = [documentsDirectory stringByAppendingPathComponent:@"selected_data.plist"];
		NSArray *selected_data = [NSArray arrayWithContentsOfFile:path];
		if (selected_data == nil) {
			
			self.coinSelection = [NSIndexPath indexPathForRow:0 inSection:0];
			
		} else {
			
			int row = [[selected_data objectAtIndex:0] intValue];
			int section = [[selected_data objectAtIndex:1] intValue];
			self.coinSelection = [NSIndexPath indexPathForRow:row inSection:section];
		}

		
		
	}
	
	return self;
}


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    //self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	

	
}

- (void)returnToIndex {

	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"selected_data.plist"];
	NSString *row = [NSString stringWithFormat:@"%d",self.coinSelection.row];
	NSString *section = [NSString stringWithFormat:@"%d",self.coinSelection.section];
	
	NSArray *selected_data = [NSArray arrayWithObjects:row,section,nil];
	
	[selected_data writeToFile:path atomically:YES];
	[cvc changeCoin:self.coinSelection.row];
	
	
	[self dismissModalViewControllerAnimated:YES];
}


//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_arr count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    	
	UILabel *name = [[[UILabel alloc] initWithFrame:CGRectMake(10, 20, 120, 20)] autorelease];
    [name setBackgroundColor:[UIColor clearColor]];
	name.text = [[_arr objectAtIndex:indexPath.row] objectForKey:@"name"];
	[cell.contentView addSubview:name];
	
	
	UILabel *type = [[[UILabel alloc] initWithFrame:CGRectMake(10, 47, 120, 13)] autorelease];
    [type setBackgroundColor:[UIColor clearColor]];
	type.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
	type.text = [[_arr objectAtIndex:indexPath.row] objectForKey:@"coin_type"];
	type.textColor = [UIColor grayColor];
	[cell.contentView addSubview:type];
	
	
	UIImageView *imgViewA = [[[UIImageView alloc] initWithFrame:CGRectMake(120, 10, 60, 60)] autorelease];
	UIImageView *imgViewB = [[[UIImageView alloc] initWithFrame:CGRectMake(190, 10, 60, 60)] autorelease];
	[imgViewA setImage:[UIImage imageNamed:[[_arr objectAtIndex:indexPath.row] objectForKey:@"small_image_obverse"]]];
	[imgViewB setImage:[UIImage imageNamed:[[_arr objectAtIndex:indexPath.row] objectForKey:@"small_image_reverse"]]];
	[cell.contentView addSubview:imgViewA];
	[cell.contentView addSubview:imgViewB];
	
	
    
	cell.accessoryType = ([indexPath isEqual:coinSelection]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
	
	return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	self.coinSelection = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	return 80.0;
}



#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	
	[coinSelection release];
    [super dealloc];
}


@end

