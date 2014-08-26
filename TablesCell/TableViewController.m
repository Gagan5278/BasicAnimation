//
//  TableViewController.m
//  BasicAnimation
//
//  Created by Gagan Mishra on 8/26/14.
//  Copyright (c) 2014 Gagan_Work. All rights reserved.
//

#import "TableViewController.h"
#import "AnimationViewController.h"
#import "SuffleViewController.h"
@interface TableViewController ()
{
    NSArray *arrayOfData;
}
@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    arrayOfData=[[NSArray alloc]initWithObjects:@"SpinAnimation",@"SpinWithAddedLayer",@"PathAnimation",@"ShakeAnimation",@"AnimationOnPath",@"AnimateWithSpeedControl",@"RepeatFallAnimation",@"Label fade",@"Suffle", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayOfData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.text=[arrayOfData objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==arrayOfData.count-1)
    {
        SuffleViewController *object=[[SuffleViewController alloc]init];
        [self.navigationController pushViewController:object animated:YES];
    }
    else{
      AnimationViewController *detailViewController = [[AnimationViewController alloc] initWithNibName:@"AnimationViewController" bundle:nil];
     detailViewController.animationSelected=indexPath.row;
     [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

@end
