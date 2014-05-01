//
//  SetGame.m
//  Matching
//
//  Created by Cox, Chip on 4/26/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "SetGame.h"
#import "CardGameGlobal.h"

@interface SetGame()  //This area which we added is for locl private properties
@property (nonatomic, readwrite) NSInteger score;  // Here in thes re-definition of the
//score public property in the .h file
// we are defining score as RW so that we
// can set the score in the module, but the
// public version is RO so that other modules
// can't adjust the score just read it.
@property (nonatomic, strong) NSMutableArray *cards; // of card
@property (nonatomic,strong) NSMutableArray *chosenCards;

@end

@implementation SetGame

 - (NSMutableArray *)cards  // is this the getter for cards??
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

/* this selects the cards for the board */
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(gSetDeck *)deck
{
    self=[super init];
    if(self) {
        for (int i=0; i<count; i++) {
            gSetCard *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
            
        }
    }
    return self;
}

- (gSetCard *)cardAtIndex:(NSUInteger) index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MATCH_COUNT=3;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    gSetCard *card = [self cardAtIndex:index];  // card is the card we just clicked on
    NSLog(@"SetGame chooseCardAtIndex = %@",card.contents);
    if (!card.isMatched) {
        if (card.isChosen) {
            if(self.chosenCards.count<MATCH_COUNT){
                [self.chosenCards removeObject:card];
                card.chosen=NO;  // if card is not already matched 
            }
        } else {  //this is a valid card to test it's not already matched
            //and we aren't resetting choosen status
            // so add it to the list of chosenCards.
            [self.chosenCards addObject:card];
            card.chosen=YES;
            if(self.chosenCards.count==MATCH_COUNT) {
                self.score+=self.calcScore;
                self.chosenCards=nil;
            }
        }
    }
}

- (NSInteger)calcScore
{
    int matchTest=0;
    
//    gSetCard *otherCard=self.chosenCards;
    matchTest += [self.chosenCards[0] match:self.chosenCards];
    if(matchTest){
        NSLog(@"matchTest Success");
        for (gSetCard *card in self.chosenCards)
        {
            card.chosen=NO;
            card.matched=YES;
        }
    } else {
        NSLog(@"matchTest Failure");
        for(gSetCard *card in self.chosenCards)
        {
            card.chosen=NO;
            card.matched=NO;
        }
    }
    return matchTest;
}

- (NSInteger) score
{
    if(!_score)_score=0;
    return(_score);
}

- (NSInteger) MATCH_COUNT
{
    if(!_MATCH_COUNT) _MATCH_COUNT=2;
    return _MATCH_COUNT;
}

- (NSMutableArray *) chosenCards
{
    if(!_chosenCards) _chosenCards=[[NSMutableArray alloc] init];
    return _chosenCards;
}


@end
