//
//  GenreMO+CoreDataProperties.h
//  SongListsTableView
//
//  Created by thanh on 12/17/15.
//  Copyright © 2015 hdapps. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "GenreMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface GenreMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *genreImageName;
@property (nullable, nonatomic, retain) NSString *genreTitle;
@property (nullable, nonatomic, retain) NSSet<SongMO *> *song;

@end

@interface GenreMO (CoreDataGeneratedAccessors)

- (void)addSongObject:(SongMO *)value;
- (void)removeSongObject:(SongMO *)value;
- (void)addSong:(NSSet<SongMO *> *)values;
- (void)removeSong:(NSSet<SongMO *> *)values;

@end

NS_ASSUME_NONNULL_END
