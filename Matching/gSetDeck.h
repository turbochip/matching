//
//  gSetDeck.h
//  Matching
//
//  Created by Cox, Chip on 4/27/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "Deck.h"
#import "gSetPlayingCard.h"
@interface gSetDeck : Deck

//-(void)addCard:(gSetCard *)card atTop:(BOOL)atTop;
//-(void)addCard:(gSetCard *)card;

-(gSetCard *)drawRandomCard;
@property (strong,nonatomic) NSMutableArray *cards; //of PlayingCard


@end
