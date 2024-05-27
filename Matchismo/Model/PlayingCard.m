//
//  PlayingCard.m
//  Matchismo
//
//  Created by Andrius Shiaulis on 26.05.2024.
//

#import "PlayingCard.h"

@implementation PlayingCard

#pragma - Synthesize -

@synthesize suit = _suit;

#pragma - Setters and Getters -

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

#pragma - Overriden methods -

- (NSInteger)match:(NSArray<Card *> *)otherCards
{
    NSInteger score = 0;

    if (otherCards.count == 1) {
        PlayingCard *otherCard = (PlayingCard *)otherCards.firstObject;
        if ([self.suit isEqualToString:otherCard.suit]) {
            score = 1;
        }
        else if (self.rank == otherCard.rank) {
            score = 4;
        }
    }

    return score;
}

#pragma - Private API -

- (NSString *)contents
{
    NSArray<NSString *> *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

#pragma - Static methods -

+ (NSArray<NSString *> *)validSuits
{
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count - 1;
}

+ (NSArray<NSString *> *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

@end
