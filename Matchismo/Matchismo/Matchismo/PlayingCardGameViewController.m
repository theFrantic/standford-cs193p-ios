//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Daniel Whilchy on 10/07/14.
//  Copyright (c) 2014 CreativeSystems. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck{
    return [[PlayingCardDeck alloc] init];
}

@end
