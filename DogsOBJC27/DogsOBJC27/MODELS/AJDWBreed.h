//
//  AJDWBreed.h
//  DogsOBJC27
//
//  Created by Austin West on 7/3/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AJDWBreed;


@interface AJDWBreed : NSObject

@property (nonatomic, copy, readonly) NSString * name;
@property (nonatomic, copy, readonly) NSArray * subBreeds;
@property (nonatomic, copy, readonly) NSArray * imageURLs;

- (instancetype)initWithName:(NSString *)name subBreeds:(NSArray *)subBreeds imageURLs:(NSArray *)imageURLs;




@end

