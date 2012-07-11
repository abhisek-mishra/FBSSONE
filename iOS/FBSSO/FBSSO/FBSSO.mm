//
//  FBSSO.m
//  FBSSO
//
//  Created by abhisek mishra on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBSSO.h"

@implementation FBSSO

static NSString* myAppId = @"128123393919603";
int validFlag = 0;
@synthesize facebook;

-(void) initMe
{
    
     NSLog(@"Inside init me method.....................");
    validFlag = 0;
    //facebook  = [[Facebook alloc] initWithAppId:myAppId andDelegate:[[FBSSO alloc] init]];
    facebook  = [[Facebook alloc] initWithAppId:myAppId andDelegate:self];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        NSLog(@"Fetching Value for seesion ");
        NSLog(@"facebook accessToken is %@",facebook.accessToken);
        NSLog(@"facebook expiry date  is %@",facebook.expirationDate);
    }
    
    if (![facebook isSessionValid]) {
         NSLog(@"Session is In valid *******************");
        validFlag = 0;
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_likes", 
                                @"read_stream",
                                nil];
        [facebook authorize:permissions];
        [permissions release];

        
    }
    else {
         NSLog(@"Session is **************valid");
        validFlag = 1;
        
    }

}

-(void) dummy
{
    NSLog(@"Calling dummy method");
}

         
         // Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
        NSLog(@"Inside handle open url method less than 4.2");
        return [facebook handleOpenURL:url]; 
    }
         
         // For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
        sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
        NSLog(@"Inside handle open url method more than 4.2");
        return [facebook handleOpenURL:url]; 
    }

- (void)fbDidLogin {
    NSLog(@"Inside FB Did Login");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
     NSLog(@"FBDidLogin setting acces token and all *******************");
    validFlag = 1;
    
}


FREObject initSSO(FREContext ctx, void* funcData,uint32_t argc, FREObject argv[])
{ 
     NSLog(@"Inside New SSO method");
    
    
    //addding rajorshi call
        
    
    NSLog(@"printing something ************");
	
	try {
		NSLog(@"******throwing C++ exception");
		throw 1;
	}
	catch (...) {
		NSLog(@"******************caught C++ exception: ");
	}
	
	@try
	{//
		NSLog(@"******throwing objective-c exception");
		@throw [NSException exceptionWithName:@"myexcepton" reason:@"none" userInfo:nil];
	}
	@catch (NSException* e)
	{
		NSLog(@"******************caught objective-c exception");
	}
    
    
    
    
    
    
    
    
    
    [[FBSSO alloc]dummy];
    
    
    
    
    
    /*
    
    [[FBSSO alloc]initMe];
   
   
   
    
    //writing initialization logic
            //[permissions release];
    

    if(validFlag == 1)
    {
        FREDispatchStatusEventAsync(ctx,(const uint8_t *)"validLogin",(const uint8_t *)"status");
        NSLog(@"event dispatched valid login");
                                                                    
    }
    else {
        FREDispatchStatusEventAsync(ctx,(const uint8_t *)"invalidLogin",(const uint8_t *)"status");
        NSLog(@"event dispatched invalid login");
    }
     */
    
     NSLog(@"leaving SSO method");
    
      
    return NULL;
    
}











void ContextInitializer(void * extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
	NSLog(@"In ContextInitializer Function new1");
	*numFunctionsToTest = 2;
	FRENamedFunction* func = (FRENamedFunction*)malloc(sizeof(FRENamedFunction)*(*numFunctionsToTest));
	
	func[0].name = (const uint8_t*)"initSSO";
	func[0].functionData = NULL;
	func[0].function = &initSSO;
	
	
	
	*functionsToSet = func;
}

void ContextFinalizer(FREContext ctx)
{
	return;
}

extern "C"
{
    void ExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
    {
        NSLog(@"in ExtInitializer");
        *extDataToSet = NULL;
        *ctxInitializerToSet = &ContextInitializer;
        *ctxFinalizerToSet = &ContextFinalizer;
    }
    
    void ExtFinalizer(void * extData)
    {
        return;
    }
}








@end
