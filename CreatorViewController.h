//
//  CreatorViewController.h
//  Void Jump
//
//  Created by Rayan on 11/22/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <AVFoundation/AVFoundation.h>

@interface CreatorViewController : UIViewController <ADBannerViewDelegate>{
    
    AVAudioPlayer *onClick;
}

@property (weak, nonatomic) IBOutlet ADBannerView *creatorAD;

-(IBAction)soundButton:(id)sender;

@end
