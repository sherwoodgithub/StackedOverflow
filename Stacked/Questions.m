//
//  Questions.m
//  Stacked
//
//  Created by Stephen Sherwood on 2/18/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import "Questions.h"

@implementation Questions

+(NSArray *)questionsFromJSON:(NSData *)jsonData {
  
  NSError *error;
  NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
  if (error) {
    NSLog(@"%@",error.localizedDescription);
    return nil;
  }
  
  NSArray *items = [jsonDictionary objectForKey:@"items"];
  
  NSMutableArray *temp = [[NSMutableArray alloc] init];
  
  for (NSDictionary *item in items) {
    Questions *question = [[Questions alloc] init];
    question.title = item[@"title"];
    NSDictionary *userInfo = item[@"owner"];
    question.avatarURL = userInfo[@"profile_image"];
    
    [temp addObject:question];
  }
  NSArray *final = [[NSArray alloc] initWithArray:temp];
  return final;
}

@end
