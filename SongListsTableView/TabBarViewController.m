//
//  TabBarViewController.m
//  SongListsTableView
//
//  Created by Pham Thanh on 12/10/15.
//  Copyright © 2015 hdapps. All rights reserved.
//

#import "TabBarViewController.h"


@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
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

// ----------------------
// init data
- (void) initData{

}

// ----------------------
// get Genre items Manager
- (MusicManager*) getGenresManager{
    return [self.musicManagers objectAtIndex:0];
}

// ----------------------
// get Song Items Manager
- (MusicManager*) getSongManager {
    return [self.musicManagers objectAtIndex:1];
}

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    item.badgeValue = nil;
    NSLog(@"tab item");
}

@end
