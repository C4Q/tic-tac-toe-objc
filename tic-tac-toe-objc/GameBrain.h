//
//  GameBrain.h
//  tic-tac-toe-objc
//
//  Created by C4Q  on 5/14/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, GameStatus) {
    GameStatus_Tie,
    GameStatus_PlayerOneWins,
    GameStatus_PlayerTwoWins,
    GameStatus_InProgressPlayerOneTurn,
    GameStatus_InProgressPlayerTwoTurn,
    GameStatus_InvalidMove
};

@interface GameBrain : NSObject

@property (strong, nonatomic) NSMutableArray* gameBoard;
@property (assign) BOOL isPlayerOnesTurn;

-(GameStatus) makeMoveAtX:(int) x andY: (int) y;

@end
