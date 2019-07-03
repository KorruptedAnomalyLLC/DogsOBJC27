//
//  AJDWBreedNetworkClient.m
//  DogsOBJC27
//
//  Created by Austin West on 7/3/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import "AJDWBreedNetworkClient.h"
#import "AJDWBreed.h"
#import "AJDWSubBreed.h"

static NSString * const baseURLString = @"//https://dog.ceo/api";

@implementation AJDWBreedNetworkClient

+ (AJDWBreedNetworkClient *)sharedController
{
    static AJDWBreedNetworkClient *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        sharedController = [AJDWBreedNetworkClient new];
    });
    return sharedController;
}

- (void)fetchAllBreeds:(void (^)(NSArray *))completion
{
    //https://dog.ceo
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURL *breedURL = [[[baseURL URLByAppendingPathComponent: @"breeds"]
                        URLByAppendingPathComponent:@"list"] URLByAppendingPathComponent:@"all"];
    
    [[[NSURLSession sharedSession]dataTaskWithURL:breedURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching breeds from the provided search term: %@", error);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"Error with fetching breeds data from search term: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        
        NSDictionary *messageDictionary = jsonDictionary[@"message"];
        
        NSMutableArray *breeds = [[NSMutableArray alloc] init];
        
        for (id key in messageDictionary)
        {
            NSMutableArray *subBreeds = [[NSMutableArray alloc] init];
            
            for (NSString *name in messageDictionary[key] )
            {
                
                AJDWSubBreed *subBreed = [[AJDWSubBreed alloc] initWithName:name imageURLs:[[NSMutableArray alloc] init] ];
                [subBreeds addObject:subBreed];
            }
            
            AJDWBreed * breed = [[AJDWBreed alloc] initWithName: key subBreeds: subBreeds imageURLs:[[NSMutableArray alloc] init] ];
            [breeds addObject:breed];
        }
        completion(breeds);
    }]resume];
}

- (void)fetchBreedImageURLs:(AJDWBreed *)breed completion:(void (^) (NSArray *))completion;
{
    //https://dog.ceo/api
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURL *breedURL = [[[baseURL URLByAppendingPathComponent:@"breed"]
                        URLByAppendingPathComponent:breed.name] URLByAppendingPathComponent:@"images"];
    NSLog(@"%@", breedURL);
    [[[NSURLSession sharedSession]dataTaskWithURL:breedURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching breeds from the search term: %@", error);
            completion(nil);
            return;
        }
        
        if (!data) {
            NSLog(@"Error fetch breeds Data from search term: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error fetching json dictionary %@", error);
            completion(nil);
            return;
        }
        NSMutableArray *images = jsonDictionary[@"message"];
        completion(images);
        
    }]resume];
}

- (void)fetchSubBreedImageURLs:(AJDWBreed *)subBreed breed:(AJDWBreed *)breed completion:(void (^) (NSArray * _Nullable))completion
{
     //https://dog.ceo/api
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURL *breedURL = [[[[baseURL URLByAppendingPathComponent:@"breed"]
                         URLByAppendingPathComponent:breed.name] URLByAppendingPathComponent:subBreed.name]
                       URLByAppendingPathComponent:@"images"];
    NSLog(@"%@", breedURL);
    [[[NSURLSession sharedSession]dataTaskWithURL:breedURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error){
            NSLog(@"Error fetching breeds from search term: %@", error);
            completion(nil);
            return;
        }
        //handle missing data
        if(!data){
            NSLog(@"Error fetching breeds DATA from search term: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Error fetching json dictionary %@", error);
            completion(nil);
            return;
        }
        NSMutableArray *images = jsonDictionary[@"message"];
        completion(images);
        
    }]resume];
    
    
}

- (void)fetchImageData:(NSURL *)url completion:(void (^)(NSData *imageData, NSError *error))completion
{
    [[[NSURLSession sharedSession]dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching breeds from search term: %@", error);
            return completion(nil, error);
        }
        
        if (!data) {
            NSLog(@"Error fetching breeds DATA from search term: %@", error);
            return completion(nil, error);
        }
        completion(data, nil);
    }]resume];
}

@end
