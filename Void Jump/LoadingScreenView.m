//
//  LoadingScreenView.m
//  Void Jump
//
//  Created by Rayan Moarkech on 12/30/15.
//  Copyright © 2015 Rayan Moarkech. All rights reserved.
//

#import "LoadingScreenView.h"
#import "MenuViewController.h"
#import "GameScene.h"
#import <AVFoundation/AVFoundation.h>

@interface LoadingScreenView ()

@end

@implementation LoadingScreenView{
    
    AVAudioPlayer *_backgroundSound;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self performSelector:@selector(loadingNextView)
               withObject:nil afterDelay:5.0];
    
    loadingImage.animationImages = [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"LS2.png"],
                                    [UIImage imageNamed:@"LS3.png"],
                                    [UIImage imageNamed:@"LS4.png"],
                                    [UIImage imageNamed:@"LS5.png"], nil];
    [loadingImage setAnimationRepeatCount:1];
    loadingImage.animationDuration = 3;
    [loadingImage startAnimating];
    
    [self performSelector:@selector(loadingFadeOut) withObject:nil afterDelay:3];
    
    [self inBackgroundSound:(NSString *)@"inBackSound1.mp3"];
    
    
}


-(void)loadingFadeOut{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [loadingImage setAlpha:0];
    [UIView commitAnimations];
    
    [self performSelector:@selector(doneFadeIn) withObject:nil afterDelay:1];
}

-(void)doneFadeIn{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [doneImage setAlpha:1];
    [UIView commitAnimations];
    
    [self performSelector:@selector(doneFadeOut) withObject:nil afterDelay:1.5];
}

-(void)doneFadeOut{
    
    copyright.hidden = YES;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [doneImage setAlpha:0];
    [backGroundLaunchImage setAlpha:0];
    [UIView commitAnimations];
    
    [self performSelector:@selector(loadingNextView) withObject:nil afterDelay:1];
}

- (void)loadingNextView{
                        
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    [self presentViewController:vc animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)inBackgroundSound:(NSString *)filename
{
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    _backgroundSound = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    _backgroundSound.numberOfLoops = 0;
    _backgroundSound.volume = 0.25;
    [_backgroundSound prepareToPlay];
    [_backgroundSound play];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
