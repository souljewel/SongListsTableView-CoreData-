//
//  CoreDataController.m
//  SongListsTableView
//
//  Created by Pham Thanh on 12/16/15.
//  Copyright © 2015 hdapps. All rights reserved.
//

#import "CoreDataController.h"
#import "GenreMO.h"
#import "SongMO.h"

@implementation CoreDataController

- (id)init
{
    self = [super init];
    if (!self) return nil;
    
    [self initializeCoreData];
    
    return self;
}

- (void)initializeCoreData
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MusicCoreData" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [moc setPersistentStoreCoordinator:psc];
    [self setManagedObjectContext:moc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"MusicDatabase.sqlite"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = [[self managedObjectContext] persistentStoreCoordinator];
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    });
}

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(void) deleteRow:object{
    [self.managedObjectContext deleteObject:object];
    [self saveContext];
}

- (void) moveSongByGenreTitle:(SongMO *)song toGenreTitle:(NSString *)toGenreTitle{
    GenreMO* toGenre = [self getGenreByGenreTitle:toGenreTitle];
    song.genre = toGenre;
    [self saveContext];
}

#pragma Songs
-(NSMutableArray*) getSongsByGenreId:(NSInteger)genreId{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Song"];
    
    NSSortDescriptor *lastNameSort = [NSSortDescriptor sortDescriptorWithKey:@"songTitle" ascending:YES];
    
    [request setSortDescriptors:@[lastNameSort]];
    
    //set Request
//    NSString *firstName = @"Trevor";
//    [request setPredicate:[NSPredicate predicateWithFormat:@"firstName == %@", firstName]];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Song objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    return [NSMutableArray arrayWithArray:results];
}

-(void) insertSong:(NSString *)songTitle songImageName:(NSString *)songImageName genre:(GenreMO *)genre{
    NSManagedObjectContext *context = [self managedObjectContext];
    SongMO *newSong = [NSEntityDescription
                      insertNewObjectForEntityForName:@"Song"
                      inManagedObjectContext:context];

    if(songImageName == nil){
        newSong.songImageName = @"icon_artwork_default.png";
    }else{
        newSong.songImageName = songImageName;
    }
    newSong.genre = genre;
    newSong.songTitle = songTitle;
    
    [self saveContext];
}

- (void) deleteSong:(SongMO *)song{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Song"];
//    
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"songTitle" ascending:YES];
//    [request setSortDescriptors:@[sort]];
//    
//    //set Request
//    [request setPredicate:[NSPredicate predicateWithFormat:@"songId == %d", songId]];
//    
//    NSError *error = nil;
//    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
//    if (!results) {
//        NSLog(@"Error fetching Song objects: %@\n%@", [error localizedDescription], [error userInfo]);
//        abort();
//    }
//    
//    for(int i =0;i < [results count];i++){
//        [self.managedObjectContext deleteObject:[results objectAtIndex:i]];
//    }
    [self.managedObjectContext deleteObject:song];
    [self saveContext];
}

- (void) updateSong:(SongMO *)song{
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Song"];
//    
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"songId" ascending:YES];
//    [request setSortDescriptors:@[sort]];
//    
//    //set Request
////    [request setPredicate:[NSPredicate predicateWithFormat:@"songId == %d", song.songId]];
//    
//    NSError *error = nil;
//    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
//    if (!results) {
//        NSLog(@"Error fetching Song objects: %@\n%@", [error localizedDescription], [error userInfo]);
//        abort();
//    }
//    
//    for(int i =0;i < [results count];i++){
//        ((SongMO*)[results objectAtIndex:i]).songImageName = song.songImageName;
//        ((SongMO*)[results objectAtIndex:i]).songTitle = song.songTitle;
//    }

    [self saveContext];
}

#pragma Genre

-(void) insertGenre:(NSString *)genreTitle genreImageName:(NSString *)genreImageName{
    NSManagedObjectContext *context = [self managedObjectContext];
    GenreMO *newGenre = [NSEntityDescription
                         insertNewObjectForEntityForName:@"Genre"
                         inManagedObjectContext:context];
    if(newGenre == nil){
        newGenre.genreImageName = @"icon_artwork_default.png";
    }else{
        newGenre.genreImageName = genreImageName;
    }
    newGenre.genreTitle = genreTitle;
    
    [self saveContext];
}

- (GenreMO*) getGenreByGenreTitle:(NSString *)genreTitle{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Genre"];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"genreTitle" ascending:YES];
    [request setSortDescriptors:@[sort]];
    
    //set Request
    [request setPredicate:[NSPredicate predicateWithFormat:@"genreTitle == %@", genreTitle]];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching Genre objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    if([results count] == 1){
        return [results objectAtIndex:0];
    }else{
        return nil;
    }

}
@end
