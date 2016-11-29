//
//  AddDrinkViewController.m
//  DrinkMixer
//
//  Created by Pedro Silva on 17/11/16.
//  Copyright © 2016 Pedro Silva. All rights reserved.
//

#import "AddDrinkViewController.h"
#import "DrinkConstants.h"
#import "ViewController.h"

@interface AddDrinkViewController ()

@end

@implementation AddDrinkViewController

@synthesize drinkArray=drinkArray_;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
}


#pragma viewWillAppear
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"Registering for keyboard events");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    //Initially the keyboard is hidden, so reset our variable
    keyboardVisible_= NO;
    //precisamos manter o registro sobre a visibilidade ou nao.
    
    //atualizando a table view, para apresentar os produtos que foram inseridos
    //peca a tableView para carregar seus dados
    //[self.tableView reloadData];
}


#pragma viewWillDisappear
-(void) viewDidAppear:(BOOL)animated{
    NSLog(@"UNregistering for keyboard events");
    
    //se nao especificar a notificao que deseja excluir, ira remover todas as notificacao
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Save and Cancel
-(IBAction)save:(id)sender{
    NSLog(@"Save pressed!");
    
    if (self.drink != nil) {
        //We're working with an existing drink, so let's remove
        //it from the array to get ready for a new one
        [drinkArray_ removeObject:self.drink];
        
        //this will release our reference too
        self.drink = nil;
    }
    
    //Create a new drink dictionary for the new value
    NSMutableDictionary *newDrink = [[NSMutableDictionary alloc] init];
    [newDrink setValue:self.nameTextField.text forKey:NAME_KEY];
    [newDrink setValue:self.ingredientesTextView.text forKey:INGREDIENTS_KEY];
    [newDrink setValue:self.directionsTextView.text forKey:DIRECTIONS_KEY];
    
    //Add it to the master drink array and release our reference
    [drinkArray_ addObject:newDrink];
    
    //Sort the array since we just added a new drink
    NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:NAME_KEY ascending:YES selector:@selector(caseInsensitiveCompare:)];
    
    //fazer ordenacao, simplesmente peca ao array para se ordenar como nosso seletor
    [drinkArray_ sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]];

    [self dismissModalViewControllerAnimated:YES];
    
}


-(IBAction)cancel:(id)sender{
    NSLog(@"Cancel pressed!");
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark Keyboard handlers
-(void) keyboardDidShow:(NSNotification *)notif{
    if (keyboardVisible_) {
        NSLog(@"%@",@"Keyboard is already visible. Ignoring notification.");
        return;
        //receberemos essa notificacao sempre que o usuario trocar os campos de texto, mesmmo que o teclado ja esteja aparecendo.
        //entao mantenha registro disso e ignore se for repetido
    }
    
    //o teclado nao estava visivel antes
    NSLog(@"Resizing smaller for keyboard");
    
    //obtenha a origem do teclado quando ele acabar de animar
    //o NSNotification contem um dicionario com os detalhes do evento, vamos pegar aqui
    NSDictionary *info = [notif userInfo];
    
    //obter o tamanho do teclado do dicionario
    NSValue *aValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //obtenha a parte superior do teclado no sistema de coordenada da view
    //precisamos configurar a parte inferior da scroll view para que alinhe a ele
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect toView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;
    
    //redimencione a scroll view para abrir espaco para o teclado
    CGRect viewFrame = self.view.bounds;
    
    //descobrimos agora qual sera o tamanho da scroll view, tamanho dela menos o tamanho do teclado
    viewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    //atualizando a scroll view com o novo tamanho e deixando o teclado visivel
    self.scrollView.frame = viewFrame;
    keyboardVisible_ = YES;
    
}




-(void) keyboardDidHide:(NSNotification *)notif{
    if (!keyboardVisible_) {
        //ignore essa notificacao se souber que o teclado nao esta mais visivel
        NSLog(@"%@",@"Keyboard already hidden. Ignoring notification");
        return;
    }
    
    //o teclado esta visivel
    NSLog(@"%@",@"Resizing bigger with no keyboard");
    
    //Redimensione a scroll view para o tamanho total da nossa view
    //entao redimensione a scroll view para nova area visivel
    self.scrollView.frame = self.view.bounds;
    keyboardVisible_ = NO;
    
}

@end



