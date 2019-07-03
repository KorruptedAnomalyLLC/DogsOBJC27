//
//  AJDWBreed.m
//  DogsOBJC27
//
//  Created by Austin West on 7/3/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import "AJDWBreed.h"

@implementation AJDWBreed

-(instancetype)initWithName:(NSString *)name subBreeds:(NSArray *)subBreeds imageURLs:(NSArray *)imageURLs {
    
    self = [super init];
    if(self) {
        _name = name;
        _subBreeds = subBreeds;
        _imageURLs = imageURLs;
    }
    return self;
    
}

@end
