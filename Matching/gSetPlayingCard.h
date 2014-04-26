//
//  gSetPlayingCard.h
//  Matching
//
//  Created by Cox, Chip on 4/19/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "Card.h"

@interface gSetPlayingCard : UIView

@property (nonatomic,strong) NSString * Suit;
@property (nonatomic) NSUInteger Rank;
@property (nonatomic,strong) NSString * Fill;
@property (nonatomic,strong) NSString * Color;

/*@interface setGameCardViewController : UIView */
@property (nonatomic,strong) UIColor *cardColor;
@property (nonatomic) NSInteger cardQuantity;
@property (nonatomic) NSInteger cardShape;
@property (nonatomic) NSInteger cardFill;
@property (nonatomic) CGPoint cardLocation;

@property (nonatomic, strong) UIBezierPath * roundedRect;

- (void)drawCard: (NSInteger) shape
       withColor: (UIColor *) cardColor
        withFill: (NSInteger) fill
     forQuantity: (NSInteger) quantity
              At: (CGPoint) location;

- (void)drawSetCircle: (UIColor *) cardColor
             withFill: (NSInteger) fill
          forQuantity: (NSInteger) quantity;

- (void)drawSetSquiggle: (UIColor *) cardColor
               withFill: (NSInteger) fill
            forQuantity: (NSInteger) quantity;

- (void)drawSetDiamond: (UIColor *) cardColor
              withFill: (NSInteger)fill
           forQuantity: (NSInteger)quantity;

/*static inline double radians (double degrees);*/

@end
