//
//  MyTableViewCell.m
//  SongListsTableView
//
//  Created by Pham Thanh on 12/11/15.
//  Copyright © 2015 hdapps. All rights reserved.
//

#import "MyTableViewCell.h"
#import "AppDelegate.h"

@implementation MyTableViewCell

@synthesize label, image, button;

- (void)awakeFromNib {
    // Initialization code
    [self.button addTarget:self action:@selector(moveSong:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// ----------------------
// move song
-(void) moveSong:(UIButton *)sender {
    NSLog(@"move song %d", (int)sender.tag);
    //tag = songId
    
    long tag = sender.tag;
    switch (tag) {
        case 1://move song from genre to song
            [[(AppDelegate*)[[UIApplication sharedApplication] delegate] coreDataController] moveSongByGenreTitle:self.song toGenreTitle:@"Jazz"];
            break;
        case 2://move song frome song to genre
            [[(AppDelegate*)[[UIApplication sharedApplication] delegate] coreDataController] moveSongByGenreTitle:self.song toGenreTitle:@"Pop"];
            break;
        default:
            break;
    }
//    [(TabBarViewController*)self.tabBarController moveSong:(int)sender.tag fromTabItemIndex:1 toTabItemIndex:0];
//    
//    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", 1];
//    
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
//    
}

@end
