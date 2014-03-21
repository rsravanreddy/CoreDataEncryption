//
//  ViewController.m
//  CoreDataEncryption
//
//  Created by SRAVAN on 3/19/14.
//  Copyright (c) 2014 SRAVAN. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Entity1.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AppDelegate *mydel=(AppDelegate*)[[UIApplication sharedApplication] delegate];
   
    NSManagedObjectContext *context=mydel.managedObjectContext;
    
    Entity1 * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Entity1"
                                                      inManagedObjectContext:context];
    newEntry.attribute1=@"nsert";
    
    NSError *insErr=nil;
    
    [context save:&insErr];
    
    if (!insErr) {
        NSLog(@"saved");
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Entity1" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error=nil;
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"Name: %@", [info valueForKey:@"attribute1"]);
    }}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
