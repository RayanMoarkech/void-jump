//
//  GameScene.m
//  Void Jump
//
//  Created by Rayan on 10/27/15.
//  Copyright (c) 2015 Rayan Moarkech. All rights reserved.
//

static const float iPhone6Plus_ScaleFactorX = 1.0;
static const float iPhone6Plus_ScaleFactorY = 1.0;
static const float iPhone6_ScaleFactorX = 0.90625;
static const float iPhone6_ScaleFactorY = 0.90579710144;
static const float iPhone5_ScaleFactorX = 0.77173913043;
static const float iPhone5_ScaleFactorY = 0.7729468599;
static const float iPhone4S_ScaleFactorX = 0.65217391304;
static const float iPhone4S_ScaleFactorY = 0.7729468599;

static const float iPadAir_ScaleFactorX = 1.39130434783;
static const float iPadAir_ScaleFactorY = 1.85507246377;
static const float iPadPro_ScaleFactorX = 1.85597826087;
static const float iPadPro_ScaleFactorY = 2.47342995169;

#import "GameScene.h"
#import "MLHero.h"
#import "MLWorldGenerator.h"
#import "MLPointsLabel.h"
#import "GameViewController.h"
#import "GameData.h"
#import "LoadingScreenView.h"


#import <AVFoundation/AVFoundation.h>

@interface GameScene ()
@property BOOL isStarted;
@property BOOL isGameOver;
@property BOOL isSwiping;
@property double currentCloud1X;
@property double currentCloud2X;
/* They are general properties, which can only be seen in the implimentation file.
 These initial properties are always set to false/NO unless activated to YES*/
@end

@implementation GameScene
{
    /* Global Variable.
     It is a faster naming for an ML or node.*/
    MLHero *hero;
    SKNode *world;
    MLWorldGenerator *generator;
    
    SKSpriteNode *ground;
    SKSpriteNode *obstacle;
    
    SKLabelNode *tapToBeginLabel;
    SKSpriteNode *touchView;
    MLPointsLabel *pointsLabel;
    MLPointsLabel *highscoreLabel;
    SKLabelNode *colorIndicatorLabel;
    SKLabelNode *bestLabel;
    SKLabelNode *gameOverLabel;
    SKLabelNode *tapToResetLabel;
    
    SKShapeNode *cloud1;
    SKShapeNode *cloud2;
    
    float scaleFactorX;
    float scaleFactorY;
    
    int labelColor;
    
    AVAudioPlayer *_backgroundMusicPlayer;
    AVAudioPlayer *_onPlayer;

}

/* WE ALWAYS SHOULD ADDCHILD A NODE WHEN WE CREATE IT TO WORK THE AND ACTIVATE THE NODE TO THE GAME. */


static NSString *GAME_FONT = @"AmericanTypewriter-Bold"; /* This is a short name of a font. */

-(id)initWithSize:(CGSize)size {
    
    /* both codes id and if were "-(void)didMoveToView:(SKView *)view {" only */
    
    if (self = [super initWithSize:size]) {
        
        /* Setup your scene here */
        
        /* In video there is a background color blue code (here) */
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        /* It is a protocol that we want to add to GameScene.
         A protocol is a promise to our Scene that we are going to implement certain methods.
         And here it is going be the method that is called when 2 physicsBodies collide one another.
         We will get an error when we add this, so to fix it, we go to the header file and add "<SKPhysicsContactDelegate>" */
        self.physicsWorld.contactDelegate = self;
        
        [self createContent];
        
    }
    return self;
    
}


-(void)didMoveToView:(SKView *)view {
    
    /* Here is to configurate the SKView Screen of the frame to be adjustable with the iDevice size.
     So we inset all the CGPointMake (position), CGSizeMake (size), Font and all nodes to be adjusted.
     We need to enter the Node as a general code to access it in all the methods code in the class. */
    
    if(view.frame.size.width == 736){
        NSLog(@"iPhone 6 Plus / 6S Plus");
        scaleFactorX = iPhone6Plus_ScaleFactorX;
        scaleFactorY = iPhone6Plus_ScaleFactorY;
    }
    if(view.frame.size.width == 667) {
        NSLog(@"iPhone 6 / 6S");
        scaleFactorX = iPhone6_ScaleFactorX;
        scaleFactorY = iPhone6_ScaleFactorY;
    }
    if(view.frame.size.width == 568) {
        NSLog(@"iPhone 5 / 5S / 5S");
        scaleFactorX = iPhone5_ScaleFactorX;
        scaleFactorY = iPhone5_ScaleFactorY;
    }
    if(view.frame.size.width == 480) {
        NSLog(@"iPhone 4S");
        scaleFactorX = iPhone4S_ScaleFactorX;
        scaleFactorY = iPhone4S_ScaleFactorY;
    }
    if (view.frame.size.width == 1024) {
        NSLog(@"iPad 2/3/4 / Air (1/2)");
        scaleFactorX = iPadAir_ScaleFactorX;
        scaleFactorY = iPadAir_ScaleFactorY;
    }
    if (view.frame.size.width == 1366) {
        NSLog(@"iPad Pro");
        scaleFactorX = iPadPro_ScaleFactorX;
        scaleFactorY = iPadPro_ScaleFactorY;
    }
    
    /* We insert here the Labels that always appears or appears in the begining of the GameScene. 
     The others Label such as gameOverLabel is insert with it's own property and action, but we should insert its global action so that the scaling factor view reads and apply its scaling to the Labels. */
    
    tapToBeginLabel.position = CGPointMake(0, 30 * scaleFactorY);
    tapToBeginLabel.fontSize = 30 * scaleFactorX;
    
    touchView.position = CGPointMake(120, - 100);
    touchView.size = CGSizeMake(87, 128);
    
    pointsLabel.position = CGPointMake(-200 * scaleFactorX, 140 * scaleFactorY);
    pointsLabel.fontSize = 60 * scaleFactorX;
    
    highscoreLabel.position = CGPointMake(200 * scaleFactorX, 140 * scaleFactorY);
    highscoreLabel.fontSize = 60 * scaleFactorX;
    
    
    if (highscoreLabel.number > 9){
        bestLabel.position = CGPointMake(-60 * scaleFactorX, 0);
    }
    if (highscoreLabel.number > 99){
        bestLabel.position = CGPointMake(-80 * scaleFactorX, 0);
    }
    if (highscoreLabel.number < 10){
        bestLabel.position = CGPointMake(-40, 0);
    }
 
    bestLabel.fontSize = 18 * scaleFactorX;
    
    
    colorIndicatorLabel.position = CGPointMake(0, -160 * scaleFactorY);
    colorIndicatorLabel.fontSize = 60 * scaleFactorX;
    
    
    
    cloud1.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10 * scaleFactorX, 95 * scaleFactorY, 100 * scaleFactorX, 40 * scaleFactorY)].CGPath;
    cloud2.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-270 * scaleFactorX, 55 * scaleFactorY, 100 * scaleFactorX, 40 * scaleFactorY)].CGPath;
    
}


-(void)createContent
{
    
    self.backgroundColor = [SKColor colorWithRed:0.5 green:0.785 blue:1.0 alpha:1.0];
    
   
    
    world = [SKNode node];
    [self addChild:world];
    
    generator = [MLWorldGenerator generatorWithWorld:world];
    [self addChild:generator];
    [generator populate];
    
    
    hero = [MLHero hero];
    [world addChild:hero];
    
    [self loadScoreLabels];
    
    tapToBeginLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    tapToBeginLabel.name = @"tapToBeginLabel";
    tapToBeginLabel.text = @"Tap to Begin";
    [self addChild:tapToBeginLabel];
    [self animationWithPulse:tapToBeginLabel];
    
    touchView = [SKSpriteNode spriteNodeWithImageNamed:@"touch.png"];
    touchView.name = @"touchTutorial";
    touchView.zPosition = 1;
    [self addChild:touchView];
    [self animationWithPulse:touchView];
    
    
    
    colorIndicatorLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    colorIndicatorLabel.name = @"colorIndicatorLabel";
    colorIndicatorLabel.text = @"";
    colorIndicatorLabel.hidden = YES;
    [self addChild:colorIndicatorLabel];
    
    
    
    

    [self populateCloud];
    
    [self stopBackGroundMusic];

                       
}









-(void)loadScoreLabels
{
    
    pointsLabel = [MLPointsLabel pointsLabelWithFontNamed: GAME_FONT];
    pointsLabel.name = @"pointsLabel";
    /* The pointsLabel.position is up to configurate the Label to the specific kind of iDevice
     We removed MLPointsLabel from the 1st statement because we want the pointsLabel to be a general */
    [self addChild:pointsLabel];
    
    /* The [data load] loads the highscore property from the data file. */
    GameData *data = [GameData data];
    [data load];
    
    highscoreLabel = [MLPointsLabel pointsLabelWithFontNamed:GAME_FONT];
    highscoreLabel.name = @"highscoreLabel";
    [highscoreLabel setPoints:data.highscore];
    /* Now wherever is loaded into that highscore property in the GameData class is going to go to the set in the highscoreLabel */
    [self addChild:highscoreLabel];
    
    bestLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    bestLabel.text = @"Best";
    [highscoreLabel addChild:bestLabel];
    
}

-(void)populateCloud
{

    
    for (int i = 0; i < 3; i++)
        [self loadClouds];
    
}

-(void)loadClouds
{
    
    cloud1 = [SKShapeNode node];
    /* we use the UIBezierPath to give the shape of the SKShapeNode as oval or rect... It is in the General and the sizing is in the SKview. */
    cloud1.fillColor = [UIColor whiteColor];
    /* stroke is the around of the shape or border */
    cloud1.strokeColor =[UIColor blackColor];
    /* We add the cloud to the world since the world move and it will allow the cloud to move. If we insert self the cloud will stay in its place */
    [world addChild:cloud1];
    
    cloud2 = [SKShapeNode node];
    cloud2.fillColor = [UIColor whiteColor];
    cloud2.strokeColor =[UIColor blackColor];
    [world addChild:cloud2];
    
    /* These one is extra for the iPad only.
    SKShapeNode *cloud3 = [SKShapeNode node];
    cloud3.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(250, 250, 100, 40)].CGPath;
    cloud3.fillColor = [UIColor whiteColor];
    cloud3.strokeColor =[UIColor blackColor];
    [world addChild:cloud3];
    
    SKShapeNode *cloud4 = [SKShapeNode node];
    cloud4.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-100, 208, 100, 40)].CGPath;
    cloud4.fillColor = [UIColor whiteColor];
    cloud4.strokeColor =[UIColor blackColor];
    [world addChild:cloud4]; */
    
    /* Remember we should call this method to the World in the createContent. */
    
    /* self.currentCloud1X += 700; */
    
}


-(void)start
{
    
    self.isStarted = YES;
    [[self childNodeWithName:@"tapToBeginLabel"] removeFromParent];
    [[self childNodeWithName:@"touchTutorial"] removeFromParent];
    [hero start];
//    [hero check];
    
    //in-Game Background Sound
    
    [self playAudio:(NSString *)@"inGame.mp3"];
    
//    SKAction *inGameSound = [SKAction playSoundFileNamed:@"inGame.mp3" waitForCompletion:NO];
//    [self runAction:(SKAction *)inGameSound
//            withKey:@"GameSound"];
    /* Or
     [self runAction:[[SKAction playSoundFileNamed:@"inGame.mp3" waitForCompletion:NO]]; */
    

    
    
    //This is how to get a
    /* UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(handleSwipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown]; */
    
}



-(void)clear
{
    /* We clear and reset the scene here.
     If the game is slow to load, we should use set everything back to zero here (It would take less process power), but now we will reset the Scene since it is easier to do. */
    
    GameScene *scene = [[GameScene alloc] initWithSize:self.frame.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:scene];
    
}

-(void)gameOver
{
    
    self.isGameOver = YES;
    [hero stop];
    
    gameOverLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    gameOverLabel.position = CGPointMake(0, 100 * scaleFactorX);
    gameOverLabel.name = @"gameOverLabel";
    gameOverLabel.text = @"Game Over";
    gameOverLabel.fontSize = 40 * scaleFactorX;
    [self addChild:gameOverLabel];
    
    tapToResetLabel = [SKLabelNode labelNodeWithFontNamed:GAME_FONT];
    tapToResetLabel.position = CGPointMake(0, 30 * scaleFactorY);
    tapToResetLabel.name = @"tapToResetLabel";
    tapToResetLabel.text = @"Tap to Retry";
    tapToResetLabel.fontSize = 30 * scaleFactorX;
    [self addChild:tapToResetLabel];
    [self animationWithPulse:tapToResetLabel];
    
    [self updateHighscore];
    
    if (highscoreLabel.number > 9){
        bestLabel.position = CGPointMake(-60 * scaleFactorX, 0);
    }
    if (highscoreLabel.number > 99){
        bestLabel.position = CGPointMake(-80 * scaleFactorX, 0);
    }
    if (highscoreLabel.number < 10){
        bestLabel.position = CGPointMake(-40, 0);
    }
    bestLabel.fontSize = 18 * scaleFactorX;
    
    //Sounds
    [self stopBackGroundMusic];
    [self onPlaySound:(NSString *)@"onGameOver.mp3"];
    
}

-(void)updateHighscore
{
    /* It will grab the Label we did for pointsLabel and highscoreLabel, and get their informations */
    pointsLabel = (MLPointsLabel *)[self childNodeWithName:@"pointsLabel"];
    highscoreLabel = (MLPointsLabel *)[self childNodeWithName:@"highscoreLabel"];
    
    if (pointsLabel.number > highscoreLabel.number){
        [highscoreLabel setPoints:pointsLabel.number];
        
        /* When this if statement is correct, it will grab again the Game data.
         the [data save] is like [self save] but we use data since it is not in this class but in the data class. This will save the highscore in the data Object to the data file */
        GameData *data = [GameData data];
        data.highscore = pointsLabel.number;
        [data save];
    }
    
    
    
    if (highscoreLabel.number > 9){
        bestLabel.position = CGPointMake(-60 * scaleFactorY, 0);
    }
    if (highscoreLabel.number > 99){
        bestLabel.position = CGPointMake(-80 * scaleFactorY, 0);
    }
    else{
        bestLabel.position = CGPointMake(-40 * scaleFactorY, 0);
    }

}


//
//-(void)checkSameColor
//{
//    if (wallColor == voidColor){
//        NSLog(@"Same Color");
//    } else {
//        NSLog(@"Different Color");
//    }
//}







-(void)didSimulatePhysics
{
    /* It will center the hero*/
    /* The pattern of the actions effects. */
    [self centerOnNode:hero];
    [self handlePoints];
    [self handleGeneration];
    [self handleCleanup];
    
}

-(void)handlePoints
{
    
    [world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x) {
            pointsLabel = (MLPointsLabel *)[self childNodeWithName:@"pointsLabel"];
            [pointsLabel incrementScore];
            
            if (pointsLabel.number > 2 && pointsLabel.number < 20) {
                //                [hero faster];
                //              self.paused = TRUE;
                //                [hero check];
                colorIndicatorLabel.hidden = NO;
                [self getRandomColor1];
                
            }
        }
    }];
    
    
    
}

-(void)handleGeneration
{
    /* The handleGeneration it is gonna call the Generator of the MLWorldGenerator class every single time the hero will jump above one of those obstacles. It will be continuesly be creating these grounds and obstacles nodes as you go along. */
    
    /* It grabs all the child nodes with a specific name from the scene because we called it from self which is word since self is the GameScene and we are changing the MLWordGenerator which is SKnode world. And lets you make an operation on all of them. */
    
    /* Here we can access the everything related to the obstacle
     The *node is the way you access each of these nodes as it goes through. 
     Stop is not a very big deal here, it is only to stop any numaration is rare cases. Here we ignored it. */
    
    /* A node is a point at which lines or pathways intersect or branch; a central or connecting point.
     The node.position.x here is nodes which refers to one of the obstacles. So here it is as such meaning: obstacle.position.x */
    [world enumerateChildNodesWithName:@"obstacle" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x){
            node.name = @"obstacle_cancelled";
            /* We named that process when hero passes an object "obstacle_cancelled" */
            [generator generate];
            /* Here the node is one of the obstacles... */
            /* (node.position.x < hero.position.x) means that when the hero passed the node which is an obstacle... */
        }
        
    }];
     
}

-(void)handleCleanup
{
    /* The handleCleanup method is to usually clean the sceen for bug purposes.
     In this way, we will decrease the % of bugs or slowly reaction of the application while running it. */
    
    [world enumerateChildNodesWithName:@"ground" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
            [node removeFromParent];
        }
    }];
    
    [world enumerateChildNodesWithName:@"obstacle_cancelled" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.x < hero.position.x - self.frame.size.width/2 - node.frame.size.width/2) {
            [node removeFromParent];
        }
    }];
    
}



-(void)centerOnNode:(SKNode *)node
{
    /* The hero is in the world not in the world rather than the scene,
     So we convert it from the world coordinates to the scene coordinates. 
     This is to center the Hero in Center of the SCENE not the World.
     So we subtract the world.position.x with positionInScene.x to center the Hero in the X-axis.
     If we subtract the world.position.y with positionInScene.y the Heo will be centered in the Y-axis, causing the Ground to lift up.*/
    CGPoint positionInScene = [self convertPoint:node.position fromNode:node.parent];
    world.position = CGPointMake(world.position.x - positionInScene.x, world.position.y);
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    /* [hero walkRight];
     We use this to activate the walk when touches began*/
    
    /* "!" means that "if it is not" self.isStarted it will self start */
    
    /* else is used when the 1st thing didn't verified it goes to the 2nd code... */
    
    if (!self.isStarted){
        [self start];
        [self onPlaySound:(NSString *)@"onClick.mp3"];

    }
    else if (self.isGameOver){
        [self onPlaySound:(NSString *)@"onClick.mp3"];
        [self clear]; /* When isGameOver is activated then the clear method is activated. */

    }
    else{
        [hero jump];
        [self onPlaySound:(NSString *)@"onJump.wav"];

    }
}


/*-(void)heroEdit
{
    
    if (self.isSwiping) {
        hero = [MLHero spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(50, 20)];
        
    }
    
    else {
        hero = [MLHero spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(40, 40)];
    }
    
} */

//UIGesture Sliding down the hero

/*-(void)handleSwipeDown
{
    
    self.isSwiping = YES;
    NSLog(@"ActivatedScroll");
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50, 10)];
    hero.physicsBody.dynamic = YES;
    
    stopScrolling = [NSTimer scheduledTimerWithTimeInterval:3
                                                     target:self
                                                   selector:@selector(stopScrollTimer)
                                                   userInfo:nil
                                                    repeats:YES];
    
}


-(void)stopScrollTimer
{
    
    NSLog(@"SrollStopping");
    hero.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(40, 40)];
    hero.physicsBody.dynamic = YES;
    
    
    
    [hero land];
    
} */



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


-(void)didBeginContact:(SKPhysicsContact *)contact
{
    
    if ([contact.bodyA.node.name isEqualToString: @"ground"] || [contact.bodyB.node.name isEqualToString:@"ground"]) {
        /* In this case, we cannot actually know which body is going to be the Hero and which body is going to be the Ground. So we insert the SKPhysicsContact of the Ground and Ground. So when this is activated, it means that something interacted or got in contact with Ground which is usually the Hero touching the Ground, when landing from the jump. The Obstacle and Ground doesn't interact with each other, so when the if (condition) is true, it means that the Hero is interacting with the Ground and nothing else. */
        [hero land];
    } else {
    
        /* This didBeginContact is for when 2 PhysicsBodies got on contact together. (Body A / Body B)
         It is used for a Hero with a door, enemy, object.
         Search SKPhysicsContact in the Documentation and API. */
        [self gameOver];
    }
}


// ** ANIMATION SECTION ** //
-(void)animationWithPulse:(SKNode *)node
{
    /* We use -(void)...:(SKNode*)node to self or use to a node.
     Here we used it for the Labels as a general Pulse then we add this Pulse to the Label by entering to the Label these codes:
     [self animateWithPulse:tapToBeginLabel]; which the animateWithPulse is the Void Action for a node, and which selfs it to the tapToBeginLabel which is a node, SKLabelNode. */
    
    SKAction *disappear = [SKAction fadeAlphaTo:0.0 duration:0.6];
    /* The fadeAlphaTo is the Alpha which means the brightness of the object or label 0.0 which is invisible or hidden, and 1.0 which is clear and visible. */
    SKAction *appear = [SKAction fadeAlphaTo:1.0 duration:0.6];
    SKAction *pulse = [SKAction sequence:@[disappear, appear]];
    /* This SKAction sequence it takes an NSArray of other actions that will run them in sequence and repeat it over and over again. */
    [tapToBeginLabel runAction:[SKAction repeatActionForever:pulse]];
    
    
    //This is for the Touch Tutorial View pulsation.
    SKAction *fadeOut = [SKAction fadeAlphaTo:0.3 duration:0.6];
    SKAction *fadeIn = [SKAction fadeAlphaTo:1 duration:0.6];
    SKAction *pulseFinger = [SKAction sequence:@[fadeOut, fadeIn]];
    [touchView runAction:[SKAction repeatActionForever:pulseFinger]];
    
}



// ** SOUND AUDIO SECTION ** //

    //  inGame Sound Play-Stop
- (void)playAudio:(NSString *)filename
{
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    _backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    _backgroundMusicPlayer.numberOfLoops = -1;
    [_backgroundMusicPlayer prepareToPlay];
    [_backgroundMusicPlayer play];
}

-(void)stopBackGroundMusic
{
    [_backgroundMusicPlayer stop];
    
}


    //  onGameOver Sound Play-Stop
- (void)onPlaySound:(NSString *)filename
{
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    _onPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    _onPlayer.numberOfLoops = 0;
    _onPlayer.volume = 0.3;
    [_onPlayer prepareToPlay];
    [_onPlayer play];
}

-(void)stopOnSound
{
    // If neccessary.
    [_onPlayer stop];
}



//Random colorIndicatorLabel

-(UIColor *)getRandomColor1
{
    
    int rand = arc4random() % 4;
    
    switch (rand) {
        case 0:
            colorIndicatorLabel.hidden = NO;
            colorIndicatorLabel.text = @"Blue";
            colorIndicatorLabel.fontColor = [UIColor blueColor];
            labelColor = 1;
            NSLog(@"Blue is activated");
            break;
        case 1:
            colorIndicatorLabel.hidden = NO;
            colorIndicatorLabel.text = @"Red";
            colorIndicatorLabel.fontColor = [UIColor redColor];
            labelColor = 2;
            NSLog(@"Red is activated");
            break;
        case 2:
            colorIndicatorLabel.hidden = NO;
            colorIndicatorLabel.text = @"Black";
            colorIndicatorLabel.fontColor = [UIColor blackColor];
            labelColor = 3;
            NSLog(@"Black is activated");
            break;
        case 3:
            colorIndicatorLabel.hidden = NO;
            colorIndicatorLabel.text = @"Green";
            colorIndicatorLabel.fontColor = [UIColor greenColor];
            labelColor = 4;
            NSLog(@"Green is activated");
            break;
    }
    
    return colorIndicatorLabel.fontColor;
    
}




@end






























