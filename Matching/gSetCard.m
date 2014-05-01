//
//  gSetCard.m
//  Matching
//
//  Created by Cox, Chip on 4/27/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "gSetCard.h"
#import "CardGameGlobal.h"
@interface gSetCard ()

@end
@implementation gSetCard

-(int) match:(NSArray *)otherCards
{
    int score = 0;
    BOOL colorOk=NO;
    BOOL shapeOk=NO;
    BOOL fillOk=NO;
    BOOL qtyOk=NO;
    CardGameGlobal *sharedGlobal = [CardGameGlobal sharedGlobal];

    [sharedGlobal logHistory:[[NSMutableAttributedString alloc] initWithString:@"Comparing\n"]];
    NSLog(@"Comparing ");
    for(int i=0;i<3;i++)
        NSLog(@"%@",[otherCards[i] contents] );
    
    if (([[otherCards[0] cardColor] isEqual: [otherCards[1] cardColor]]) &&
        ([[otherCards[0] cardColor] isEqual: [otherCards[2] cardColor]])) colorOk=YES;
    if (([[otherCards[0] cardShape] isEqual: [otherCards[1] cardShape]]) &&
        ([[otherCards[0] cardShape] isEqual: [otherCards[2] cardShape]])) shapeOk=YES;
    if (([otherCards[0] cardFill] == [otherCards[1] cardFill]) &&
        ([otherCards[0] cardFill] == [otherCards[2] cardFill])) fillOk=YES;
    if (([otherCards[0] cardQuantity] == [otherCards[1] cardQuantity]) &&
        ([otherCards[0] cardQuantity] == [otherCards[2] cardQuantity])) qtyOk=YES;
    
    if ((![[otherCards[0] cardColor] isEqual: [otherCards[1] cardColor]]) &&
        (![[otherCards[0] cardColor] isEqual: [otherCards[2] cardColor]]) &&
        (![[otherCards[1] cardColor] isEqual: [otherCards[2] cardColor]])) colorOk=YES;
    if ((![[otherCards[0] cardShape] isEqual: [otherCards[1] cardShape]]) &&
        (![[otherCards[0] cardShape] isEqual: [otherCards[2] cardShape]]) &&
        (![[otherCards[1] cardShape] isEqual: [otherCards[2] cardShape]])) shapeOk=YES;
    if ((!([otherCards[0] cardFill] == [otherCards[1] cardFill])) &&
        (!([otherCards[0] cardFill] == [otherCards[2] cardFill])) &&
        (!([otherCards[1] cardFill] == [otherCards[2] cardFill]))) fillOk=YES;
    if ((!([otherCards[0] cardQuantity] == [otherCards[1] cardQuantity])) &&
        (!([otherCards[0] cardQuantity] == [otherCards[2] cardQuantity])) &&
        (!([otherCards[1] cardQuantity] == [otherCards[2] cardQuantity]))) qtyOk=YES;
    
    if(colorOk && shapeOk && fillOk && qtyOk){
        [sharedGlobal logHistory:[[NSMutableAttributedString alloc] initWithString:@"Match\n"]];
        score=1;
    } else {
        [sharedGlobal logHistory:[[NSMutableAttributedString alloc] initWithString:@"No Match\n"]];
        score=0;
    }
    
    return score;
}

@end
