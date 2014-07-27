//
//  WeightData.m
//  Quins
//
//  Created by Viktor Bespalov on 24/07/14.
//  Copyright (c) 2014 bespalown. All rights reserved.
//

#import "WeightData.h"
#import "Weight.h"

@implementation WeightData

-(NSArray *)getWeight
{
    Weight* weightGr = [Weight new];
    weightGr.name = @"грамм";
    weightGr.type = gr;
    
    Weight* weightML = [Weight new];
    weightML.name = @"миллилитров";
    weightML.type = milliliter;
    
    Weight* weightmP = [Weight new];
    weightmP.name = @"фунтов";
    weightmP.type = pound;
    
    Weight* weightmO = [Weight new];
    weightmO.name = @"унций";
    weightmO.type = ounce;
    
    NSMutableArray* arr = [NSMutableArray new];
    [arr addObject:weightGr];
    [arr addObject:weightML];
    [arr addObject:weightmP];
    [arr addObject:weightmO];
    
    return arr;
}

@end
