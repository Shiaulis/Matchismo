//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Andrius Shiaulis on 26.05.2024.
//

#import "CardMatchingGame.h"

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray<Card *> *cards;
@property (nonatomic, readonly) CardMatchingGameMode mode;

@end

@implementation CardMatchingGame

#pragma - Init -

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                             mode:(CardMatchingGameMode)mode
{
    self = [super init];

    if (self == nil) {
        return self;
    }

    _mode = mode;

    for (NSUInteger index = 0; index < count; index += 1) {
        Card *card = [deck drawRandomCard];

        if (card != nil) {
            [self.cards addObject:card];
        }
        else {
            self = nil;
            break;
        }
    }

    NSLog(@"New game started with %lu cards with %@ mode", count, [CardMatchingGame makeDescriptionForMode:mode]);

    return self;
}

#pragma - Setters and getters -

- (NSMutableArray<Card *> *)cards
{
    if (_cards == nil) {
        _cards = [NSMutableArray new];
    }

    return _cards;
}

#pragma - Public API -

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];

    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        }
        else {
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    NSInteger matchScore = [card match:@[otherCard]];
                    if (matchScore > 0) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }
                    else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    if (index >= self.cards.count) {
        return nil;
    }

    return self.cards[index];
}

+ (NSString *)makeDescriptionForMode:(CardMatchingGameMode)mode
{
    switch (mode) {
        case CardMatchingGameModeTwoCards:
            return @"2 cards matching";
            break;
        case CardMatchingGameModeThreeCards:
            return @"3 cards matching";
            break;
        default:
            NSAssert(NO, @"Unknown mode");
            return @"Unknown mode";
    }
}

@end
