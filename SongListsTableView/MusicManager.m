//
//  MusicManager.m
//  SongListsTableView
//
//  Created by Pham Thanh on 12/10/15.
//  Copyright © 2015 hdapps. All rights reserved.
//

#import "MusicManager.h"

@implementation MusicManager

// ----------------------
// init Music Manager
-(id)init{
    self = [super init];
    
    if(self){
//        self.nextIndex = 0;
        self.lstItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
