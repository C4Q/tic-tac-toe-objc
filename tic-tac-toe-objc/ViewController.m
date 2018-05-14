//
//  ViewController.m
//  tic-tac-toe-objc
//
//  Created by C4Q  on 5/14/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

#import "ViewController.h"
#import "UIView+borders.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.cyanColor];
    [self setUpGameBrain];
    [self allocInitViews];
    [self configureViews];
    [self addSubviews];
    [self configureConstraints];
}

-(void) setUpGameBrain {
    _gameBrain = [[GameBrain alloc] init];
}

-(void) allocInitViews {
    _gameStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _gameDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _resetButton = [[UIButton alloc] initWithFrame:CGRectZero];
}

-(void) configureViews {
    [self configureGameStackView];
    [self configureGameDescriptionLabel];
    [self configureResetButton];
}

-(void) configureGameStackView {
    [self.gameStackView setAxis:UILayoutConstraintAxisVertical];
    [self.gameStackView setDistribution:UIStackViewDistributionFillEqually];
    for (int i = 0; i < 9; i+=3) {
        [self.gameStackView addArrangedSubview:[self makeButtonStackViewStartingWith:i]];
    }
}

-(void) configureGameDescriptionLabel {
    [self.gameDescriptionLabel setText:@"Player One's Turn"];
}

-(void) configureResetButton {
    [self.resetButton setTitle:@"Reset Game" forState:UIControlStateNormal];
    [self.resetButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.resetButton addTarget:self action:@selector(resetGame) forControlEvents:UIControlEventTouchUpInside];
    [self.resetButton setHidden:YES];
}

-(void) addSubviews {
    [self.view addSubview:self.gameStackView];
    [self.view addSubview:self.gameDescriptionLabel];
    [self.view addSubview:self.resetButton];
}

-(void) configureConstraints {
    [self.gameStackView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self.gameStackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[self.gameStackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:YES];
    [[self.gameStackView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.5] setActive:YES];
    [[self.gameStackView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor multiplier:0.5] setActive:YES];
    
    [self.gameDescriptionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self.gameDescriptionLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[self.gameDescriptionLabel.bottomAnchor constraintEqualToAnchor:self.gameStackView.topAnchor constant:-50] setActive:YES];
    
    [self.resetButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [[self.resetButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:YES];
    [[self.resetButton.topAnchor constraintEqualToAnchor:self.gameStackView.bottomAnchor constant:50] setActive:YES];
}


-(UIStackView*)makeButtonStackViewStartingWith:(int) val {
    UIStackView *sv = [[UIStackView alloc] init];
    [sv setAxis:UILayoutConstraintAxisHorizontal];
    [sv setDistribution:UIStackViewDistributionFillEqually];
    for (int i = val; i < (val + 3); i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:@"-" forState:UIControlStateNormal];
        [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self action:@selector(handleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        if (i%3 < 2)
            [button addRightBorderWithColor:UIColor.blackColor andWidth:5];
        if (i < 6)
            [button addBottomBorderWithColor:UIColor.blackColor andWidth:5];
        [sv addArrangedSubview:button];
    }
    return sv;
}

-(void)handleButtonPress: (UIButton*) button {
    int x;
    int y = button.tag % 3;
    if (button.tag < 3) {
        x = 0;
    } else if (button.tag < 6) {
        x = 1;
    } else {
        x = 2;
    }
    GameStatus status = [self.gameBrain makeMoveAtX:x andY:y];
    switch (status) {
        case GameStatus_InvalidMove:
            break;
        case GameStatus_InProgressPlayerOneTurn:
            [button setTitle:@"O" forState:UIControlStateNormal];
            [self.gameDescriptionLabel setText:@"Player One's Turn"];
            break;
        case GameStatus_InProgressPlayerTwoTurn:
            [button setTitle:@"X" forState:UIControlStateNormal];
            [self.gameDescriptionLabel setText:@"Player Two's Turn"];
            break;
        case GameStatus_Tie:
            [button setTitle:@"X" forState:UIControlStateNormal];
            [self.gameDescriptionLabel setText:@"Tie Game!"];
            [self endGame];
            break;
        case GameStatus_PlayerOneWins:
            [button setTitle:@"X" forState:UIControlStateNormal];
            [self.gameDescriptionLabel setText:@"Player One Wins!"];
            [self endGame];
            break;
        case GameStatus_PlayerTwoWins:
            [button setTitle:@"O" forState:UIControlStateNormal];
            [self.gameDescriptionLabel setText:@"Player Two Wins!"];
            [self endGame];
            break;
    }
}

-(void)endGame {
    for (UIStackView *sv in self.gameStackView.subviews) {
        for (UIButton *button in sv.subviews) {
            if ([button isKindOfClass:[UIButton class]])
                [button setEnabled:NO];
        }
    }
    [self.resetButton setHidden:NO];
}

-(void) resetGame {
    self.gameBrain = [[GameBrain alloc] init];
    for (UIStackView *sv in self.gameStackView.subviews) {
        for (UIButton *button in sv.subviews) {
            if ([button isKindOfClass:[UIButton class]]) {
                [button setEnabled:YES];
                [button setTitle:@"-" forState:UIControlStateNormal];
            }
        }
    }
    [self.resetButton setHidden:YES];
    [self.gameDescriptionLabel setText:@"Player One's Turn"];
}

@end
