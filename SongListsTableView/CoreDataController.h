//
//  CoreDataController.h
//  SongListsTableView
//
//  Created by Pham Thanh on 12/16/15.
//  Copyright © 2015 hdapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongMO.h"
#import "GenreMO.h"

@import CoreData;

@interface CoreDataController : NSObject

@property (strong) NSManagedObjectContext *managedObjectContext;

- (void)initializeCoreData;
- (void) saveContext;
- (void) deleteRow:(id)object;

-(void) moveSongByGenreTitle:(SongMO*)song toGenreTitle:(NSString*)toGenreTitle ;
#pragma Song
-(void) insertSong:(NSString*)songTitle songImageName:(NSString*)songImageName genre:(GenreMO*)genre;
- (void) deleteSong:(SongMO*) song;
- (void) updateSong:(SongMO*) song;
- (NSMutableArray*) getSongsByGenreId:(NSInteger)genreId;

#pragma Genre
- (void) insertGenre:(NSString*)genreTitle genreImageName:(NSString*)genreImageName;
- (GenreMO*) getGenreByGenreTitle:(NSString*)genreTitle;


@end
