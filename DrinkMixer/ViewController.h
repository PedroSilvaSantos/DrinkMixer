//
//  ViewController.h
//  DrinkMixer
//
//  Created by Pedro Silva on 05/11/16.
//  Copyright © 2016 Pedro Silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    
    NSMutableArray *drinks_;
    UIBarButtonItem *addButton_;
    
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *drinks;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;

-(IBAction)addButtonPressed:(id)sender;

@end

