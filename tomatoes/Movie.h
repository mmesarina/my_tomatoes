//
//  Movie.h
//  tomatoes
//
//  Created by malena mesarina on 1/17/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *synopsis;

@property (nonatomic, strong) NSString *cast;
@property (nonatomic, strong) NSString *critics_rating;


@property (nonatomic, strong) NSString *thumbnailURL;

- (id) initWithDictionary: (NSDictionary *) dictionary;
- (NSString *) casting: (NSArray*) cast_array;

@end
