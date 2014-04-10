//
//  PlayingCard.h
//  Matching
//
//  Created by Chip Cox on 3/30/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *) validSuits;
+(NSUInteger)maxRank;

@end
