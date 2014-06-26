//
//  Deck.m
//  Matchismo
//
//  Created by Daniel Whilchy on 20/12/13.
//  Copyright (c) 2013 CreativeSystems. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards;

@end

@implementation Deck

// This initialization follows the lazy initialization pattern
- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];     //Lazy initialization
    }
    return _cards;
}


- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card {
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard {
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
