//
//  CardGameViewController.m
//  Matching
//
//  Created by Chip Cox on 3/29/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;
@end

@implementation CardGameViewController

- (void)resetGame{
    _game=nil;
    _modeSwitch.enabled=YES;
    _game=[[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                      usingDeck:[self createDeck]];
    
}

- (IBAction)changeModeSwitch:(UISwitch *)sender {
    [self resetGame];
    if(sender.on)
        _game.MATCH_COUNT=3;
    else
        _game.MATCH_COUNT=2;
    [self updateUI];
}

- (IBAction)touchResetButton:(UIButton *)sender {
    [self resetGame];
    _modeSwitch.on = NO;
    _game.MATCH_COUNT=2;
    [self updateUI];
}
- (CardMatchingGame *)game
{
    if (!_game){
        
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                      usingDeck:[self createDeck]];
    _modeSwitch.on=NO;
    _game.MATCH_COUNT=2;
    }

    return _game;
}

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    _modeSwitch.enabled=NO;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle: [self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
        self.resultLabel.text = [NSString stringWithFormat:@"Result: %@",self.game.result];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *) card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardBack"];
}

@end