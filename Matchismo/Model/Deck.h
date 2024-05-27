//
//  Deck.h
//  Matchismo
//
//  Created by Andrius Shiaulis on 26.05.2024.
//

@import Foundation;

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end

NS_ASSUME_NONNULL_END
