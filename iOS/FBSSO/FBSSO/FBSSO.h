//
//  FBSSO.h
//  FBSSO
//
//  Created by abhisek mishra on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "FBConnect.h"
@interface FBSSO : NSObject
<FBSessionDelegate>
{
    Facebook *facebook;
}

extern "C"
{
void ExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
void ExtFinalizer(void * extData);
}

@property (nonatomic, retain) Facebook *facebook;

@end
