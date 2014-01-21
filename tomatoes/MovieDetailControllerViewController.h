//
//  MovieDetailControllerViewController.h
//  tomatoes
//
//  Created by malena mesarina on 1/19/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailControllerViewController : UIViewController


@property (nonatomic, strong) IBOutlet UILabel *this_title;
@property (nonatomic, strong) IBOutlet UILabel *this_rating;
@property (nonatomic, strong) IBOutlet UILabel *this_synopsis;
@property (nonatomic, strong) IBOutlet UILabel *this_cast;
@property (nonatomic, weak) IBOutlet UIImageView *this_thumbnail;
@property (strong, nonatomic) NSDictionary *movieDetails;


@end
