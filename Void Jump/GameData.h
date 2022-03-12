//
//  GameData.h
//  Void Jump
//
//  Created by Rayan on 11/7/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property int highscore;
+(id)data;
-(void)save;
-(void)load;

@end
