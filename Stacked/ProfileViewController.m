//
//  ProfileViewController.m
//  Stacked
//
//  Created by Stephen Sherwood on 2/18/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController () <UIScrollViewDelegate>
@property (retain, nonatomic) UIScrollView *scrollView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
  self.scrollView.contentSize = CGSizeMake(1500, 2000);
  
  UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 1000, 100, 50)];
  textfield.backgroundColor = [UIColor grayColor];
  [self.scrollView addSubview:textfield];
  [textfield release];
  
  self.scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
  [self.scrollView release];
  [super dealloc];
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
