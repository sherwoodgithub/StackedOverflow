//
//  QuestionTableViewCell.h
//  Stacked
//
//  Created by Stephen Sherwood on 2/18/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;

@end
