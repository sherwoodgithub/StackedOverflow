//
//  BurgerContainerViewController.m
//  Stacked
//
//  Created by Stephen on 2/16/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import "BurgerContainerViewController.h"

@interface BurgerContainerViewController ()

@property (strong, nonatomic) UIViewController *topViewController;
@property (strong, nonatomic) UINavigationController *searchViewController;
@property (strong, nonatomic) UIButton *burgerButton;
@property (strong, nonatomic) UITapGestureRecognizer *tapToClose;
@property (strong, nonatomic) UIPanGestureRecognizer *slideRecognizer;

@end

@implementation BurgerContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.searchViewController];
    self.searchViewController.view.frame = self.view.frame;
    [self.view addSubview:self.searchViewController.view];
    [self.searchViewController didMoveToParentViewController:self];
    self.topViewController = self.searchViewController;
    
    //set up burger button
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 50, 50)];
    [button setBackgroundImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(burgerButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.searchViewController.view addSubview:button];
    self.burgerButton = button;

    self.tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePanel)];
    
    self.slideRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slidePanel:)];
    [self.topViewController.view addGestureRecognizer:self.slideRecognizer];

}

-(void) burgerButtonPressed {
    self.burgerButton.userInteractionEnabled = false;
    __weak BurgerContainerViewController * weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.topViewController.view.center = CGPointMake(weakSelf.topViewController.view.center.x + 330, weakSelf.topViewController.view.center.y);
    } completion:^(BOOL finished) {
        [weakSelf.topViewController.view addGestureRecognizer:weakSelf.tapToClose];
    }];
}

-(void)closePanel {
    
    [self.topViewController.view removeGestureRecognizer:self.tapToClose];
    __weak BurgerContainerViewController *weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.topViewController.view.center = weakSelf.view.center;
    } completion:^(BOOL finished) {
        weakSelf.burgerButton.userInteractionEnabled = true;
    }];
}

-(void)slidePanel:(id)sender{
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
    CGPoint translation = [pan translationInView:self.view];
    CGPoint velocity = [pan velocityInView:self.view];
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        if (velocity.x > 0 || self.topViewController.view.frame.origin.x > 0) {
            self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translation.x, self.topViewController.view.center.y);
            [pan setTranslation:CGPointZero inView:self.view];
        }
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        __weak BurgerContainerViewController *weakSelf = self;
        if (self.topViewController.view.frame.origin.x > self.view.frame.size.width / 2) {
            self.burgerButton.userInteractionEnabled = false;
            [UIView animateWithDuration:0.3 animations:^{
                self.topViewController.view.center = CGPointMake(weakSelf.view.frame.size.width * 1.2, weakSelf.topViewController.view.center.y);
            } completion:^(BOOL finished) {
                [weakSelf.topViewController.view addGestureRecognizer:weakSelf.tapToClose];
            }];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                weakSelf.topViewController.view.center = weakSelf.view.center;
            }];
            [self.topViewController.view removeGestureRecognizer:self.tapToClose];
        }
    }
}

-(UINavigationController *) searchViewController {
    if (!_searchViewController) {
        _searchViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SEARCH_VIEWCONTROLLER"];
    }
    return _searchViewController;
}
@end
