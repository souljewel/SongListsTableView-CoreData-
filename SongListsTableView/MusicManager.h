//
//  MusicManager.h
//  SongListsTableView
//
//  Created by Pham Thanh on 12/10/15.
//  Copyright © 2015 hdapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicManager : NSObject
@property NSMutableArray *lstItems;



-(void) deleteSongBySongId:(NSInteger) songId;


-(NSInteger) getCountItem;

-(void) loadSongFromDatabase:(NSInteger)genreId;
@end
