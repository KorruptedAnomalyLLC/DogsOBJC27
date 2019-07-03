//
//  AJDWBreedNetworkClient.h
//  DogsOBJC27
//
//  Created by Austin West on 7/3/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AJDWBreed;
@class AJDWSubBreed;
@class AJDWImage;

@interface AJDWBreedNetworkClient : NSObject

- (void)fetchAllBreeds: (void (^) (NSArray *))completion;

// https://dog.ceo/api/breed/hound/images
- (void)fetchBreedImageURLs:(AJDWBreed *)breed completion:(void (^) (NSArray *))completion;

- (void)fetchSubBreedImageURLs:(AJDWSubBreed *)subBreed breed:(AJDWBreed *)breed completion:(void (^) (NSArray *))completion;

- (void)fetchImageData:(NSURL *)url completion:(void (^)(NSData *imageData, NSError *error))completion;

+ (AJDWBreedNetworkClient *)sharedController;

@end

