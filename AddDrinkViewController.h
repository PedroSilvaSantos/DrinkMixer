//
//  AddDrinkViewController.h
//  DrinkMixer
//
//  Created by Pedro Silva on 17/11/16.
//  Copyright © 2016 Pedro Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrinkDetailViewController.h"

@interface AddDrinkViewController : DrinkDetailViewController{
    BOOL keyboardVisible_;
    NSMutableArray *drinkArray_;//referencia para incluir os drinks
    
}
//iremos adicionar todos os comportamentos que precisamos
//por padrao nosso ViewController herdou do UIViewController.

//Altere isso aqui para DrinkDetailViewController
//O arquivo .m podera ficar identico  como foi criado.

-(IBAction)save:(id)sender;

-(IBAction)cancel:(id)sender;

-(void) keyboardDidShow: (NSNotification *) notif;
-(void) keyboardDidHide: (NSNotification *) notif;

@property (nonatomic,retain) NSMutableArray *drinkArray;

@end