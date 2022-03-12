//
//  MLHero.h
//  Void Jump
//
//  Created by Rayan on 10/27/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MLHero : SKSpriteNode

+ (id)hero;
-(void)jump;
-(void)start;
-(void)faster;
-(void)stop;
-(void)land;

@end
