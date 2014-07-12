//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Daniel Whilchy on 20/12/13.
//  Copyright (c) 2013 CreativeSystems. All rights reserved.
//
//  Abstract class. Must implement methods as described bellow

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

//abstract method
- (Deck *)createDeck;
@end
