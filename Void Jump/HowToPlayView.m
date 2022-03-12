//
//  HowToPlayView.m
//  Void Jump
//
//  Created by Rayan on 11/22/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import "HowToPlayView.h"

@interface HowToPlayView ()

@end

@implementation HowToPlayView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    // Make self the delegate of the ad banner.
    self.howtoplayAD.delegate = self;
    
    // Initially hide the ad banner.
    self.howtoplayAD.alpha = 0.0;

    
    
    
    
    /*This way Didn't work with me ;(
     
    //Create an animation with pulsating effect
    CABasicAnimation *theAnimation;
    
    //within the animation we will adjust the "opacity"
    //value of the layer
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    //animation lasts 0.4 seconds
    theAnimation.duration=0.6;
    //and it repeats forever
    theAnimation.repeatCount=HUGE_VALF;
    //we want a reverse animation
    theAnimation.autoreverses=YES;
    //justify the opacity as you like (1=fully visible, 0=unvisible)
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:0];
    
    //Assign the animation to your UIImage layer and the
    //animation will start immediately
    [touchView.layer addAnimation:theAnimation forKey:@"animateOpacity"];*/
    
    

    
    [self flashOn:touchView];
    [self flashOn:playButton];
}

-(IBAction)soundButton:(id)sender{
    [self onPlaySound:(NSString *)@"onClick.mp3"];
    
}

- (void)flashOff:(UIView *)pulse
{
    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction animations:^ {
                            pulse.alpha = 0.3;  //don't animate alpha to 0, otherwise you won't be able to interact with it
                        }
                     completion:^(BOOL finished) {
                         [self flashOn:pulse];
    }];
}

- (void)flashOn:(UIView *)pulse
{
    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction animations:^ {
                            pulse.alpha = 1;
                        }
                     completion:^(BOOL finished) {
                         [self flashOff:pulse];
    }];
}


- (void)onPlaySound:(NSString *)filename
{
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    onClick = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    onClick.numberOfLoops = 0;
    [onClick prepareToPlay];
    [onClick play];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - AdBannerViewDelegate method implementation

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner will load ad.");
}


-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
    
    // Show the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.howtoplayAD.alpha = 1.0;
    }];
}


-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    NSLog(@"Ad Banner action is about to begin.");
    
    return YES;
}


-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad Banner action did finish");
    
    
}


-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Unable to show ads. Error: %@", [error localizedDescription]);
    
    // Hide the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.howtoplayAD.alpha = 0.0;
    }];
}


@end
