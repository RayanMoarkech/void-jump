//
//  MenuViewController.m
//  Void Jump
//
//  Created by Rayan on 11/20/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import "MenuViewController.h"
#import "GameData.h"
#import "GameScene.h"
#import "MLPointsLabel.h"

@interface MenuViewController ()

@end

@implementation MenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Make self the delegate of the ad banner.
    self.menuAD.delegate = self;
    
    // Initially hide the ad banner.
    self.menuAD.alpha = 0.0;
    
    [self performSelector:@selector(buttonAnimation) withObject:nil afterDelay:0.25];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)soundButton:(id)sender{
    [self onPlaySound:(NSString *)@"onClick.mp3"];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




-(void)buttonAnimation{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0];
    [UIView setAnimationDuration:1];
    [playGame setAlpha:1];
    [UIView setAnimationDuration:2];
    [howToPlay setAlpha:1];
    [UIView setAnimationDuration:3];
    [about setAlpha:1];
    [UIView commitAnimations];
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






#pragma mark - AdBannerViewDelegate method implementation

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner will load ad.");
}


-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad Banner did load ad.");
    
    // Show the ad banner.
    [UIView animateWithDuration:0.5 animations:^{
        self.menuAD.alpha = 1.0;
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
        self.menuAD.alpha = 0.0;
    }];
}


@end
