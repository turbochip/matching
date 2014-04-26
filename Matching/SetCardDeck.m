//
//  SetCardDeck.m
//  Matching
//
//  Created by Cox, Chip on 4/26/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "SetCardDeck.h"
#import "gSetPlayingCard.h"

@implementation SetCardDeck

-(instancetype)init
{
    self = [super init];
    
    if(self){
        for (NSString *shape in [gSetPlayingCard validShapes]) {
            for (NSInteger quantity = 1; quantity <= 3; quantity++) {
                for (UIColor * color in gSetPlayingCard.validColors) {
                    for(NSInteger fill=1; fill<=3; fill++) {
                        gSetPlayingCard *card = [[gSetPlayingCard alloc] init];
                        card.cardShape=shape;
                        card.cardQuantity = quantity;
                        card.cardColor=color;
                        card.cardFill=fill;
                        [self addCard:card];
                        NSLog(@"%@",[card contents]);
                    }
                }
            }
        }
    }
    return self;
}

@end
