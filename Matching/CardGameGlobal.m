//
//  CardGameGlobal.m
//  Matching
//
//  Created by Cox, Chip on 4/29/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "CardGameGlobal.h"

@implementation CardGameGlobal
#pragma mark - generic functions

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

- (NSMutableAttributedString *) NSStrCatMutableAttributed: (NSAttributedString *) str1 stringByAppendingAttributedString: (NSAttributedString *) str2
{    
    NSMutableAttributedString *Temp=[[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [Temp appendAttributedString:str2];
    
    return Temp;
}
@end
