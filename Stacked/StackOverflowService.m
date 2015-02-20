//
//  StackOverflowService.m
//  Stacked
//
//  Created by Stephen Sherwood on 2/18/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import "StackOverflowService.h"
#import "Questions.h"

@implementation StackOverflowService

+(id)sharedService {
  
  static StackOverflowService *mySharedService;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    mySharedService = [[StackOverflowService alloc] init];
  });
  return mySharedService;
}

-(void)fetchQuestionsWithSearchTerm:(NSString *)searchTerm completionHandler:(void (^)(NSArray *, NSString *))completionHandler {
  
  NSString *urlString = @"https://api.stackexchange.com/2.2/";
  urlString = [urlString stringByAppendingString:@"search?order=desc&sort=activity&site=stackoverflow&intitle="];
  urlString = [urlString stringByAppendingString:searchTerm];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [defaults objectForKey:@"token"];
  if (token) {
    urlString = [urlString stringByAppendingString:@"&access_token="];
    urlString = [urlString stringByAppendingString:token];
    urlString = [urlString stringByAppendingString:@"&key=5vpg3uTqCwAssGUjZ3wg(("];
  }
  
  NSURL *url = [NSURL URLWithString:urlString];
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
  request.HTTPMethod = @"GET";
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
      completionHandler(nil,@"Can't connect");
    } else {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      NSInteger statusCode = httpResponse.statusCode;
      
      switch (statusCode) {
        case 200 ... 299: {
          NSArray *results = [Questions questionsFromJSON:data];
          dispatch_async(dispatch_get_main_queue(), ^{
            if (results) {
              completionHandler(results,nil);
            } else {
              completionHandler(nil, @"Search incomplete");
            }
          });
          break;
        }
        default:
          NSLog(@"%ld",(long)statusCode);
          break;
      }
    }
  }];
  [dataTask resume];
}

-(void)fetchUserImage:(NSString *)avatarURL completionHandler:(void (^) (UIImage *image))completionHandler {
  
  dispatch_queue_t imageQueue = dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0);
  dispatch_async(imageQueue, ^{
    NSURL *url = [NSURL URLWithString:avatarURL];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
      completionHandler(image);
    });
  });
}

@end
