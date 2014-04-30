//
//  SetCardDeck.m
//  Matching
//
//  Created by Cox, Chip on 4/26/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "SetCardDeck.h"
#import "gSetPlayingCard.h"
#import "CardGameGlobal.h"

@implementation SetCardDeck

-(instancetype)init
{
    self = [super init];
    
    if(self){
        for (NSString *shape in [gSetPlayingCard validShapes]) {
//            NSLog(@"%@",shape);
            for (NSInteger quantity = 1; quantity <= 3; quantity++) {
//                NSLog(@"%d",quantity);
                for (UIColor * color in gSetPlayingCard.validColors) {
//                    NSLog(@"%@",color.description );
                    for(NSInteger fill=1; fill<=3; fill++) {
//                        NSLog(@"%d",fill);
                        gSetPlayingCard *card = [[gSetPlayingCard alloc] init];
                        card.cardShape=shape;
                        card.cardQuantity = quantity;
                        card.cardColor=color;
                        card.cardFill=fill;
                        NSLog(@"SetCardDeck Init = %@",[card contents]);

                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
