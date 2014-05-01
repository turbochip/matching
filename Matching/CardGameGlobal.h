//
//  CardGameGlobal.h
//  Matching
//
//  Created by Cox, Chip on 4/29/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardGameGlobal : NSObject

@property (nonatomic,strong) NSMutableAttributedString * quickHistoryText;

+ (id) sharedGlobal;
- (void)logHistory: (NSMutableAttributedString *) historyMessage;

@end
