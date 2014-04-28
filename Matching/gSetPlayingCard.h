//
//  gSetPlayingCard.h
//  Matching
//
//  Created by Cox, Chip on 4/19/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "gSetCard.h"

//@interface gSetPlayingCard : UIView
@interface gSetPlayingCard : gSetCard
@property (nonatomic,strong) NSArray *validShapes;
@property (nonatomic,strong) NSArray *validColors;
@property (nonatomic,strong) NSArray *validFills;
@property (nonatomic,strong) NSString * Fill;
@property (nonatomic,strong) NSString * Color;

/*@interface setGameCardViewController : UIView */
//@property (nonatomic) UIColor * cardColor;
//@property (nonatomic) NSInteger cardQuantity;
//@property (nonatomic) NSString * cardShape;
//@property (nonatomic) NSInteger cardFill;
//@property (nonatomic) CGPoint cardLocation;

@property (nonatomic, strong) UIBezierPath * roundedRect;


+(NSArray *)validShapes;
+(NSArray *)validColors;
+(NSArray *)validFills;

- (NSString *)cardColorString:(UIColor *)currentColor;

- (void)drawCard: (NSString *) shape
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
