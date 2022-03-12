//
//  MLPointsLabel.h
//  Void Jump
//
//  Created by Rayan on 10/30/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MLPointsLabel : SKLabelNode
@property int number;

+ (id)pointsLabelWithFontNamed:(NSString *)fontName;
-(void)incrementScore;
-(void)setPoints:(int)points;
-(void)reset;

@end
