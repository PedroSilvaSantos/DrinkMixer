//
//  DrinkDetailViewController.m
//  DrinkMixer
//
//  Created by Pedro Silva on 05/11/16.
//  Copyright © 2016 Pedro Silva. All rights reserved.
//

#import "DrinkDetailViewController.h"
#import "DrinkConstants.h"

@interface DrinkDetailViewController ()

@end

@implementation DrinkDetailViewController

@synthesize nameTextField=nameTextField_ , ingredientesTextView=ingredientesTextView_ , directionsTextView=directionsTextView_,drink=drink_, scrollView=scrollView_;

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void) viewWillAppear:(BOOL)animated{
    //Precisamos ter certeze que delegamos isso ao superclasse do UIViewController antes de prosseguir
    [super viewWillAppear:animated];
    
    //Set up our with the provided drink
    self.nameTextField.text = [self.drink objectForKey:NAME_KEY];
    self.ingredientesTextView.text = [self.drink objectForKey:INGREDIENTS_KEY];
    self.directionsTextView.text = [self.drink objectForKey:DIRECTIONS_KEY];
    
    //dizendo a scrollView que o conteudo tem o mesmo tamanho da nossa view
    self.scrollView.contentSize = self.view.frame.size;
    //[self.tableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
