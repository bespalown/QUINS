//
//  Weight.h
//  Quins
//
//  Created by Viktor Bespalov on 24/07/14.
//  Copyright (c) 2014 bespalown. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Weight : NSObject

typedef enum
{
    gr,
    milliliter,
    ounce,
    pound
} typeWeight;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, assign) typeWeight type;

@end
