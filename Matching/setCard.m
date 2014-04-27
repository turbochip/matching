//
//  setCard.m
//  Matching
//
//  Created by Cox, Chip on 4/26/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "setCard.h"

@implementation setCard
-(int) match:(NSArray *)otherCards
{
    int score = 0;
    BOOL colorOk=NO;
    BOOL shapeOk=NO;
    BOOL fillOk=NO;
    BOOL qtyOk=NO;
    
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

    if(colorOk && shapeOk && fillOk && qtyOk) score=1;
    
    return score;
}

@end
