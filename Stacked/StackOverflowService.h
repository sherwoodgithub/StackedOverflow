//
//  StackOverflowService.h
//  Stacked
//
//  Created by Stephen Sherwood on 2/18/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StackOverflowService : NSObject

+(id)sharedService;

-(void)fetchQuestionsWithSearchTerm:(NSString *)searchTerm completionHandler:(void (^)(NSArray *results, NSString *error))completionHandler;

-(void)fetchUserImage:(NSString *)avatarURL completionHandler:(void (^) (UIImage *image))completionHandler;

@end
