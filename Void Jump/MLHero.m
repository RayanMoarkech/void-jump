//
//  MLHero.m
//  Void Jump
//
//  Created by Rayan on 10/27/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import "MLHero.h"
#import "GameScene.h"
#import "GameViewController.h"
#import "MLPointsLabel.h"


static const uint32_t heroCategory = 0x1 << 0;
/* This is added to add the 2 objects that should be in contact or collision.
 The only 2 changes if we want to apply this code is the naming "heroCategory" and the value "0" at the end. Each Object should have a name and value different than other objects. */
/* heroCategory = 0x1 << 0
 0x1 is a hexadecimal 1
 << is the bitwise (meaning: designating an operator in a programming language that manipulates the individual bits in a byte or word) left shift operator
 0 is how many bits (an amount) places to shift to the left.
 In this case, take the value 1 and shift it 0 places left. So heroCategory = 1. (equations)
 You would write it out this way to keep consistency when writing out a lot of masks together.
 obstacleCategory = 0x1 << 1;
 Shift the Value 1, 1 bit to the left. So obstacleCategory = 2.*/
static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;


@interface MLHero ()
@property BOOL isJumping;
@end

@implementation MLHero{
    
    MLHero *hero;
    GameScene *gameScene;
    MLPointsLabel *pointsLabel;
    
    SKNode *world;
}


+ (id)hero {
    
    /* The + (id) is a code to name the class and give its properties, label, characters, naming... 
     The naming is usefull to enter the class from another class and use a void action or property... */
    
    MLHero *hero = [MLHero spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(40, 40)];
    
    /* Note:
     CGSizeMake is the Size of the object or thing which is = to (width, length)
     While CGPointMake is the Position of the object or thing which is = to (x,y). */
    SKSpriteNode *leftEye = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(5, 5)];
    leftEye.position = CGPointMake(-3, 8);
    [hero addChild:leftEye];
    
    /* SKSpriteNode *"..."
     The *"..." is the naming of the node to use...*/
    SKSpriteNode *rightEye = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(5, 5)];
    rightEye.position = CGPointMake(10, 8);
    [hero addChild:rightEye];
    
    hero.name = @"hero";
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hero.size];
    hero.physicsBody.categoryBitMask = heroCategory;
    hero.physicsBody.contactTestBitMask = obstacleCategory | groundCategory;
    hero.physicsBody.dynamic = YES;
    /*  "| ~groundCategory" means that you do not call the didBeganContact when the hero rans into a groundCategory. In other words, it is like the functions of "!" which is NOT. 
     We removed this ~ to active the land method of SKPhysicsContact of the Hero and Ground */
    
    
    return hero;
}



/* -(void)walkRight{
 
 
 SKAction *incrementRight = [SKAction moveByX:10 y:0 duration:0];
 [self runAction:incrementRight];
 
 }
 
 This is how we make the hero walk in a scertain direction when clicking when touches began code.
 With SKAction, you can do a lot of things such as move up or down, shrink, grow, turn around
 To see how and what to do you can go to Help feom XCode, then click Documentation and API Reference about SKAction */

-(void)jump
{
    if (!self.isJumping){
        /* REMEMBER: ! is not. */
        /* The applyImpulse CGVectorMake is the vector or push upward and to the front by (x,y) */
        [self.physicsBody applyImpulse:CGVectorMake(0, 40)];
        self.isJumping = YES;
    }
    
}



-(void)land
{
    
    self.isJumping = NO;
    /* To stop this small jump in some points just add this: "self.physicsBody.velocity = CGVectorMake(0,0);"
     The hero bounces slightly with the gravity simulation upon reaching the ground, so if the hero jump when the mini small after-bounce is on it's way down, the hero will jump a little lower because it has to offset the downward pull with the impulse. */
    
}

-(void)start
{
    
    SKAction *incrementRight;
    incrementRight = [SKAction moveByX:1.0 y:0 duration:0.0035];
    
    /* Increment means: an increase or addition, especially one of a series on a fixed scale */
    SKAction *moveRight = [SKAction repeatActionForever:incrementRight];
    /* reapeatActionForever: ... is that the ... (increementRight) will repeat forever moving right */
    [self runAction:moveRight];
    
}

-(void)faster
{
//    SKAction *incrementRight;
//    incrementRight = [SKAction moveByX:1.0 y:0 duration:1];
    NSLog(@"Score10");
    
}

-(void)stop
{
    
    [self removeAllActions];
    
}


@end




















