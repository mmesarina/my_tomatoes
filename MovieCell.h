//
//  MovieCell.h
//  tomatoes
//
//  Created by malena mesarina on 1/17/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *movieTitleLabel;
@property   (nonatomic, weak) IBOutlet UILabel *synopsisLabel;

@end
