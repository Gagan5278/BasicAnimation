//
//  AnimationViewController.h
//  BasicAnimation
//
//  Created by Gagan Mishra on 8/26/14.
//  Copyright (c) 2014 Gagan_Work. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    SpinAnimation,
    SpinWithAddedLayer,
    PathAnimation,
    ShakeAnimation,
    AnimationOnPath,
    AnimateWithSpeedControl,
    RepeatFallAnimation,
    LabelFade
}SelectedAnimation;

@interface AnimationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *shakeTextField;
@property (weak, nonatomic) IBOutlet UIView *spinnerView;
@property (weak, nonatomic) IBOutlet UIImageView *rotatingImageView;
@property(nonatomic)SelectedAnimation animationSelected;
//Below are used to show speed difference
@property (weak, nonatomic) IBOutlet UILabel *fadeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (weak, nonatomic) IBOutlet UIImageView *imageView6;
@end
