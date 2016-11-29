//
//  ViewController.m
//  DrinkMixer
//
//  Created by Pedro Silva on 05/11/16.
//  Copyright © 2016 Pedro Silva. All rights reserved.
//

#import "ViewController.h"
#import "DrinkDetailViewController.h"
#import "DrinkConstants.h"
#import "AddDrinkViewController.h"

@interface ViewController ()


@end

@implementation ViewController

@synthesize drinks=drinks_, addButton=addButton_;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //drinks_ = [[NSMutableArray alloc] initWithObjects:@"Firecracker",@"Lemon Drop",@"Mojito", nil];
    
    //Pegando o caminho do plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"DrinkDirections" ofType:@"plist"];
    
    //Register for application background so we can save data
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    drinks_ = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    self.navigationItem.rightBarButtonItem = self.addButton;
    
    //O UITableViewController vem com suporte incorporado para um botao Edit, so precisamos adiciona-lo a barra de navegacao
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    
}


//Remove a notificacao
-(void) viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //informando a quantidade de elementos para tabela
    return [self.drinks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Configurando as celulas
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    //Personalindo o texto que sera mostrado na celula de cada drink
    //cell.textLabel.text = [self.drinks objectAtIndex:indexPath.row];
    
    //pegenado os dados de um array de dictionary
    cell.textLabel.text = [[self.drinks objectAtIndex:indexPath.row] objectForKey:NAME_KEY];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


#pragma didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{
    
    //Verificando se estamos no modo de edicao dos produtos
    if (!self.editing) {
    
    //Instaciando o controlador de acordo com a celula selecionadam 
    DrinkDetailViewController *detailViewControle = [[DrinkDetailViewController alloc] initWithNibName:@"DrinkDetailViewController" bundle:nil];
    
    //Pegando um dicionario do array
    detailViewControle.drink = [self.drinks objectAtIndex:indexPath.row];
    
    
    //Pass the selected object to the new view controller
    [self.navigationController pushViewController:detailViewControle animated:YES];
        
    }else {
        AddDrinkViewController *editingDrinkVC = [[AddDrinkViewController alloc] initWithNibName:@"DrinkDetailViewController" bundle:nil];
        
        editingDrinkVC.drink = [self.drinks objectAtIndex:indexPath.row];
        editingDrinkVC.drinkArray = self.drinks;
        
        UINavigationController *editingNavCon = [[UINavigationController alloc] initWithRootViewController:editingDrinkVC];
        [self.navigationController presentModalViewController:editingNavCon animated:YES];
        
    }
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Delete the row from the data source.
        [self.drinks removeObjectAtIndex:indexPath.row];//limpando nossa data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleDelete){
        
    }
}

#pragma mark Actions
-(IBAction)addButtonPressed:(id)sender{
    //NSLog(@"Add button pressed!");
    AddDrinkViewController *addViewController = [[AddDrinkViewController alloc] initWithNibName:@"DrinkDetailViewController" bundle:nil];
    
    addViewController.drinkArray = self.drinks;
    
    //Criando um navgation para mostrar em cima da modal
    UINavigationController *addNavController = [[UINavigationController alloc] initWithRootViewController:addViewController];
    [self presentModalViewController:addNavController animated:YES];
}

//- (IBAction)msg:(id)sender {
//    UITableViewController *controlador = [[UITableViewController alloc] init];
//    controlador.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:controlador animated:YES completion:nil];
//    
//
//}

@end
