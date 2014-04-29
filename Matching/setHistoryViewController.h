//
//  setHistoryViewController.h
//  Matching
//
//  Created by Cox, Chip on 4/28/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface setHistoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *historyAttributedText;
@property (strong, nonatomic) NSAttributedString * history;
@end
