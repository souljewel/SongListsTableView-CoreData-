//
//  SongMO+CoreDataProperties.h
//  SongListsTableView
//
//  Created by thanh on 12/17/15.
//  Copyright © 2015 hdapps. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SongMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface SongMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *songImageName;
@property (nullable, nonatomic, retain) NSString *songTitle;
@property (nullable, nonatomic, retain) GenreMO *genre;

@end

NS_ASSUME_NONNULL_END
