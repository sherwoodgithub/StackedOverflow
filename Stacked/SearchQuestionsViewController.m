//
//  SearchQuestionsViewController.m
//  Stacked
//
//  Created by Stephen Sherwood on 2/18/15.
//  Copyright (c) 2015 Sherwood. All rights reserved.
//

#import "SearchQuestionsViewController.h"
#import "Questions.h"
#import "QuestionTableViewCell.h"
#import "StackOverflowService.h"

@interface SearchQuestionsViewController () <UISearchBarDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *questions;

@end

@implementation SearchQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.dataSource = self;

  self.searchBar.delegate = self;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  [[StackOverflowService sharedService] fetchQuestionsWithSearchTerm:searchBar.text completionHandler:^(NSArray *results, NSString *error) {
    self.questions = results;
    if (error) {
    }
    [self.tableView reloadData];
  }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QUESTION_CELL"
                                                       forIndexPath:indexPath];
  cell.avatarImageView.image = nil;
  Questions *question = self.questions[indexPath.row];
  cell.titleTextView.text = question.title;
  if (!question.image) {
    [[StackOverflowService sharedService] fetchUserImage:question.avatarURL completionHandler:^(UIImage *image) {
      question.image = image;
      cell.avatarImageView.image = image;
    }];
  } else {
    cell.avatarImageView.image = question.image;
  }
  return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.questions.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
