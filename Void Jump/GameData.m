//
//  GameData.m
//  Void Jump
//
//  Created by Rayan on 11/7/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import "GameData.h"

@interface GameData ()
@property NSString *filePath;
@end

@implementation GameData

+ (id)data
{
    
    GameData *data = [[GameData alloc] init];
    /* the [GameData new] is the same as [[GameData alloc] init] */
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    /* It grabs the paths in the NSDocumentDirectory that we can use to save this data in */
    NSString *fileName = @"archive.data";
    data.filePath = [path stringByAppendingPathComponent:fileName];
    /* Here we set the actual file path, we grab the path to the NSDocumentDirectory the default directory that we can save any data in.
     stringByAppendingString:fileName this is an NSString to append the fileName NSString to the end of another string of the path.
     This will make the full filePath data*/
    /* Append means add something as an attachment or supplement */
    /* Note that the last was [path stringByAppendingString:fileName] but the problem was it saves on simulator only... This code now work well*/
    
    return data;
    
}

-(void)save
{
    
    /* This save method is going to write a dataObject to the filePath */
    NSNumber *highscoreObject = [NSNumber numberWithInt:self.highscore];
    /* Here we convert the highscore to an NSNumber from an int because we can encode this NSNumber to a data file and save it in the app */
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:highscoreObject];
    /* This NSKeyedArchived class, we use it when we are encoding stuffs into data.
     So we call this class then you call the archivedDataWithRootObject function then it converts to the NSData object.
     And to write it in the app we code: */
    [data writeToFile:self.filePath atomically:YES];
    
}

-(void)load
{
    
    /* Here we make it access the data that we wrote. */
    /* 1st: Here we get the data at that filePath, and it will grab the data that we wrote in [data writeToFile...]
     2nd: Then we will recreate this NSNumber *highscoreObject from the 1st data. The NSKeyedUnarchiver it grabs the relavent data from the data files. This will restore the highscoreObject.
     And this should return our data into our game data Object. */
    NSData *data = [NSData dataWithContentsOfFile:self.filePath];
    NSNumber *highscoreObject = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    self.highscore = highscoreObject.intValue;
    
}

@end


































