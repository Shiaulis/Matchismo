//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Andrius Shiaulis on 26.05.2024.
//

@import Foundation;

#import "Deck.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CardMatchingGameModeTwoCards,
    CardMatchingGameModeThreeCards,
} CardMatchingGameMode;

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;


- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                             mode:(CardMatchingGameMode)mode NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

+ (NSString *)makeDescriptionForMode:(CardMatchingGameMode)mode;

@end

NS_ASSUME_NONNULL_END

