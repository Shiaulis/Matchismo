//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Andrius Shiaulis on 26.05.2024.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];

    if (self == nil) {
        return self;
    }

    for (NSString *suit in [PlayingCard validSuits]) {
        for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank += 1) {
            PlayingCard *card = [PlayingCard new];
            card.rank = rank;
            card.suit = suit;
            [self addCard:card];
        }
    }

    return self;
}

@end
