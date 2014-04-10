//
//  CardMatchingGame.m
//  Matching
//
//  Created by Cox, Chip on 4/5/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()  //This area which we added is for locl private properties
@property (nonatomic, readwrite) NSInteger score;  // Here in thes re-definition of the
                                                    //score public property in the .h file
                                                    // we are defining score as RW so that we
                                                    // can set the score in the module, but the
                                                    // public version is RO so that other modules
                                                    // can't adjust the score just read it.
@property (nonatomic, strong) NSMutableArray *cards; // of card
@property (nonatomic,strong) NSMutableArray *chosenCards;

@end

@implementation CardMatchingGame
- (NSMutableArray *)cards  // is this the getter for cards??
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self=[super init];
    if(self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
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

- (Card *)cardAtIndex:(NSUInteger) index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
//static const int MATCH_COUNT=2;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];  // card is the card we just clicked on
    
    if (!card.isMatched) {
        self.score-=COST_TO_CHOOSE;
        if (card.isChosen) {
            if(self.chosenCards.count==1){
                [self.chosenCards removeObject:card];
                card.chosen=NO;  // if card is not already matched and is the only card chosen, reset it to chosen no
                self.score+=COST_TO_CHOOSE;
            }
        } else {  //this is a valid card to test it's not already matched
                  //and we aren't resetting choosen status
            // so add it to the list of chosenCards.
            [self.chosenCards addObject:card];
            card.chosen=YES;
            if(self.chosenCards.count==_MATCH_COUNT) {
                self.score=self.calcScore;
                self.chosenCards=nil;
            }
        }
    }
}

- (NSInteger)calcScore
{
    int matchScore=0, matchTest=0;
    NSString *statusString=@" ";
    for (int j=0;j<_MATCH_COUNT-1;j++) {
        Card *card = self.chosenCards[j];
        for (int i=j+1;i<_MATCH_COUNT;i++) {
            Card *otherCard=self.chosenCards[i];
            matchTest = [card match:@[otherCard]];
            if(matchTest){
                matchScore+=matchTest;
                NSLog(@"Testing %@ %@ %d",card.contents,otherCard.contents,matchTest);
                statusString = [statusString stringByAppendingFormat:@"%@,%@ Match for %d",card.contents,otherCard.contents,matchTest];
                self.result=statusString;
                
            }
        }
    }
    matchTest=matchScore;
//    for (int i=0;i<_MATCH_COUNT;i++) {
    for(Card *otherCard in self.chosenCards) {
//        Card *otherCard=self.chosenCards[i];
        if(matchTest) {
            matchScore+=matchScore *MATCH_BONUS;
            otherCard.matched=YES;
        } else {
            matchScore -= MISMATCH_PENALTY;
            otherCard.matched = NO;
            otherCard.chosen=NO;
        }
    }
    self.chosenCards=nil;
    return matchScore;
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
