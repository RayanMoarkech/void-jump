//
//  MLWorldGenerator.h
//  Void Jump
//
//  Created by Rayan on 10/27/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"

@interface MLWorldGenerator : SKSpriteNode

+ (id)generatorWithWorld:(SKNode *)world;
-(void)populate;
-(void)generate;
//-(void)changeColor;
-(UIColor *)getRandomColor2;

@property (nonatomic,assign) int wallColor;
@property (nonatomic,assign) int positionX;


@end
