//
//  CardMatchingGame.h
//  Matching
//
//  Created by Cox, Chip on 4/5/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated initializer  (whatever that means)
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (NSInteger)calcScore;
@property (nonatomic,readonly) NSInteger score;
@property (nonatomic,strong) NSString *result;
@property (nonatomic,readwrite) NSInteger MATCH_COUNT;

@end
