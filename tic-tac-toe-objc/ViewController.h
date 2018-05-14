//
//  ViewController.h
//  tic-tac-toe-objc
//
//  Created by C4Q  on 5/14/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameBrain.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) UIStackView* gameStackView;
@property (strong, nonatomic) UILabel* gameDescriptionLabel;
@property (strong, nonatomic) UIButton* resetButton;
@property (strong, nonatomic) GameBrain* gameBrain;

@end

