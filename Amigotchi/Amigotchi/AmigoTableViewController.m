//
//  AmigoTableViewController.m
//  Amigotchi
//
//  Created by Kareem Nassar on 5/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AmigoTableViewController.h"
#import "AmigoCheckinViewController.h"
#import "AppDelegate.h"

@implementation AmigoTableViewController

@synthesize placesArray = placesArray_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.title = @"Checkins";
        self.placesArray = [NSArray array];
        
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        AmigoAPI *api = [app api];
        api.checkintable = self;
        
        
    }
    return self;
}

- (void) setPlacesArray:(NSArray *)placesArray {

    [placesArray_ release];
    placesArray_ = [placesArray retain];
    [self.tableView reloadData];
    
    if ([placesArray count] > 0) {
        
        [spinner stopAnimating];
        [spinner release];
        spinner = nil;
    }
    
}


- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if( spinner == nil){
       spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    
    [spinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)]; // I do this because I'm in landscape mode
    [self.tableView addSubview:spinner];
    [self.tableView bringSubviewToFront:spinner];
    
    [spinner startAnimating];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.placesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
    
	cell.textLabel.text = (NSString *)[[self.placesArray objectAtIndex:indexPath.row] objectForKey:@"name"];
	cell.detailTextLabel.text = (NSString *)[[self.placesArray objectAtIndex:indexPath.row] valueForKeyPath:@"location.street"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AmigoCheckin *checkin = [[AmigoCheckin alloc] init];
    
    checkin.title = (NSString *)[[self.placesArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    checkin.place_id = [[self.placesArray objectAtIndex:indexPath.row] objectForKey:@"id"];
        
    NSDictionary *location = [[self.placesArray objectAtIndex:indexPath.row] objectForKey:@"location"];
    checkin.lat = [location objectForKey:@"latitude"] ;
    checkin.lon = [location objectForKey:@"longitude"] ;
    
        
    // Navigation logic may go here. Create and push another view controller.
    
    AmigoCheckinViewController *checkinViewController = [[AmigoCheckinViewController alloc] initWithNibName:nil bundle:nil];
    checkinViewController.checkin = checkin;
    [checkin release];
    
    [self.navigationController pushViewController:checkinViewController animated:YES];
    [checkinViewController release];
     
}

@end
