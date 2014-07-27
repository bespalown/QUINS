//
//  ViewController.h
//  Quins
//
//  Created by Viktor Bespalov on 24/07/14.
//  Copyright (c) 2014 bespalown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRSDialScrollView.h"

@interface ViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet TRSDialScrollView *dialView;
@property (weak, nonatomic) IBOutlet TRSDialScrollView *dialViewPound;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;


@end
