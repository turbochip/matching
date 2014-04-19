//
//  gSetPlayingCard.m
//  Matching
//
//  Created by Cox, Chip on 4/19/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "gSetPlayingCard.h"

@implementation gSetPlayingCard


-(NSString *)contents
{
    NSArray *rankStrings = [gSetPlayingCard rankStrings];
    return [rankStrings[self.Rank] stringByAppendingString:self.Suit];
}

@synthesize Suit = _suit;

+(NSArray *)validSuits
{
    return @[@"⬜️",@"⚪️",@"♣️"];
}

-(void)setSuit:(NSString *)suit
{
    if([[gSetPlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3"];
}


@end
