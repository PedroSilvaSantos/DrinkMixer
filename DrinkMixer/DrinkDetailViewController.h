//
//  DrinkDetailViewController.h
//  DrinkMixer
//
//  Created by Pedro Silva on 05/11/16.
//  Copyright © 2016 Pedro Silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrinkDetailViewController : UIViewController{
    
    @private
    
    UITextField *nameTextField_;
    UITextView *ingredientesTextView_;
    UITextView *directionsTextView_;
    NSDictionary *drink_;
    UIScrollView *scrollView_;
    
}


@property (nonatomic,retain) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextView *ingredientesTextView;
@property (strong, nonatomic) IBOutlet UITextView *directionsTextView;
@property (strong, nonatomic) NSDictionary *drink;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;


@end
