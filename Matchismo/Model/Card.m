//
//  Card.m
//  Matchismo
//
//  Created by Andrius Shiaulis on 26.05.2024.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray<Card *> *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}


@end
