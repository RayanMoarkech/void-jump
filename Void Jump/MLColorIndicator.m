//
//  MLColorIndicator.m
//  Void Jump
//
//  Created by Rayan Moarkech on 4/12/16.
//  Copyright © 2016 Rayan Moarkech. All rights reserved.
//

#import "MLColorIndicator.h"
#import "MLHero.h"
#import "MLWorldGenerator.h"

@implementation MLColorIndicator{
    int labelColor;
    MLColorIndicator *colorIndicator;
}

static NSString *GAME_FONT = @"AmericanTypewriter-Bold";

+ (id)colorLabelWithFontNamed:(NSString *)fontName{
    
    MLColorIndicator *colorIndicator = [MLColorIndicator labelNodeWithFontNamed:fontName];
    colorIndicator.text = @"HI";
    colorIndicator.color = [UIColor whiteColor];
    
    
    return colorIndicator;
}

-(MLColorIndicator *)getRandomColor
{
    
    int rand = arc4random() % 4;
    
    switch (rand) {
        case 0:
            colorIndicator = [MLColorIndicator labelNodeWithFontNamed:GAME_FONT];
            self.text = @"Blue";
            colorIndicator.color = [UIColor blueColor];
            labelColor = 1;
            break;
        case 1:
            colorIndicator = [MLColorIndicator labelNodeWithFontNamed:GAME_FONT];
            self.text = @"Red";
            colorIndicator.color = [UIColor redColor];
            labelColor = 2;
            break;
        case 2:
            colorIndicator = [MLColorIndicator labelNodeWithFontNamed:GAME_FONT];
            self.text = @"Black";
            colorIndicator.color = [UIColor blackColor];
            labelColor = 3;
            break;
        case 3:
            colorIndicator = [MLColorIndicator labelNodeWithFontNamed:GAME_FONT];
            self.text = @"Green";
            colorIndicator.color = [UIColor greenColor];
            labelColor = 4;
            break;
    }
    
    return colorIndicator;
    
}


@end
