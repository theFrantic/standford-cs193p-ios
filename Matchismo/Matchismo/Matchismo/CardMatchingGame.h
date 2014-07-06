//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Daniel Whilchy on 26/06/14.
//  Copyright (c) 2014 CreativeSystems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

/// Returns cards try to match from
/// last choosenCardAtIndex call.
/// @return Cards try to match
- (NSArray *)cardsTryMatching;

/// Game score
@property (nonatomic, readonly) NSInteger score;

/// Matching score between chosen cards
@property (nonatomic, readonly) NSInteger cardMatchingScore;

/// Number of cards necessary for a single match
@property (nonatomic) NSInteger cardMatchingMode;

@end
