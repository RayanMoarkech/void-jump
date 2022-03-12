//
//  MenuViewController.h
//  Void Jump
//
//  Created by Rayan on 11/20/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <AVFoundation/AVFoundation.h>

@interface MenuViewController : UIViewController <ADBannerViewDelegate>{
    
    IBOutlet UIButton *playGame;
    IBOutlet UIButton *howToPlay;
    IBOutlet UIButton *about;
    
    AVAudioPlayer *onClick;
}

@property (weak, nonatomic) IBOutlet ADBannerView *menuAD;

-(IBAction)soundButton:(id)sender;


@end
