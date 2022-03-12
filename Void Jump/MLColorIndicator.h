//
//  MLColorIndicator.h
//  Void Jump
//
//  Created by Rayan Moarkech on 4/12/16.
//  Copyright © 2016 Rayan Moarkech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MLColorIndicator : SKLabelNode

+ (id)colorLabelWithFontNamed:(NSString *)fontName;
-(SKLabelNode *)getRandomColor;

@end
