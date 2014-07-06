//
//  PlayingCard.m
//  Matchismo
//
//  Created by Daniel Whilchy on 20/12/13.
//  Copyright (c) 2013 CreativeSystems. All rights reserved.
//

#import "PlayingCard.h"


@implementation PlayingCard

/*
- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;       //Because we provide setter and getter, otherwise Objective-C did this for us

+ (NSArray *)validSuits {
    return @[@"♥️", @"♦️", @"♠️", @"♣️"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] -1;
}

- (void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


/// Recursive version of match. It lets you
/// calculate the matching-score of two or
/// more cards.
///
/// Example: [1♥, 5♣, 7♣, 2♥]
/// 1♥ match 5♣, 1♥ match 7♣, 1♥ match 2♥
/// 5♣ match 7♣, 5♣ match 2♥
/// 7♣ match 2♥
///
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    NSLog(@"Match Score: %i", score);
    if ([otherCards count] != 0) {
        if ([otherCards count] == 1) {
            PlayingCard *otherCard = [otherCards firstObject];
            if ([self.suit isEqualToString:otherCard.suit]) {
                return score = 1;
            } else if (self.rank == otherCard.rank) {
                return score = 4;
            }
        } else {
            for (Card *otherCard in otherCards) score += [self match:@[otherCard]];
            PlayingCard *otherCard = [otherCards firstObject];
            score += [otherCard match:[otherCards subarrayWithRange:NSMakeRange(1, [otherCards count] - 1)]];
        }
    }
    NSLog(@"Match Score: %i", score);
    return score;
}
 */
@synthesize suit = _suit; // because we provide setter and getter

/// Recursive version of match. It lets you
/// calculate the matching-score of two or
/// more cards.
///
/// Example: [1♥, 5♣, 7♣, 2♥]
/// 1♥ match 5♣, 1♥ match 7♣, 1♥ match 2♥
/// 5♣ match 7♣, 5♣ match 2♥
/// 7♣ match 2♥
///
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] != 0) {
        if ([otherCards count] == 1) {
            PlayingCard *otherCard = [otherCards firstObject];
            if ([self.suit isEqualToString:otherCard.suit]) {
                return score = 1;
            } else if (self.rank == otherCard.rank) {
                return score = 4;
            }
        } else {
            for (Card *otherCard in otherCards) score += [self match:@[otherCard]];
            PlayingCard *otherCard = [otherCards firstObject];
            score += [otherCard match:[otherCards subarrayWithRange:NSMakeRange(1, [otherCards count] - 1)]];
        }
    }
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

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

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (NSString *)description
{
    return self.contents;
}

@end
