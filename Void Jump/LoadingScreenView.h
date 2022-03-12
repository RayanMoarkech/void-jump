//
//  LoadingScreenView.h
//  Void Jump
//
//  Created by Rayan Moarkech on 12/30/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LoadingScreenView : UIViewController{
    
    IBOutlet UIImageView *loadingImage;
    IBOutlet UIImageView *doneImage;
    IBOutlet UIImageView *backGroundLaunchImage;
    
    IBOutlet UILabel *copyright;
}

-(void)loadingFadeOut;
-(void)doneFadeIn;
-(void)doneFadeOut;
-(void)loadingNextView;

@end
