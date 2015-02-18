//
//  MenuTableViewController.h
//  Stacked
//
//  Created by Stephen on 2/16/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuPressedDelegate.h"

@interface MenuTableViewController : UITableViewController

@property (weak,nonatomic) id<MenuPressedDelegate> delegate;

@end
