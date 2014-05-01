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
@property (strong,nonatomic) NSMutableAttributedString *mas;
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
    for(int i=0;i<3;i++){
        
        NSLog(@"%@",[otherCards[i] contents] );
        
        [sharedGlobal logHistory:[[NSMutableAttributedString alloc]
                                  initWithAttributedString:  [self buildMutableAttributedCardWithColor:[otherCards[i] cardColor]
                                                                                                  fill:[otherCards[i] cardFill]
                                                                                                 shape:[otherCards[i] cardShape]
                                                                                              quantity:[otherCards[i] cardQuantity]]].mutableCopy];

        if(i<2)
            [sharedGlobal logHistory:[[NSMutableAttributedString alloc] initWithString:@", "]];
        else
            [sharedGlobal logHistory:[[NSMutableAttributedString alloc] initWithString:@" "]];
    }
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

- (NSMutableAttributedString *) buildMutableAttributedCardWithColor: (UIColor *) color fill: (int) fill shape: (NSString *) shape quantity: (int)quantity
{
    NSString *temp=[[NSString alloc] init];
    NSMutableDictionary *attrDict=[[NSMutableDictionary alloc] init];
    [attrDict setObject:[UIColor blueColor] forKey:NSBackgroundColorAttributeName];
    [attrDict setObject:color forKey:NSForegroundColorAttributeName];

    for(int i=0;i<quantity;i++) {
        temp=[temp stringByAppendingFormat:@"%@ ",shape];
    }
    
    switch(fill) {
        case 1:
            [attrDict setObject:[UIColor yellowColor] forKey:NSBackgroundColorAttributeName];
            
            break;
        case 2:
            [attrDict setObject:[UIColor whiteColor] forKey:NSBackgroundColorAttributeName];
            break;
        case 3:
            [attrDict setObject:[UIColor colorWithWhite:(CGFloat)0 alpha:(CGFloat) 5] forKey:NSBackgroundColorAttributeName];
    }
    self.mas = [[NSMutableAttributedString alloc] initWithString:temp attributes:attrDict].mutableCopy;
    return self.mas;
}

@end
