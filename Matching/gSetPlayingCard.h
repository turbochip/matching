//
//  gSetPlayingCard.h
//  Matching
//
//  Created by Cox, Chip on 4/19/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "Card.h"

@interface gSetPlayingCard : Card

@property (nonatomic,strong) NSString * Suit;
@property (nonatomic) NSUInteger Rank;
@property (nonatomic,strong) NSString * Fill;
@property (nonatomic,strong) NSString * Color;
@end
