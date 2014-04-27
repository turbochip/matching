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

@interface gSetViewController ()
@property (strong, nonatomic) SetGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *SetCardButtons;

@property (weak, nonatomic) IBOutlet UILabel *CardsInDeckButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SetGame *)game
{
    if (!_game){
        NSLog(@"set card buttons=%d",[(NSArray *)self.SetCardButtons count]);
        _game = [[SetGame alloc] initWithCardCount:[self.SetCardButtons count]
                                                  usingDeck:[self createDeck]];
    }
        return _game;
}


- (void)resetGame{
    self.game=nil;
    
    self.game=[[SetGame alloc] initWithCardCount:[self.SetCardButtons count] usingDeck:[self createDeck]];
    
}

- (Deck *) createDeck
{
    return [[SetCardDeck alloc] init];
}

- (IBAction)RestartButton:(id)sender {
    [self resetGame];
    [self updateUI];
}
- (IBAction)Deal3MoreButton:(id)sender {
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
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle: [self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
//        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
//        self.resultLabel.text = [NSString stringWithFormat:@"Result: %@",self.game.result];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    NSLog(@"%@,%@",card.contents);
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *) card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardBack"];
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
