//
//  gSetCard.h
//  Matching
//
//  Created by Cox, Chip on 4/27/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "Card.h"

@interface gSetCard : Card

@property (nonatomic,strong) NSMutableAttributedString * attributableContents;

@property (nonatomic) UIColor * cardColor;
@property (nonatomic) NSInteger cardQuantity;
@property (nonatomic) NSString * cardShape;
@property (nonatomic) NSInteger cardFill;
@property (nonatomic) CGPoint cardLocation;

-(int) match:(NSArray *)otherCards;
@end
