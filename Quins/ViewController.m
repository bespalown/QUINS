//
//  ViewController.m
//  Quins
//
//  Created by Viktor Bespalov on 24/07/14.
//  Copyright (c) 2014 bespalown. All rights reserved.
//

#import "ViewController.h"
#import "DMCircularScrollView.h"
#import "Weight.h"
#import "WeightData.h"

@interface ViewController ()
{
    DMCircularScrollView* threePageScrollView;
    
    NSArray* dataArray;
    NSArray* threePageScroller_Views;
    
    NSMutableArray* dataPicker;
    
    
    CGFloat selectedWeightInGr;
    typeWeight selectedWeightType;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    WeightData* weightData = [WeightData new];
    dataArray = [weightData getWeight];
    
    //base init
    dataPicker = [NSMutableArray new];
    [dataPicker addObject:@"0"];
    _pickerView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    //_pickerView.userInteractionEnabled = NO;
    
    Weight* weight = [dataArray firstObject];
    selectedWeightType = weight.type;
    
    threePageScrollView = [[DMCircularScrollView alloc] initWithFrame:CGRectMake(10,100,300,30)];
    threePageScrollView.pageWidth = 100;
    threePageScroller_Views = [self generateSampleUIViews:3 width:100];
    [threePageScrollView setPageCount:[threePageScroller_Views count]
                       withDataSource:^UIView *(NSUInteger pageIndex) {
                           return [threePageScroller_Views objectAtIndex:pageIndex];
                       }];
    
    threePageScrollView.handlePageChange =  ^(NSUInteger currentPageIndex,NSUInteger previousPageIndex) {
        Weight* currentWeight = [dataArray objectAtIndex:currentPageIndex];
        selectedWeightType = currentWeight.type;
        [self updatePickerData:[self convertWeight:selectedWeightType selectedWeightInGr:selectedWeightInGr]];
        
        [_dialView setCurrentValue:[self convertWeight:selectedWeightType selectedWeightInGr:selectedWeightInGr] animated:YES];
    };
    
    [self.view addSubview:threePageScrollView];
    
    //[[TRSDialScrollView appearance] setMinorTicksPerMajorTick:10];
    //[[TRSDialScrollView appearance] setMinorTickDistance:10];
    [[TRSDialScrollView appearance] setBackgroundColor:[UIColor blackColor]];
    //[[TRSDialScrollView appearance] setOverlayColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"DialShadding"]]];
    
    [[TRSDialScrollView appearance] setLabelStrokeColor:[UIColor whiteColor]];
    [[TRSDialScrollView appearance] setLabelStrokeWidth:0.1f];
    [[TRSDialScrollView appearance] setLabelFillColor:[UIColor whiteColor]];
    
    [[TRSDialScrollView appearance] setLabelFont:[UIFont systemFontOfSize:14]];
    
    [[TRSDialScrollView appearance] setMinorTickColor:[UIColor whiteColor]];
    [[TRSDialScrollView appearance] setMinorTickLength:5.0];
    [[TRSDialScrollView appearance] setMinorTickWidth:1.0];
    
    [[TRSDialScrollView appearance] setMajorTickColor:[UIColor whiteColor]];
    [[TRSDialScrollView appearance] setMajorTickLength:15.0];
    [[TRSDialScrollView appearance] setMajorTickWidth:1.0];
    
    [[TRSDialScrollView appearance] setShadowColor:[UIColor colorWithRed:0.593 green:0.619 blue:0.643 alpha:1.000]];
    [[TRSDialScrollView appearance] setShadowOffset:CGSizeMake(0, 1)];
    [[TRSDialScrollView appearance] setShadowBlur:0.9f];
    
    [_dialView setDialRangeFrom:0 to:450];
    _dialView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (UIColor *) randomColor
{
	CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (NSMutableArray *) generateSampleUIViews:(NSUInteger) number width:(CGFloat) wd {
    NSMutableArray *views_list = [[NSMutableArray alloc] init];
    
    for (NSUInteger k = 0; k < dataArray.count; k++) {
        Weight* weight = [dataArray objectAtIndex:k];
        
        UIView *back_view = [[UIView alloc] initWithFrame:CGRectMake(0,0, wd, 30)];
        
        UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:[NSString stringWithFormat:@"%@", weight.name] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setFrame:back_view.bounds];
        //[btn addTarget:self action:@selector(btn_tapButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn setUserInteractionEnabled:YES];
        [btn setBackgroundColor:[ViewController randomColor]];
        //back_view.backgroundColor = [DMViewController randomColor];
        
        [back_view addSubview:btn];
        [views_list addObject: back_view];
    }
    return views_list;
}

- (void) btn_tapButton:(UIButton *) btn {
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Tapped page %@!",[btn titleForState:UIControlStateNormal]]
                                                message:@"Good, I really like it! Touch me again!"
                                               delegate:nil
                                      cancelButtonTitle:@"Sure!" otherButtonTitles:nil];
    [a show];
}

#pragma mark - Picker Methods -
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return dataPicker.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 150;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        tView.text = [dataPicker objectAtIndex:row];
        tView.font = [UIFont systemFontOfSize:100];
        tView.textColor = [UIColor whiteColor];
        [tView sizeToFit];
    }
    // Fill the label text here
  
    return tView;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating: %li", (long)_dialView.currentValue);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging: %li", (long)_dialView.currentValue);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    selectedWeightInGr = [self convertInputWeight:selectedWeightType selectedWeightInGr:[textField.text floatValue]];
    [self updatePickerData:[self convertWeight:selectedWeightType selectedWeightInGr:selectedWeightInGr]];
    
    [self.view endEditing:YES];
    return YES;
}

-(void)updatePickerData:(CGFloat)theFloat
{
    NSString* object = [NSString stringWithFormat:@"%0.3f",theFloat];
    [dataPicker addObject:object];
    
    if (dataPicker.count > 2) {
        //[dataPicker removeObjectAtIndex:0];
    }
    [_pickerView reloadAllComponents];
    [_pickerView selectRow:dataPicker.count-1 inComponent:0 animated:YES];
    
    [_dialView setCurrentValue:theFloat animated:YES];
}

-(CGFloat)convertInputWeight:(typeWeight)type selectedWeightInGr:(CGFloat)theWeight
{
    CGFloat weight;
    switch (type) {
        case kg:
            weight = theWeight / 0.001;
            break;
        case gr:
            weight = theWeight / 1;
            break;
        case mgr:
            weight = theWeight / 1000;
            break;
            
        default:
            break;
    }
    
    return weight;
}

-(CGFloat)convertWeight:(typeWeight)type selectedWeightInGr:(CGFloat)theWeight
{
    CGFloat weight;
    switch (type) {
        case kg:
            weight = theWeight * 0.001;
            break;
        case gr:
            weight = theWeight * 1;
            break;
        case mgr:
            weight = theWeight * 1000;
            break;
            
        default:
            break;
    }
    
    return weight;
}

@end
