//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Andrius Shiaulis on 26.05.2024.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray<UIButton *> *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSwitch;
@property (weak, nonatomic) IBOutlet UIButton *startNewGameButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@end

@implementation CardGameViewController

#pragma - Setters and getters -

#pragma - View Controller Life Cycle

- (void)viewDidLoad
{
    [self updateUI];
}

#pragma - IBActions -

- (IBAction)touchCardButton:(UIButton *)sender
{
    [self startNewGameIfNeeded];
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)newGameTapped:(UIButton *)sender
{
    [self showNewGameAlert];
}

#pragma - Private API -

- (void)showNewGameAlert
{
    UIAlertAction *newGameAction = [UIAlertAction actionWithTitle:@"Start New Game"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * _Nonnull action) {
        [self discardCurrentGame];
    }];

    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Do you want to start a new game?"
                                                                   message:@"Previous progress will be lost"
                                                            preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:dismissAction];
    [alert addAction:newGameAction];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)discardCurrentGame
{
    self.game = nil;
    [self updateUI];
}

- (void)startNewGameIfNeeded
{
    if (self.game != nil) {
        return;
    }

    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[self createDeck]
                                                       mode:[self getSelectedGameMode]];
}

- (Deck *)createDeck
{
    return [PlayingCardDeck new];
}

- (BOOL)didGameStart
{
    return self.game != nil;
}

- (CardMatchingGameMode)getSelectedGameMode
{
    return self.gameModeSwitch.selectedSegmentIndex;
}

- (void)updateUI
{
    [self updateCards];
    [self updateGameModeSwitch];
    [self updateNewGameButton];
    [self updateScoreCounter];

    NSLog(@"UI Updated");
}

- (void)updateCards
{
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
}

- (void)updateGameModeSwitch
{
    self.gameModeSwitch.enabled = ![self didGameStart];
}

- (void)updateNewGameButton
{
    self.startNewGameButton.hidden = ![self didGameStart];
}

- (void)updateScoreCounter
{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
