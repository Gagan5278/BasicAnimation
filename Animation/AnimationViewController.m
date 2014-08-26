//
//  AnimationViewController.m
//  BasicAnimation
//
//  Created by Gagan Mishra on 8/26/14.
//  Copyright (c) 2014 Gagan_Work. All rights reserved.
//

#import "AnimationViewController.h"
static CATransform3D RTSpinKit3DRotationWithPerspective(CGFloat perspective,
                                                        CGFloat angle,
                                                        CGFloat x,
                                                        CGFloat y,
                                                        CGFloat z)
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    return CATransform3DRotate(transform, angle, x, y, z);
}

@interface AnimationViewController ()

@end

@implementation AnimationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.shakeTextField.rightViewMode=UITextFieldViewModeAlways;
    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 26, 26)];
    imgView.image=[UIImage imageNamed:@"lock.png"];
    self.shakeTextField.rightView=imgView;
    [self performSelector:@selector(SelcetdAnimationOnView) withObject:nil afterDelay:0.0];
//    NSInvocationOperation *operation=[[NSInvocationOperation alloc]initWithTarget:self selector:@selector(StartAnimationOnView) object:nil];
//    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
//    [queue addOperation:operation];
//    [self.view bringSubviewToFront:self.spinnerView];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewTappedByUser:)];
//        tapGesture.numberOfTapsRequired=1;
//        [self.spinnerView addGestureRecognizer:tapGesture];
//    });
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
}

-(void)SelcetdAnimationOnView
{
    switch (self.animationSelected) {
        case SpinAnimation:
            [self SpinAnimation];
            break;
        case SpinWithAddedLayer:
            [self SpinWithAddedLayer];
            break;
        case PathAnimation:
            [self PathAnimation];
            break;
        case ShakeAnimation:
            [self ShakeAnimation];
            break;
        case AnimationOnPath:
            [self AnimationOnPath];
            break;
        case AnimateWithSpeedControl:
        {
            [ self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(SelcetdAnimationOnView)]];
            [self AnimateWithSpeedControl];
        }
             break;
        case RepeatFallAnimation:
        {
             [self RepeatFallAnimation];
        }
            break;
        case LabelFade:
        {
            [ self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(SelcetdAnimationOnView)]];
            [self LabelFade];
        }
            break;
        default:
            break;
    }
}

#pragma mark-1 Spin Animation
-(void)SpinAnimation
{
    self.spinnerView.backgroundColor=[UIColor clearColor];  //Modify according to your need
    self.spinnerView.userInteractionEnabled=YES;
    CABasicAnimation *spin;
    spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spin.fromValue = [NSNumber numberWithFloat:0];
    spin.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    spin.duration = 1.5; // How fast should spin
    spin.repeatCount = HUGE_VALF; // HUGE_VALF means infinite repeatCount;
    self.spinnerView.layer.contents=(id)[UIImage imageNamed:@"faceIcon.png"].CGImage;
    [self.spinnerView.layer addAnimation:spin forKey:@"Spin"];
}

#pragma -mark LabelFading
-(void)LabelFade
{
    self.fadeLabel.hidden=NO;
    self.spinnerView.hidden=YES;  //Hide Spinner View
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.fadeLabel.layer addAnimation:animation forKey:@"changeTextTransition"];
    if([[self.fadeLabel textColor] isEqual:[UIColor redColor]])
    {
        self.fadeLabel.textColor=[UIColor blackColor];
        self.fadeLabel.text = @"This is an example of lable fading with CATransistion";
    }
    else{
        self.fadeLabel.textColor=[UIColor redColor];
        self.fadeLabel.text = @"Change the text and the animation will occur";
    }
}

#pragma mark-2 Spin With added layer
-(void)SpinWithAddedLayer
{
    self.spinnerView.backgroundColor=[UIColor blueColor];  //Modify according to your need
    CALayer *plane = [CALayer layer];
    plane.frame = CGRectInset(self.spinnerView.bounds, 2.0, 2.0);
    plane.backgroundColor = [UIColor redColor].CGColor;
    plane.anchorPoint = CGPointMake(0.5, 0.5);
    plane.anchorPointZ = 0.5;
    plane.shouldRasterize = YES;
    plane.rasterizationScale = [[UIScreen mainScreen] scale];
    //    plane.contents=(id)[UIImage imageNamed:@"faceIcon.png"];
    [self.spinnerView.layer addSublayer:plane];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.removedOnCompletion = NO;
    anim.repeatCount = HUGE_VALF;
    anim.duration = 1.2;
    anim.keyTimes = @[@(0.0), @(0.5), @(1.0)];
    
    anim.timingFunctions = @[
                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                             ];
    
    anim.values = @[[NSValue valueWithCATransform3D:RTSpinKit3DRotationWithPerspective(1.0/120.0, 0, 0, 0, 0)],
                    [NSValue valueWithCATransform3D:RTSpinKit3DRotationWithPerspective(1.0/120.0, M_PI, 0.0, 1.0,0.0)],
                    [NSValue valueWithCATransform3D:RTSpinKit3DRotationWithPerspective(1.0/120.0, M_PI, 0.0, 0.0,1.0)]
                    ];
    self.spinnerView.layer.contents=(id)[UIImage imageNamed:@"faceIcon.png"].CGImage;
    [plane addAnimation:anim forKey:@"spin"];
}

-(void)RemoveAllAnimations
{
    for(CALayer *layer in self.spinnerView.layer.sublayers)
    {
        [layer removeFromSuperlayer];
    }
    [self.spinnerView.layer removeAllAnimations];
}

-(void)PathAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.x";  //can use position.y
    animation.fromValue = @0;  //From where you want move
    animation.toValue = @300;  //how much you want to move
    animation.duration = 1.8;
    //   animation.fillMode=kCAFillModeForwards;   //Add this line If you want to put on same position
    //   animation.removedOnCompletion=NO; //Add this line If you want to put on same position
    [self.spinnerView.layer addAnimation:animation forKey:@"basic"];
}

-(void)ShakeAnimation
{
    self.shakeTextField.hidden=NO;
    self.spinnerView.hidden=YES;
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animation];
    animation.keyPath=@"position.x";
    animation.values=@ [@0,@10,@-10,@10,@0];
    animation.keyTimes=@[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
    animation.duration=0.4;
    animation.additive=YES;
    [self.shakeTextField.layer addAnimation:animation forKey:@"shake"];
}

-(void)AnimationOnPath
{
    self.rotatingImageView.hidden=NO;
    CGRect boudingRect=CGRectMake(-100, -100, 200, 200);
    CAKeyframeAnimation *animationOrbit=[CAKeyframeAnimation animation];
    animationOrbit.keyPath=@"position";
    animationOrbit.path=CFAutorelease(CGPathCreateWithEllipseInRect(boudingRect, NULL));
    animationOrbit.duration=4.0;
    animationOrbit.additive=YES;
    animationOrbit.repeatCount=HUGE_VAL;
    animationOrbit.calculationMode=kCAAnimationPaced;
    animationOrbit.rotationMode=kCAAnimationRotateAuto;
    [self.rotatingImageView.layer addAnimation:animationOrbit forKey:@"orbit"];
}

#pragma mark-6 Animation with speed controll
-(void)AnimateWithSpeedControl
{
    self.imageView1.hidden=NO;
    self.imageView2.hidden=NO;
    self.imageView3.hidden=NO;
    self.imageView4.hidden=NO;
    self.imageView5.hidden=NO;
    self.imageView6.hidden=NO;
    self.spinnerView.hidden=YES;
    
    CABasicAnimation *animation1=[CABasicAnimation animation];
    animation1.keyPath=@"position.x";
    animation1.fromValue=@0;
    animation1.toValue=@300;
    animation1.duration=1.8;
    animation1.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//You can use following for different speed of moving object
    animation1.autoreverses=YES;
   [self.imageView1.layer addAnimation:animation1 forKey:@"basic"];
    
    CABasicAnimation *animation2=[CABasicAnimation animation];
    animation2.keyPath=@"position.x";
    animation2.fromValue=@0;
    animation2.toValue=@300;
    animation2.duration=1.8;
    animation2.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animation2.autoreverses=YES;
    [self.imageView2.layer addAnimation:animation2 forKey:@"basic"];
    
    CABasicAnimation *animation3=[CABasicAnimation animation];
    animation3.keyPath=@"position.x";
    animation3.fromValue=@0;
    animation3.toValue=@300;
    animation3.duration=1.8;
    animation3.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation3.autoreverses=YES;
    [self.imageView3.layer addAnimation:animation3 forKey:@"basic"];

    CABasicAnimation *animation4=[CABasicAnimation animation];
    animation4.keyPath=@"position.x";
    animation4.fromValue=@0;
    animation4.toValue=@300;
    animation4.duration=1.8;
    animation4.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation4.autoreverses=YES;
    [self.imageView4.layer addAnimation:animation4 forKey:@"basic"];

    CABasicAnimation *animation5=[CABasicAnimation animation];
    animation5.keyPath=@"position.x";
    animation5.fromValue=@0;
    animation5.toValue=@300;
    animation5.duration=1.8;
    animation5.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation5.autoreverses=YES;
    [self.imageView5.layer addAnimation:animation5 forKey:@"basic"];

    CABasicAnimation *animation6=[CABasicAnimation animation];
    animation6.keyPath=@"position.x";
    animation6.fromValue=@0;
    animation6.toValue=@300;
    animation6.duration=1.8;
    animation6.timingFunction=[CAMediaTimingFunction functionWithControlPoints:0.5:0:0.9:0.7];
    animation6.autoreverses=YES;
    [self.imageView6.layer addAnimation:animation5 forKey:@"basic"];
}

-(void)RepeatFallAnimation
{
    self.spinnerView.hidden=YES;
    self.imageView1.hidden=NO;
     // The keyPath to animate
    NSString *keyPath = @"transform.translation.y";
    
    // Allocate a CAKeyFrameAnimation for the specified keyPath.
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    translation.duration = 1.5f;
    translation.repeatCount = HUGE_VAL; // Set for repeat animation
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    // Add the start value
    // The animation starts at a y offset of 0.0
    [values addObject:[NSNumber numberWithFloat:0.0f]];
    
    // Add the end value
    // The animation finishes when the ball would contact the bottom of the screen
    // This point is calculated by finding the height of the applicationFrame
    // and subtracting the height of the ball.
    CGFloat height = [[UIScreen mainScreen] applicationFrame].size.height - self.imageView1.frame.size.height-44-20;
    [values addObject:[NSNumber numberWithFloat:height]];
    // Set the values that should be interpolated during the animation
    translation.values = values;
    translation.autoreverses=YES;
    [self.imageView1.layer addAnimation:translation forKey:keyPath];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self RemoveAllAnimations];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
