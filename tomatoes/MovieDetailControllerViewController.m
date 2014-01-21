//
//  MovieDetailControllerViewController.m
//  tomatoes
//
//  Created by malena mesarina on 1/19/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "MovieDetailControllerViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailControllerViewController ()
- (void) reload;

@end

@implementation MovieDetailControllerViewController
@synthesize  this_title;
@synthesize  this_rating;
@synthesize  this_synopsis;
@synthesize  this_cast;
@synthesize movieDetails;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self reload];
    
    // Load image with AIFNetworking
}

- (void) reload
{
    self.this_title.text = [movieDetails objectForKey:@"title"];
    self.this_synopsis.text = [movieDetails objectForKey:@"synopsis"];
    self.this_rating.text = [movieDetails objectForKey:@"rating"];
    self.this_cast.text = [movieDetails objectForKey:@"cast"];
    
    NSString *urlString = [movieDetails objectForKey:@"thumbnailURL"];
    
    // Load image with AIFNetworking
    
    
     [self.this_thumbnail setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]]
     placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
     self.this_thumbnail.image = image;
     
     //[ setNeedsLayout];
     
     }
     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
     
     }];
     
     
     
     

    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
