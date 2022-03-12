//
//  MLPointsLabel.m
//  Void Jump
//
//  Created by Rayan on 10/30/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import "MLPointsLabel.h"
#import "MLHero.h"
#import "MLWorldGenerator.h"

@implementation MLPointsLabel


+ (id)pointsLabelWithFontNamed:(NSString *)fontName
{
    
    MLPointsLabel *pointsLabel = [MLPointsLabel labelNodeWithFontNamed:fontName];
    /* We named th SKSpriteLabel as MLPointsLabel and not as SKLabelNode, to give this Label a number, which is only compatible with a specific own class, so we create its own class which is MLPointsLabel.m/h. */
    pointsLabel.text = @"0";
    pointsLabel.number = 0;

    return pointsLabel;
}

-(void)incrementScore
{
 
    /* It is going to increase the Score points by ONE and change the text to show the scores. */
    /* self stands for the pointsLabel
     If we replace the self with the "pointsLabel", we will have an error since pointsLabel is to reffer to the MLPointsLabel class since we added to the (id) the name pointsLabel to get in this class from the outside.
     If we want to use the pointsLabel in its own class, we use self. */
    
    self.number++;
    self.text = [NSString stringWithFormat:@"%i", self.number];
    
    /* The NSString is a way to use stringWithFormate to formate the NSString to a number or value text.
     Such as here we used %i i standing for integer and to be formate and take place of the pointsLabel to increment the Score number of the pointsLabel. */
    
}

-(void)setPoints:(int)points
{
    
    self.number = points;
    self.text = [NSString stringWithFormat:@"%i", self.number];
    
}

-(void)reset
{
    
    self.number = 0;
    self.text = @"0";
    
}

@end
