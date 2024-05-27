//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Andrius Shiaulis on 26.05.2024.
//

@import Foundation;

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;


- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END

