//
//  gSetPlayingCard.m
//  Matching
//
//  Created by Cox, Chip on 4/19/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "gSetPlayingCard.h"

@implementation gSetPlayingCard


-(NSString *)contents
{
    NSArray *validFills = [gSetPlayingCard validFills];

    return [self.cardShape stringByAppendingString:
            [validFills[self.cardFill] stringByAppendingString:
             [[self cardColorString:self.cardColor ] stringByAppendingFormat: @"%d",self.cardQuantity]]];
}


-(NSString *) cardColorString: (UIColor *)currentColor
{
    CGFloat redC=0.0;
    CGFloat greenC=0.0;
    CGFloat blueC=0.0;
    CGFloat alphaC=0.0;
    if([currentColor getRed:&redC green:&greenC blue:&blueC alpha:&alphaC]){
        return(redC ? @"Red" : greenC ? @"Green" : @"Blue");
    } else {
        return nil;
    }
    
}

+(NSArray *)validShapes
{
    return @[@"○",@"☐",@"△"];
}

+(NSArray *)validFills
{
    return @[@"?",@"Empty",@"Solid",@"Slash"];
}

+(NSArray *)validColors
{
    return @[[UIColor redColor], [UIColor blueColor], [UIColor greenColor]];
}
- (void)setup
{
//    self.backgroundColor = nil;
//    self.opaque = NO;
//    self.contentMode = UIViewContentModeRedraw;
    NSLog(@"In Setup");
}

- (void)awakeFromNib
{
    [self setup];
}


- (id)initWithFrame:(CGRect)frame
{
 //   self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

#pragma mark - Setters and Getters
/*- (void) setCardColor:(UIColor *)cardColor
{
    _cardColor=cardColor;
//    [self setNeedsDisplay];
}

- (void) setCardQuantity:(NSInteger)cardQuantity
{
    _cardQuantity=cardQuantity;
//    [self setNeedsDisplay];
}

- (void)setCardShape:(NSString *)cardShape
{
    _cardShape=cardShape;
//    [self setNeedsDisplay];
}

- (void)setCardFill:(NSInteger)cardFill
{
    _cardFill=cardFill;
//    [self setNeedsDisplay];
}
*/
#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

//- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
//- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
//- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self drawCard: self.cardShape withColor: self.cardColor withFill: self.cardFill forQuantity: self.cardQuantity At: self.cardLocation];
}

- (void)drawCard: (NSString *) shape withColor: (UIColor *) cardColor withFill: (NSInteger) fill forQuantity: (NSInteger) quantity At: (CGPoint) location
{
    // Drawing code
//    self.roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [self.roundedRect addClip];
    if((!cardColor)||(!quantity)||(!fill)){
        NSLog(@"values not set yet");
    }
    else {
        [[UIColor whiteColor] setFill];
//        UIRectFill(self.bounds);
        
        [[UIColor blackColor] setStroke];
        [self.roundedRect stroke];
        
        if([shape isEqualToString:@"☐"]) {
                [self drawSetDiamond:cardColor withFill:fill forQuantity:quantity];
        } else if ([shape isEqualToString:@"○"]) {
                [self drawSetCircle:cardColor withFill:fill forQuantity:quantity];
        } else if([shape isEqualToString:@"△"]) {
                [self drawSetSquiggle:cardColor withFill:fill forQuantity:quantity];
        }
    }
    
}

#define DefaultFontSize 18.0

- (void)drawSetCircle: (UIColor *) cardColor
             withFill: (NSInteger) fill
          forQuantity: (NSInteger) quantity
{
    NSMutableAttributedString *atext=[[NSMutableAttributedString alloc] initWithString:@"○"];
    int stringLength=[atext length];
    float fontSize=DefaultFontSize/quantity;
    
    UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [atext addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];
    [atext addAttribute:NSForegroundColorAttributeName value:cardColor range:NSMakeRange(0,stringLength)];
    
    CGSize atextsize=atext.size;
    CGFloat leftbuffer=atextsize.width;
    CGFloat characterSpacing=leftbuffer/2;
    CGPoint drawPoint=CGPointMake(leftbuffer,(self.roundedRect.bounds.size.height/2)-(atextsize.height/2));
    
    switch(fill) {
        case 1:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0,stringLength)];
            break;
        case 2:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,stringLength)];
            break;
        case 3:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithWhite:(CGFloat)0 alpha:(CGFloat).5] range:NSMakeRange(0,stringLength)];
            
            break;
    }
    
    for(int i=1;i<=quantity;i++){
        [atext drawAtPoint:drawPoint];
        drawPoint.x+=characterSpacing+atextsize.width;
    }
}

- (void)drawSetDiamond: (UIColor *) cardColor
              withFill: (NSInteger)fill
           forQuantity: (NSInteger)quantity
{
    NSString * tempstring=@"☐";
    for(int i=0;i<quantity-1;i++)
        [tempstring stringByAppendingString:tempstring];
        
    NSMutableAttributedString *atext=[[NSMutableAttributedString alloc] initWithString:tempstring];
    int stringLength=[atext length];
    float fontSize=DefaultFontSize/quantity;
    
    UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [atext addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];
    [atext addAttribute:NSForegroundColorAttributeName value:cardColor range:NSMakeRange(0,stringLength)];
    
//    CGSize atextsize=atext.size;
//    CGFloat leftbuffer=atextsize.width;
//    CGFloat characterSpacing=leftbuffer/2;
//    CGPoint drawPoint=CGPointMake(leftbuffer,(self.roundedRect.bounds.size.height/2)-(atextsize.height/2));
    
    switch(fill) {
        case 1:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0,stringLength)];
            break;
        case 2:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,stringLength)];
            break;
        case 3:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithWhite:(CGFloat)0 alpha:(CGFloat).5] range:NSMakeRange(0,stringLength)];
            
            break;
    }
    
//    for(int i=1;i<=quantity;i++){
//        [atext drawAtPoint:drawPoint];
//        drawPoint.x+=characterSpacing+atextsize.width;
//    }
}

- (void)drawSetSquiggle: (UIColor *) cardColor
               withFill: (NSInteger) fill
            forQuantity: (NSInteger) quantity
{
    NSMutableAttributedString *atext=[[NSMutableAttributedString alloc] initWithString:@"△"];
    int stringLength=[atext length];
    float fontSize=DefaultFontSize/quantity;
    
    UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [atext addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];
    [atext addAttribute:NSForegroundColorAttributeName value:cardColor range:NSMakeRange(0,stringLength)];
    CGSize atextsize=atext.size;
    CGFloat leftbuffer=atextsize.width;
    CGFloat characterSpacing=leftbuffer/2;
    CGPoint drawPoint=CGPointMake(leftbuffer,(self.roundedRect.bounds.size.height/2)-(atextsize.height/2));
    
    switch(fill) {
        case 1:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0,stringLength)];
            break;
        case 2:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,stringLength)];
            break;
        case 3:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithWhite:(CGFloat)0 alpha:(CGFloat).5] range:NSMakeRange(0,stringLength)];
            
            break;
    }
    
    for(int i=1;i<=quantity;i++){
        [atext drawAtPoint:drawPoint];
        drawPoint.x+=characterSpacing+atextsize.width;
    }
}

@end

