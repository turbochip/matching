//
//  CardGameGlobal.m
//  Matching
//
//  Created by Cox, Chip on 4/29/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "CardGameGlobal.h"
@interface CardGameGlobal()

@end

@implementation CardGameGlobal

+ (id)sharedGlobal {
    static CardGameGlobal *sharedCardGameGlobal=nil;

    @synchronized(self) {
        if(sharedCardGameGlobal==nil)
            sharedCardGameGlobal=[[self alloc] init];
    }
    return sharedCardGameGlobal;
}
#pragma mark - generic functions

- (id)init {
    if(self=[super init]) {
        self.quickHistoryText=[[NSMutableAttributedString alloc] initWithString:@"Initializing History\n"];
    }
    return self;
}

static inline double radians (double degrees)
{
    return degrees * M_PI/180;
}

- (NSString *) NSStrCat: (NSString *) str1 stringByAppendingString:(NSString*) str2
{
    NSString * Temp;
    
    Temp=[str1 stringByAppendingString:str2];
    return Temp;
}

- (void)logHistory: (NSMutableAttributedString *) historyMessage
{
    NSAttributedString * temp1 =[[NSAttributedString alloc] initWithAttributedString:historyMessage.mutableCopy];
    NSMutableAttributedString * tempstr=[[NSMutableAttributedString alloc] initWithAttributedString:self.quickHistoryText.mutableCopy];
    
    [tempstr appendAttributedString:temp1];
   
    
    NSMutableAttributedString *res = [[NSMutableAttributedString alloc] initWithAttributedString:tempstr];
    
    [res beginEditing];
    __block BOOL found = NO;
    [res addAttribute:NSForegroundColorAttributeName value:UIColor.purpleColor range: NSMakeRange(0, res.length)];
    [res enumerateAttributesInRange:NSMakeRange(0,res.length) options:NSAttributedStringEnumerationReverse usingBlock:^(id value, NSRange range, BOOL *stop) {
//    [res enumerateAttribute:NSForegroundColorAttributeName inRange:NSMakeRange(0, res.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
        if (value) {
            UIFont *oldFont = (UIFont *)value;
//            UIFont *newFont = [oldFont fontWithSize:oldFont.pointSize * 2];
//            [res removeAttribute:NSFontAttributeName range:range];
//            [res addAttribute:NSFontAttributeName value:newFont range:range];
            NSLog(@"%@",[oldFont description]);
            found = YES;
        }
    }];
    if (!found) {
        // No font was found - do something else?
    }
    [res endEditing];
    
    
    
    self.quickHistoryText = tempstr;
    
}

@end
