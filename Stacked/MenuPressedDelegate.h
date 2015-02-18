//
//  MenuPressedDelegate.h
//  Stacked
//
//  Created by Stephen Sherwood on 2/18/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MenuPressedDelegate <NSObject>

-(void)menuOptionSelected:(NSInteger)selectedRow;

@end
