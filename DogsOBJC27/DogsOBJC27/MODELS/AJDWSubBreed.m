//
//  AJDWSubBreed.m
//  DogsOBJC27
//
//  Created by Austin West on 7/3/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import "AJDWSubBreed.h"

@implementation AJDWSubBreed

- (instancetype)initWithName:(NSString *)name imageURLs:(NSArray *)imageURLs
{
    
    self = [super init];
    if(self) {
        _name = name;
        _imageURLs = imageURLs;
    }
    
    return self;
}

@end
