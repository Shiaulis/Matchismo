//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Andrius Shiaulis on 26.05.2024.
//

#import "CardMatchingGame.h"

static const int COST_TO_CHOOSE = 1;

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray<Card *> *cards;
@property (nonatomic, readonly) CardMatchingGameMode mode;

@property (nonatomic, readonly) NSInteger matchBonus;
@property (nonatomic, readonly) NSInteger mismatchPenalty;

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
    _matchBonus = 4 + (4 * mode);
    _mismatchPenalty = 2 + (2 * mode);

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

    if (card.isMatched) {
        NSLog(@"%@ card is already matched. Ignoring", card.contents);
        return;
    }

    if (card.isChosen) {
        NSLog(@"%@ card is flipped back", card.contents);
        card.chosen = NO;
        return;
    }

    NSLog(@"%@ card is chosen", card.contents);

    NSArray<Card *> *chosenCards = [self getChosenCards];
    NSUInteger currentlySelected = chosenCards.count + 1;

    if (currentlySelected == [self requiredToBeChosen]) {
        NSLog(@"Matching…");
        NSInteger matchScore = [card match:chosenCards];

        if (matchScore > 0) {
            NSInteger receivedScore = matchScore * self.matchBonus;
            self.score += receivedScore;
            NSArray *matchedCards = [chosenCards arrayByAddingObject:card];
            [self markAsMatchedCards:matchedCards];
            NSLog(@"Matched card: %@ 🟢. Received %ld points", [CardMatchingGame makeDescriptionForCards:matchedCards], receivedScore);
        }
        else {
            NSArray *mismatchedCards = [chosenCards arrayByAddingObject:card];
            NSInteger receivedPenalty = self.mismatchPenalty;
            self.score -= receivedPenalty;
            [self deselectCards:chosenCards];
            NSLog(@"Mismatched card: %@ 🔴. Lost %ld points", [CardMatchingGame makeDescriptionForCards:mismatchedCards], receivedPenalty);
        }
    }
    else {
        NSLog(@"Nothing to match with");
    }

    card.chosen = YES;
    self.score -= COST_TO_CHOOSE;
}

- (NSUInteger)requiredToBeChosen
{
    switch (self.mode) {
        case CardMatchingGameModeTwoCards:
            return 2;
            break;
        case CardMatchingGameModeThreeCards:
            return 3;
        default:
            NSAssert(NO, @"Not supported mode");
            return 0;
            break;
    }

}

- (NSArray<Card *> *)getChosenCards
{
    NSMutableArray *chosenCards = [NSMutableArray new];
    for (Card *card in self.cards) {
        if (card.isChosen && !card.isMatched) {
            [chosenCards addObject:card];
        }
    }

    return [chosenCards copy];
}

- (void)markAsMatchedCards:(NSArray<Card *> *)cards
{
    for (Card *card in cards) {
        card.matched = YES;
    }
}

- (void)deselectCards:(NSArray<Card *> *)cards
{
    for (Card *card in cards) {
        card.chosen = NO;
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

+ (NSString *)makeDescriptionForCards:(NSArray<Card *> *)cards
{
    NSMutableString *description = [NSMutableString string];

    for (Card *card in cards) {
        if (description.length == 0) {
            [description appendString:card.contents];
        }
        else {
            [description appendFormat:@", %@", card.contents];
        }
    }

    return [description copy];
}

@end
