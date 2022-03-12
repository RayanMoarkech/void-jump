//
//  MLWorldGenerator.m
//  Void Jump
//
//  Created by Rayan on 10/27/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import "MLWorldGenerator.h"
#import "MLPointsLabel.h"


@interface MLWorldGenerator ()
@property double currentGroundX;
@property double currentObstacleX;
/* Keep track of the last position "3al 7affe" and add the other object next to it. */
@property SKNode *worldnode;
@end

@implementation MLWorldGenerator{

    MLPointsLabel *pointsLabel;
    
    int yValue;
    int yPosition;
    
    float scaleFactorX;
    float scaleFactorY;
}

static const uint32_t obstacleCategory = 0x1 << 1;
static const uint32_t groundCategory = 0x1 << 2;

+ (id)generatorWithWorld:(SKNode *)world
{
    
    MLWorldGenerator *generator = [MLWorldGenerator node];
    generator.currentGroundX = 0;
    /* This is the Position of the first Obstacle in the World */
    generator.currentObstacleX = 400;
    generator.worldnode = world;

    return generator;
}


-(void)populate
{
    /* This means that when the Game starts the Ground and Obstacles is at 0 and repeats at least 3 times or any entered number then stops. */
    for (int i = 0; i < 3; i++)
        [self generate];
    
}


-(void)generate
{
    
    SKSpriteNode *ground = [SKSpriteNode spriteNodeWithImageNamed:@"Ground.png"];
    ground.size = CGSizeMake(self.scene.frame.size.width, self.scene.frame.size.height/3);
    ground.name = @"ground";
    /* Always name the node to access it.
     Such as here : (enumerateChildNodesWithName:@"obstacle") we used the name to refer it in the handleGeration action. */
    ground.position = CGPointMake(self.currentGroundX, -self.scene.frame.size.height/3);
    /* The -self.scene.frame.height/2 it puts the object to be in the bottom of the screen starting from the bottom of the screen till the object's height finishes. */
    
    /* We use a lot SKSpiriteNode in SpiriteKit
     To Add this new SKSpiriteNode to the background use the addChild or addParent only on SpriteKit */
    /* We set the PhysicsBody to set the gravity and real life...
     And here we set the PhysicsBody for ground but disable it "= NO" because when we set the the PhysicsBody for the Hero
     the hero will interact with the Gound PhysicsBody so that the Hero does fall "as gravity with no ground" */
    ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:ground.size];
    /* With this method (.dynamic),
     the ground isn't affected by the gravity anymore. */
    ground.physicsBody.dynamic = NO;
    ground.physicsBody.categoryBitMask = groundCategory;
    [self.worldnode addChild:ground];
    
    /* It add the times the ground to be appeared and this is enabled from the populate method. */
    self.currentGroundX += ground.frame.size.width;
    
    
    
    SKSpriteNode *obstacle = [SKSpriteNode spriteNodeWithTexture:[self getRandomImage]];
    obstacle.size = CGSizeMake(40, 60);
    obstacle.name = @"obstacle";
    
    if (self.currentObstacleX == 400) {
        obstacle.position = CGPointMake(self.currentObstacleX, ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height/2);
    }
    else{
        obstacle.position = CGPointMake(self.currentObstacleX, yPosition);

    }
    
    obstacle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:obstacle.size];
    obstacle.physicsBody.dynamic = NO;
    obstacle.physicsBody.categoryBitMask = obstacleCategory;
    [self.worldnode addChild:obstacle];
    
    
    self.currentObstacleX += 270;
    
    
    
    int rand = arc4random() % 4;
    
    switch (rand) {
        case 0:
            yPosition = ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height/2;
            break;
        case 1:
            yPosition = ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height/2;
            break;
        case 2:
            yPosition = ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height/2;
            break;
        case 3:
            yPosition = ground.position.y + ground.frame.size.height/2 + obstacle.frame.size.height * 1.2;
            break;
            
        default:
            break;
    }
    
    
    
    //Thi
    /* if(self.scene.frame.size.width == 736){
        NSLog(@"iPhone 6 Plus / 6S Plus");
        scaleFactorX = iPhone6Plus_ScaleFactorX;
        scaleFactorY = iPhone6Plus_ScaleFactorY;
    }
    if(self.scene.frame.size.width == 667) {
        NSLog(@"iPhone 6 / 6S");
        scaleFactorX = iPhone6_ScaleFactorX;
        scaleFactorY = iPhone6_ScaleFactorY;
    }
    if(self.scene.frame.size.width == 568) {
        NSLog(@"iPhone 5 / 5S / 5S");
        scaleFactorX = iPhone5_ScaleFactorX;
        scaleFactorY = iPhone5_ScaleFactorY;
    }
    if(self.scene.frame.size.width == 480) {
        NSLog(@"iPhone 4S");
        scaleFactorX = iPhone4S_ScaleFactorX;
        scaleFactorY = iPhone4S_ScaleFactorY;
    }
    if (self.scene.frame.size.width == 1024) {
        NSLog(@"iPad 2/3/4 / Air (1/2)");
        scaleFactorX = iPadAir_ScaleFactorX;
        scaleFactorY = iPadAir_ScaleFactorY;
    }
    if (self.scene.frame.size.width == 1366) {
        NSLog(@"iPad Pro");
        scaleFactorX = iPadPro_ScaleFactorX;
        scaleFactorY = iPadPro_ScaleFactorY;
    }
    */
    

}





/** This is an example of randomizing the Colors.
 -(UIColor *)getRandomColor
{
    We use the "%" sign to divide the big number by 6 and then takes the remander and sets that to the random value.
     The 6 is the number of stuffs to rendomize such as now 6 different colors to randomize.
    
    int rand = arc4random() % 6;
    
    UIColor *color;
    switch (rand) {
        case 0:
            color = [UIColor redColor];
            break;
        case 1:
            color = [UIColor orangeColor];
            break;
        case 2:
            color = [UIColor yellowColor];
            break;
        case 3:
            color = [UIColor greenColor];
            break;
        case 4:
            color = [UIColor purpleColor];
            break;
        case 5:
            color = [UIColor blueColor];
            break;
            
        default:
            break;
    }
    
    return color;
} **/

-(SKTexture *)getRandomImage
{
    
    int rand = arc4random() % 7;
    
    SKTexture *wall;
    switch (rand) {
        case 0:
            wall = [SKTexture textureWithImageNamed:@"Wall.jpg"];
            break;
        case 1:
            wall = [SKTexture textureWithImageNamed:@"Wall1.jpg"];
            break;
        case 2:
            wall = [SKTexture textureWithImageNamed:@"Wall2.jpeg"];
            break;
        case 3:
            wall = [SKTexture textureWithImageNamed:@"Wall3.jpeg"];
            break;
        case 4:
            wall = [SKTexture textureWithImageNamed:@"Wall4.jpeg"];
            break;
        case 5:
            wall = [SKTexture textureWithImageNamed:@"Wall5.jpeg"];
            break;
        case 6:
            wall = [SKTexture textureWithImageNamed:@"Wall6.png"];
            break;
            
        default:
            break;
    }
    
    return wall;

}

@end




























