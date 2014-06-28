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

//Designated initializer
- (instancetype) initWithCardCount: (NSUInteger)count
                         usingDeck:(Deck *)deck;

- (void) chooseCardAtIndex: (NSUInteger)index;

- (Card *) cardAtIndex: (NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end
