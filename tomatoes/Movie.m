//
//  Movie.m
//  tomatoes
//
//  Created by malena mesarina on 1/17/14.
//  Copyright (c) 2014 malena mesarina. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(id) initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self  ) {
        self.title = dictionary[@"title"];
        self.synopsis = dictionary[@"synopsis"];
       
        self.cast =  [self casting:dictionary[@"abridged_cast"]];
        NSDictionary  *posters = [[NSDictionary alloc]init];
        posters = dictionary[@"posters"];
        self.thumbnailURL = posters[@"detailed"];
        NSDictionary *ratings = [[NSDictionary alloc] init];
        ratings = dictionary[@"ratings"];
        self.critics_rating = ratings[@"critics_rating"];
        
        NSLog(@"Title = %@",self.title);
        //NSLog(@"Thumbnail = %@", self.thumbnailURL);
        //NSLog(@"Synopsis = %@",self.synopsis);
        //NSLog(@"Cast = %@", self.cast);
        NSLog(@"Ratings = %@", self.critics_rating);
    }
    return self;
}


-(NSString *) casting: (NSArray*) castArray {
    
    NSMutableArray *stringsArray = [[NSMutableArray alloc]init];
    NSString *combined;
    for (NSDictionary *castD in castArray) {
      
        [stringsArray addObject:[castD objectForKey:@"name"]];
        combined = [stringsArray componentsJoinedByString:@","];
        //castString = [castString stringByAppendingString:[castD objectForKey:@"name"]];
      //  castString = [castString stringByAppendingString:@','];
        
        //NSLog(@"Name = %@",[castD objectForKey:@"name"]);
    }
    
    return combined;
    
}


@end
