//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Daniel Whilchy on 20/12/13.
//  Copyright (c) 2013 CreativeSystems. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
// Deck control var
@property (nonatomic, strong) Deck *deck;

//---- UI properties ----

// Score label control
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

// Cards collection
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

// Model properties
@property (nonatomic, strong) CardMatchingGame *game;

// The control to select the matching mode
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardMatchingMode;

// The button to re-deal the game
@property (weak, nonatomic) IBOutlet UIButton *dealButton;


// Description label
@property (weak, nonatomic) IBOutlet UILabel *touchCardButtonDescriptionLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCount:[self.cardButtons count] usingDeck:[self createDeck]];
        _game.cardMatchingMode = self.cardMatchingMode.selectedSegmentIndex + 1;
    }
    return _game;
}

- (Deck *)createDeck {  //abstract
    return nil;
}

//Touch card action
- (IBAction)touchCardButton:(UIButton *)sender {
    self.cardMatchingMode.enabled = NO;
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

- (void)updateTouchCardButtonDescriptionLabel
{
    if (self.game.cardMatchingScore > 0) {
        self.touchCardButtonDescriptionLabel.text = [NSString stringWithFormat:@"Matched %@ for %ld points!",
                                                     [[self.game cardsTryMatching] componentsJoinedByString:@","],
                                                     (long)self.game.cardMatchingScore];
        NSLog(@"Matched %@ for %ld points!",
              [[self.game cardsTryMatching] componentsJoinedByString:@","],
              (long)self.game.cardMatchingScore);
    } else if (self.game.cardMatchingScore < 0) {
        self.touchCardButtonDescriptionLabel.text = [NSString stringWithFormat:@"%@ don't match! %ld points penalty!",
                                                     [[self.game cardsTryMatching] componentsJoinedByString:@","],
                                                     (long)self.game.cardMatchingScore];
        NSLog(@"%@ don't match! %ld points penalty!",
              [[self.game cardsTryMatching] componentsJoinedByString:@","],
              (long)self.game.cardMatchingScore);
    } else {
        self.touchCardButtonDescriptionLabel.text = [[self.game cardsTryMatching] componentsJoinedByString:@","];
        NSLog(@"%@", [[self.game cardsTryMatching] componentsJoinedByString:@","]);
    }
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    [self updateTouchCardButtonDescriptionLabel];
}

// Helper method for title on card buttons
- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

// Helper method for background on card buttos
- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

// Action for card selector
- (IBAction)changeCardMatchingMode:(UISegmentedControl *)sender {
    self.game.cardMatchingMode = sender.selectedSegmentIndex + 1;
    NSLog(@"UI selected card matching mode: %i", sender.selectedSegmentIndex + 1);
}



// deal
- (IBAction)deal:(id)sender {
    self.game = nil;
    self.scoreLabel.text = @"Score: 0";
    self.cardMatchingMode.enabled = YES;
    [self updateUI];
}

@end
