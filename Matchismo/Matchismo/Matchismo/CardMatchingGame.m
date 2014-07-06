//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Daniel Whilchy on 26/06/14.
//  Copyright (c) 2014 CreativeSystems. All rights reserved.
//
#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger cardMatchingScore;
@property (nonatomic, strong) NSMutableArray *cards; // of card
@property (nonatomic, strong) NSMutableArray *cardsMatching; // unmatched and chosen cards from last choosenCardAtIndex
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)cardsMatching
{
    if (!_cardsMatching) _cardsMatching = [[NSMutableArray alloc] init];
    return _cardsMatching;
}

- (instancetype)initWithCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define COST_TO_CHOOSE 1

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        
        if (card.isChosen) {
            card.chosen = NO;
            if (self.cardMatchingScore < 0) {
                // remove all cards if there was a mismatched,
                // and card is the only chosen card
                [self.cardsMatching removeAllObjects];
                self.cardMatchingScore = 0;
            } else {
                [self.cardsMatching removeObject:card];
            }
        } else {
            self.cardsMatching = nil;
            self.cardMatchingScore = 0;
            for (Card *otherCard in self.cards) {
                
                if (!otherCard.isMatched && otherCard.isChosen) {
                    [self.cardsMatching addObject:otherCard];
                    
                    if ([self.cardsMatching count] == self.cardMatchingMode) {
                        self.cardMatchingScore = [card match:[self.cardsMatching copy]];
                        if (self.cardMatchingScore) {
                            self.cardMatchingScore *= MATCH_BONUS;
                            self.score += self.cardMatchingScore;
                            card.matched = YES;
                            [self.cardsMatching makeObjectsPerformSelector:@selector(turnToMatch)];
                        } else {
                            self.cardMatchingScore -= MISMATCH_PENALTY;
                            self.score -= MISMATCH_PENALTY;
                            [self.cardsMatching makeObjectsPerformSelector:@selector(turnToUnchosen)];
                        }
                        break;
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            [self.cardsMatching addObject:card];
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (NSArray *)cardsTryMatching
{
    return [self.cardsMatching copy];
}

- (instancetype)init
{
    return nil;
}

@end

