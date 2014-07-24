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
    weightGr.name = @"килограммов";
    weightGr.ratio = 1;
    weightGr.type = kg;
    
    Weight* weightKG = [Weight new];
    weightKG.name = @"граммов";
    weightKG.ratio = 1000;
    weightKG.type = gr;
    
    Weight* weightmGr = [Weight new];
    weightmGr.name = @"миллиграммов";
    weightmGr.ratio = 0.001;
    weightmGr.type = mgr;
    
    NSMutableArray* arr = [NSMutableArray new];
    [arr addObject:weightGr];
    [arr addObject:weightKG];
    [arr addObject:weightmGr];
    
    return arr;
}

@end
