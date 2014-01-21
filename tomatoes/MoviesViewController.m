//
//  MoviesViewController.m
//  tomatoes
//
//  Created by malena mesarina on 1/17/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailControllerViewController.h"
#import "MBProgressHUD.h"

#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "YRDropdownView.h"


@interface MoviesViewController ()
@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) NSArray *arrayOfMovies;
@property (nonatomic, strong) NSMutableArray *my_movies;


-(void) reload;
-(void) doSomeFunkyStuff;
- (BOOL) connectedToNetwork;
- (BOOL) checkInternet;


@end

@implementation MoviesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self reload];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self reload];
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [super viewDidLoad];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.labelText = @"Loading movie data";
    HUD.detailsLabelText = @"Just relax";
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    [self.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(doSomeFunkyStuff) onTarget:self withObject:nil animated:YES];
    
    //Refresh Control
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self
        action:@selector(refreshView:)
        forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    
    
}

- (void)doSomeFunkyStuff {
    float progress = 0.0;
    while (progress < 1.0) {
        progress += 0.01;
        HUD.progress = progress;
        usleep(50000);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.my_movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Movie *movie = [self.my_movies objectAtIndex:indexPath.row];
    cell.movieTitleLabel.text = movie.title;
    
    cell.synopsisLabel.text = movie.synopsis;
    cell.castLabel.text = movie.cast;
    
    // check network
    //if ([self checkInternet])
    
    
        // Load image with AIFNetworking
    
    if ([self checkInternet] == YES ) {
        __weak UITableViewCell *weakCell = cell;

    
        [cell.imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:movie.thumbnailURL]]
                          placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                       weakCell.imageView.image = image;
                                     
                                       [weakCell setNeedsLayout];
                                       
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
                                       
                                   }];
    
    
    
    
    
        return cell;
    }
    else {
        return nil;
    }
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieDetailController *movieDetailController=[[movieDetailController alloc]   initWithNibName:@"AnotherViewController" bundle:nil];
    [self.navigationController pushViewController:anotherViewController animated:YES];
    
    NSLog(@"didSelectRowAtIndexPath: row=%d", indexPath.row);
    
}
 */

#pragma mark - Private methods

- (void) reload
{

    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    if ([self checkInternet] == YES ) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.arrayOfMovies = [object objectForKey:@"movies"];
            self.my_movies = [[NSMutableArray alloc] init];
            for (NSDictionary *d in self.arrayOfMovies ) {
            
                Movie *movie = [[Movie alloc] initWithDictionary:d];
                [self.my_movies addObject:movie];
            
            
            }
        
        
            // NSLog(@"number of movies = %d", arrayOfMovies.count);
            [self.tableView reloadData];
        

        
        }];
    
    } else {
        NSLog(@"NO INTERNET");
    }
        
    
    
    
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMovieDetailView"]) {
        MovieDetailControllerViewController *controller = (MovieDetailControllerViewController *)segue.destinationViewController;
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        Movie *movie = [self.my_movies objectAtIndex:selectedIndex];
        
        //NSLog(@"title, %@", movie.title);
        //NSLog(@"synopsis, %@", movie.synopsis);
        //NSLog(@"cast, %@", movie.cast);
        //NSLog(@"ratings, %@",movie.ratings);
        controller.movieDetails = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   movie.title, @"title", movie.synopsis, @"synopsis", movie.cast, @"cast", movie.critics_rating, @"rating", movie.thumbnailURL, @"thumbnailURL", nil];
  
        
    }
}

#pragma mark - Network Reachability

- (BOOL) connectedToNetwork
{
	Reachability *r = [Reachability reachabilityWithHostName:@"www.google.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	BOOL internet;
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
		internet = NO;
	} else {
		internet = YES;
	}
	return internet;
}

-(BOOL) checkInternet
{
	//Make sure we have internet connectivity
	if([self connectedToNetwork] != YES)
	{
        
        /*
		[self showMessage: @"No network connection found. An Internet connection is required for this application to work"
				withTitle:@"No Network Connectivity!"];
         */
        
        [YRDropdownView showDropdownInView:self.view
                                     title:@"Network Error"
                                    detail:@"No network connection found. An internet connection is required for htis application to work"];
        
		return NO;
	}
	else {
		return YES;
        [YRDropdownView hideDropdownInView:self.view];
	}
}

//Refresh Control

-(void)refreshView:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
  
      // custom refresh logic would be placed here...
    [self reload];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@", [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [refresh endRefreshing];
}

@end
