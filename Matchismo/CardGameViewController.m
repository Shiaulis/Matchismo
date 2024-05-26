//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Andrius Shiaulis on 26.05.2024.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@property (strong, nonatomic) Deck *deck;

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@end

@implementation CardGameViewController

#pragma - Setters and getters -

- (Deck *)deck
{
    if (_deck == nil) {
        _deck = [PlayingCardDeck new];
    }

    return _deck;;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount = %d", self.flipCount);
}

#pragma - IBActions -

- (IBAction)touchCardButton:(UIButton *)sender
{
    Card *card = [self.deck drawRandomCard];

    if (sender.currentTitle.length != 0) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    else {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:card.contents forState:UIControlStateNormal];
    }

    self.flipCount += 1;
}

@end
