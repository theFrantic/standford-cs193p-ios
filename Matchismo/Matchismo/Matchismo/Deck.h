//
//  Deck.h
//  Matchismo
//
//  Created by Daniel Whilchy on 20/12/13.
//  Copyright (c) 2013 CreativeSystems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void)addCard:(Card *)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;

-(Card *)drawRandomCard;

@end
