//
//  Questions.h
//  Stacked
//
//  Created by Stephen Sherwood on 2/18/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Questions : NSObject

+(NSArray *)questionsFromJSON:(NSData *)jsonData;

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *avatarURL;
@property (strong,nonatomic) UIImage *image;

@end
