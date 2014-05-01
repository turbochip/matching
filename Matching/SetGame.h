//
//  SetGame.h
//  Matching
//
//  Created by Cox, Chip on 4/26/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gSetDeck.h"
#import "gSetCard.h"
#import "CardMatchingGame.h"
@interface SetGame : NSObject
//@interface SetGame : CardMatchingGame

//designated initializer  (whatever that means)
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(gSetDeck *)deck;

- (int) getCardsRemainingInDeck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (gSetCard *)cardAtIndex:(NSUInteger)index;
- (NSInteger)calcScore;

@property (nonatomic,readonly) NSInteger score;
@property (nonatomic,strong) NSString *result;
@property (nonatomic,readwrite) NSInteger MATCH_COUNT;


@end
