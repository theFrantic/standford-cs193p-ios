//
//  AttributorViewController.m
//  Attributor
//
//  Created by Daniel Whilchy on 06/07/14.
//  Copyright (c) 2014 Standford University. All rights reserved.
//

#import "AttributorViewController.h"

@interface AttributorViewController ()

@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;
@end

@implementation AttributorViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Inside viewDidLoad method. Here we initialize the font attributes");
	// Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [title setAttributes:@{ NSStrokeWidthAttributeName : @3,
                            NSStrokeColorAttributeName : self.outlineButton.tintColor }
                   range:NSMakeRange(0, [title length])];
    [self.outlineButton setAttributedTitle:title
                                  forState:UIControlStateNormal];
}

// Lifecicle MVC viewWillAppear
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Inside viewWillAppear method. Here we start listening to the font change event");
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"Inside viewWillDisappear method. Here we stop listening to the font change event");
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                              name:UIContentSizeCategoryDidChangeNotification
                                            object:nil];
    
}

// Event to listen when preferred fonts changed
- (void)preferredFontsChanged:(NSNotification *)notification{
    NSLog(@"Inside preferredFontsChanged method. This was fired on font change event");
    [self usePreferredFonts];
}

// Method to change the preferred fonts
- (void)usePreferredFonts{
    NSLog(@"Inside usePreferredFonts method. Here we actually change the fonts styles");
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection:(id)sender {
    [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName : @-3,
                                            NSStrokeColorAttributeName : [UIColor blackColor]}
                                   range:self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection:(id)sender {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
}


@end
