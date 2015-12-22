//
//  GenresTableViewController.m
//  SongListsTableView
//
//  Created by Pham Thanh on 12/10/15.
//  Copyright © 2015 hdapps. All rights reserved.
//

#import "GenresTableViewController.h"
#import "MusicManager.h"
#import "MyTableViewCell.h"
#import "TabBarViewController.h"
#import "SongTableViewController.h"
#import "AppDelegate.h"
#import "GenreMO.h"
@import CoreData;

@interface GenresTableViewController ()<UIAlertViewDelegate,UITabBarControllerDelegate,NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) CoreDataController *coreDataController;

@end

@implementation GenresTableViewController

static NSString *MyIdentifier = @"MyTableView";


// ----------------------
// init TableView
- (void) initData{
    
    TabBarViewController*  tabBarController= (TabBarViewController*)self.tabBarController;
    tabBarController.delegate = self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self initData];
    [self initializeFetchedResultsController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id< NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultsController] sections][section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(id)cell atIndexPath:(NSIndexPath*)indexPath
{
    SongMO* songItem = (SongMO*)[[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    // Populate cell from the NSManagedObject instance
    ((MyTableViewCell*)cell).song = songItem;
    ((MyTableViewCell*)cell).image.image = [UIImage imageNamed: songItem.songImageName];
    ((MyTableViewCell*)cell).label.text = songItem.songTitle;
    ((MyTableViewCell*)cell).button.tag = 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.coreDataController deleteRow:[[self fetchedResultsController] objectAtIndexPath:indexPath]];
    }
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Alert View Delegate

// ----------------------
// alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){ //Touch OK
        NSString *songName = [alertView textFieldAtIndex:0].text;
        GenreMO* genre = [self.coreDataController getGenreByGenreTitle:@"Pop"];
        [self.coreDataController insertSong:songName songImageName:nil genre:genre];
    }
}

#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// ----------------------
// touch Add Track button
- (IBAction)touchAddTrack:(UIBarButtonItem *)sender {
    
    //show alert input add track
    UIAlertView *inputTrackAlertView = [[UIAlertView alloc] initWithTitle:@"Add Track"
                                                                  message:@"Enter Track Name"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                        otherButtonTitles:@"OK",nil];
    [inputTrackAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [inputTrackAlertView show];
    
}

#pragma mark - tab bar item click

// ----------------------
// update table view when change tab
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if(tabBarController.selectedIndex == 0){//genres tab
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        if(tabBarController.selectedIndex == 1){//song tab
            UINavigationController *naviController = tabBarController.selectedViewController;
            SongTableViewController *songController = [naviController.viewControllers objectAtIndex:0];
            [songController.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
    }

}

#pragma NSFetchedResultsController

// ----------------------
// init FetchedResultsController
- (void)initializeFetchedResultsController
{
    self.coreDataController = [(AppDelegate*)[[UIApplication sharedApplication] delegate] coreDataController];
    //==========
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Song"];
    
    NSSortDescriptor *lastNameSort = [NSSortDescriptor sortDescriptorWithKey:@"songTitle" ascending:YES];
    
    [request setSortDescriptors:@[lastNameSort]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"genre.genreTitle == %@", @"Pop"]];
    
    NSManagedObjectContext *moc = self.coreDataController.managedObjectContext; //Retrieve the main queue NSManagedObjectContext
    
    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil]];
    [[self fetchedResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
#warning create inital data genre
//    [self.coreDataController insertGenre:@"Pop" genreImageName:nil];
//
//    [self.coreDataController insertGenre:@"Jazz" genreImageName:nil];
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] beginUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
            break;
    }
}
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[[self tableView] cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] endUpdates];
}
@end
