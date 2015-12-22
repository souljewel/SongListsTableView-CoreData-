//
//  AppDelegate.h
//  SongListsTableView
//
//  Created by Pham Thanh on 12/9/15.
//  Copyright © 2015 hdapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CoreDataController *coreDataController;

@end

