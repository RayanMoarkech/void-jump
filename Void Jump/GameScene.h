//
//  GameScene.h
//  Void Jump
//

//  Copyright (c) 2015 Rayan Moarkech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>
{
    //NSTimer *stopScrolling;
}

/* The <SKPhysicsContactDelegate> is sets the protocol, or the promise. */

-(id)initWithSize:(CGSize)size;
-(void)didMoveToView:(SKView *)view;
-(void)onPlaySound:(NSString *)filename;

//-(void)handleSwipeDown;
//-(void)handleSwipeUp;


@end
