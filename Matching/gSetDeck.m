//
//  gSetDeck.m
//  Matching
//
//  Created by Cox, Chip on 4/27/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "gSetDeck.h"
#import "CardGameGlobal.h"

@interface gSetDeck()
//@property (strong,nonatomic) NSMutableArray *cards; //of PlayingCard
@end

@implementation gSetDeck

- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(void)addCard:(gSetCard *)card atTop:(BOOL)atTop
{
    if(atTop) {
        [self.cards insertObject:card atIndex:0];
    }
    else {
        NSLog(@"Adding Card %@",card.contents);
        [self.cards addObject:card];
    }
}

-(void)addCard:(gSetCard *)card {
    [self addCard:card atTop:NO];
}

-(gSetCard *)drawRandomCard
{
    gSetCard *randomCard = nil;
    
    if ([self.cards count]){
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
