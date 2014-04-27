//
//  SetGame.m
//  Matching
//
//  Created by Cox, Chip on 4/26/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "SetGame.h"

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
    NSLog(@"%@",card.contents);
    if (!card.isMatched) {
        self.score-=COST_TO_CHOOSE;
        if (card.isChosen) {
            if(self.chosenCards.count==1){
                [self.chosenCards removeObject:card];
                card.chosen=NO;  // if card is not already matched and is the only card chosen, reset it to chosen no
            }
        } else {  //this is a valid card to test it's not already matched
            //and we aren't resetting choosen status
            // so add it to the list of chosenCards.
            [self.chosenCards addObject:card];
            card.chosen=YES;
            if(self.chosenCards.count==self.MATCH_COUNT) {
                NSLog(@"score1=%d",self.score);
                self.score+=self.calcScore;
                NSLog(@"score2=%d",self.score);
                self.chosenCards=nil;
            }
        }
    }
}

- (NSInteger)calcScore
{
    int matchScore=0, matchTest=0;
    NSString *statusString=@" ";
    NSLog(@"MATCH_COUNT=%d",self.MATCH_COUNT);
    for (int j=0;j<self.MATCH_COUNT-1;j++) {
        Card *card = self.chosenCards[j];
        for (int i=j+1;i<self.MATCH_COUNT;i++) {
            Card *otherCard=self.chosenCards[i];
            NSLog(@"matchTest1=%d",matchTest);
            matchTest += [card match:@[otherCard]];
            NSLog(@"matchTest2-1=%d,j=%d,i=%d",matchTest,j,i);
            if(matchTest){
                NSLog(@"Testing %@ %@ %d",card.contents,otherCard.contents,matchTest);
                matchScore+=matchTest * MATCH_BONUS;
                NSLog(@"matchTest2-2=%d matchScore=%d",matchTest,matchScore);
            } else {
                NSLog(@"matchTest2-3=%d matchScore=%d",matchTest,matchScore);
                matchScore-=MISMATCH_PENALTY;
                NSLog(@"matchTest2-4=%d matchScore=%d",matchTest,matchScore);
            }
        }
    }
    
    for(Card *otherCard in self.chosenCards) {
        [statusString stringByAppendingFormat:@"%@,",otherCard.contents];
        if(matchTest) {
            otherCard.matched=YES;
        } else {
            otherCard.matched = NO;
            otherCard.chosen=NO;
        }
    }
    
    if(matchTest>0) {
        statusString=[statusString stringByAppendingFormat:@" Matches for %d Points",matchTest];
    }else {
        statusString=[statusString stringByAppendingFormat:@" Does not match for %d Points",matchTest];
    }
    
    self.result=statusString;
    self.chosenCards=nil;
    return matchScore;
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
