//
//  gSetViewController.m
//  Matching
//
//  Created by Cox, Chip on 4/19/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "gSetViewController.h"
#import "SetGame.h"
#import "SetCardDeck.h"
#import "gSetPlayingCard.h"
#import "gSetDeck.h"
#import "setHistoryViewController.h"
#import "CardGameGlobal.h"

@interface gSetViewController ()
@property (strong, nonatomic) SetGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSMutableArray *SetCardButtons;

@property (weak, nonatomic) IBOutlet UILabel *cardsLeftInDeckLabel;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic,strong) gSetDeck *mainDeck;
@property (nonatomic) CardGameGlobal *sharedGlobal;
@end

@implementation gSetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    CardGameGlobal * CGG=[[CardGameGlobal alloc] init];
    self.game=[[SetGame alloc] initWithCardCount:[self.SetCardButtons count] usingDeck:[self createDeck]];
    [self updateUI];
//    CardGameGlobal *sharedGlobal=[CardGameGlobal sharedGlobal];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SetGame *)game
{
    if (!_game){

        _game = [[SetGame alloc] initWithCardCount:[self.SetCardButtons count]
                                         usingDeck:[self createDeck]];
    }
        return _game;
}


- (void)resetGame{
    self.game=nil;
    
    self.game=[[SetGame alloc] initWithCardCount:[self.SetCardButtons count] usingDeck:[self createDeck]];
    
}

- (gSetDeck *) createDeck
{
    self.mainDeck=[[SetCardDeck alloc] init];
    
    return self.mainDeck;
}

- (IBAction)RestartButton:(id)sender {
    [self resetGame];
    [self updateUI];
//    CardGameGlobal *sharedGlobal = [CardGameGlobal sharedGlobal];
    [self.sharedGlobal logHistory:[[NSMutableAttributedString alloc] initWithString:@"Restarting\n"]];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CardGameGlobal *sharedGlobal = [CardGameGlobal sharedGlobal];
    if([segue.identifier isEqualToString:@"HistorySegue"]){
        setHistoryViewController *vhistory = segue.destinationViewController;
        vhistory.history = sharedGlobal.quickHistoryText.mutableCopy;
    }
}

- (IBAction)Deal3MoreButton:(id)sender {
    for(gSetCard *Bcard in self.SetCardButtons){
        int matchedButtonIndex=[self.SetCardButtons indexOfObject:Bcard];
        NSLog(@"%d",[Bcard.self isMatched]);
        if ([Bcard.self isMatched]) {
            Bcard.matched=NO;
            Bcard.chosen=NO;
            [self.SetCardButtons removeObjectAtIndex:matchedButtonIndex];
            [self.SetCardButtons addObject:self.mainDeck.drawRandomCard];
        }
    }
}
- (IBAction)touchCardButton:(id)sender {
    int chosenButtonIndex = [self.SetCardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.SetCardButtons) {
        int cardButtonIndex = [self.SetCardButtons indexOfObject:cardButton];
        gSetCard *card = [self.game cardAtIndex:cardButtonIndex];
        cardButton.backgroundColor=[UIColor grayColor];
        [cardButton setBackgroundImage: [self backgroundImageForCard:card] forState:UIControlStateNormal];
        if(card.isMatched){
            cardButton.enabled=NO;
            [cardButton setAttributedTitle:nil forState:UIControlStateNormal];
        } else {
            cardButton.enabled=YES;
            [cardButton setAttributedTitle:[self attributedTitleForCard:card] forState:UIControlStateNormal];
        }
        cardButton.enabled = !card.isMatched;
        if(card.isChosen){
            cardButton.selected=YES;
            [cardButton setBackgroundImage:Nil forState:UIControlStateNormal];
            self.historyLabel.attributedText =[self attributedTitleForCard: card];
            
        }
        else
            cardButton.selected=NO;

    }
    self.cardsLeftInDeckLabel.text=[NSString stringWithFormat:@"%d Cards Left in Deck",[self.mainDeck.cards count]];
}

#define DefaultFontSize 14


- (NSAttributedString *)attributedTitleForCard:(gSetCard *)card
{
    NSLog(@"AttibutedTitleForCard = %@",card.contents);

    NSString * tempstring=@"";
    for(int i=0;i< card.cardQuantity;i++){
        tempstring=[tempstring stringByAppendingFormat:@"%@ ",card.cardShape];
    }
    NSMutableAttributedString *atext=[[NSMutableAttributedString alloc] initWithString:tempstring];
    int stringLength=[atext length];
    float fontSize=DefaultFontSize;
    if(card.isChosen)
        NSLog(@"card is chosen");
    
    UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
    [atext addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];
    [atext addAttribute:NSForegroundColorAttributeName value:card.cardColor range:NSMakeRange(0,stringLength)];
    
    switch(card.cardFill) {
        case 1:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0,stringLength)];
            break;
        case 2:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,stringLength)];
            break;
        case 3:
            [atext addAttribute:NSBackgroundColorAttributeName value:[UIColor colorWithWhite:(CGFloat)0 alpha:(CGFloat).5] range:NSMakeRange(0,stringLength)];
            
            break;
    }
//    [self.sharedGlobal logHistory:atext];

    return atext;
}



- (UIImage *)backgroundImageForCard:(gSetCard *) card
{
    return [UIImage imageNamed:card.isMatched ? @"cardBack" : @"cardfront"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
