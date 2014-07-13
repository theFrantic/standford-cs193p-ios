//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Daniel Whilchy on 12/07/14.
//  Copyright (c) 2014 Standford University. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

// only for testing purpose
/*
- (void)viewDidLoad{
    [super viewDidLoad];
    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test"
                                                         attributes:@{ NSForegroundColorAttributeName : [UIColor greenColor],
                                                                       NSStrokeWidthAttributeName: @-3 }];
}
 */

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze{
    _textToAnalyze = textToAnalyze;
    if (self.view.window) {
        [self updateUI];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)charactersWithAttributedString:(NSString *)attributedName {
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributedName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]] ;
            index = range.location + range.length;
        }
        else {
            index++;
        }
    }
    
    return characters;
}

- (void) updateUI{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d colorful characters", [[self charactersWithAttributedString:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d colorful characters", [[self charactersWithAttributedString:NSStrokeWidthAttributeName] length]];
}

@end
