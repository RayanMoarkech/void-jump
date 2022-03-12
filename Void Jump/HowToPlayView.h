//
//  HowToPlayView.h
//  Void Jump
//
//  Created by Rayan on 11/22/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface HowToPlayView : UIViewController <ADBannerViewDelegate>{
    
    IBOutlet UIImageView *touchView;
    IBOutlet UIButton *playButton;
    AVAudioPlayer *onClick;
}

@property (weak, nonatomic) IBOutlet ADBannerView *howtoplayAD;

-(IBAction)soundButton:(id)sender;

@end
