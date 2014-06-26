//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Daniel Whilchy on 20/12/13.
//  Copyright (c) 2013 CreativeSystems. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck *deck;
@end

@implementation CardGameViewController

- (Deck *)deck{
    if(!_deck){
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

//Setter for the fip count (and updates UI too)
- (void)setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount changed to %d", self.flipCount);
}

//Touch card action
- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        /*UIImage *cardImage = [UIImage imageNamed:@"cardback"];*/
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    else {
        Card *randomCard = [self.deck drawRandomCard];
        [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                          forState:UIControlStateNormal];
        [sender setTitle:randomCard.contents forState:UIControlStateNormal];
        NSLog(@"Flipped %@ card", randomCard.contents);
    }
    self.flipCount++;
    
}

@end
