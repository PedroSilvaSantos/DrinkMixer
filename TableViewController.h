//
//  TableViewController.h
//  DrinkMixer
//
//  Created by Pedro Silva on 05/11/16.
//  Copyright © 2016 Pedro Silva. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UITableView *tableView;
    
    NSMutableArray* drinks_; //Criando o array de drink

}

@property (nonatomic, retain) NSMutableArray* drinks;
@property (nonatomic, retain) UITableView* tabelaDrinks;

@end
