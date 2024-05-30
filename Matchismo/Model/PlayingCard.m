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

- (NSInteger)match:(NSArray<PlayingCard *> *)otherCards
{
    NSInteger score = 0;

    // According to requirements it is fine to assume to have not more than 3 cards
    PlayingCard *cardOne = self;
    PlayingCard *cardTwo = otherCards.firstObject;
    PlayingCard *cardThree = otherCards.count > 1 ? otherCards[1] : nil;

    if ([cardOne.suit isEqualToString:cardTwo.suit] || [cardOne.suit isEqualToString:cardThree.suit] || [cardTwo.suit isEqualToString:cardThree.suit]) {
        if ([cardOne.suit isEqualToString:cardTwo.suit] && [cardOne.suit isEqualToString:cardThree.suit]) {
            NSLog(@"3 suits match");
            score += 3;
        }
        else {
            NSLog(@"2 suits match");
            score += 1;
        }
    }

    if (cardOne.rank == cardTwo.rank || cardOne.rank == cardThree.rank || cardTwo.rank == cardThree.rank) {
        if (cardOne.rank == cardTwo.rank && cardOne.rank == cardThree.rank) {
            NSLog(@"3 ranks match");
            score += 12;
        }
        else {
            NSLog(@"2 ranks match");
            score += 4;
        }
    }

    NSLog(@"Matching score is %ld", score);
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
