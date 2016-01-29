//
//  AppDelegate.m
//  TOIAPP
//  Created by CYNOTECK on 7/25/14.
//  Copyright (c) 2014 CYNOTECK. All rights reserved.

#import "AppDelegate.h"
#import "Reachability.h"
#import "KeyChainValteck.h"

#import <WindowsAzureMessaging/WindowsAzureMessaging.h>

@implementation AppDelegate
@synthesize id_CategoryArray,categoryNameArray;
@synthesize recordedData,uniqueNameForLableAudio;
@synthesize responseData;
@synthesize window;
@synthesize putValueToKeyChain;
@synthesize device_Token,randomNumber;
@synthesize genderArr ;
@synthesize myFinalArray;
@synthesize soundFilePathData,Title,Description,indexpath;


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)


//
//-(NSString *) randomStringWithLength: (int) len {
//    
//    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
//    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
//    
//    for (int i=0; i<len; i++) {
//        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
//    }
//    
//    return randomString;
//}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions

{
    
   
  //  randomNumber =(arc4random() % 30000) + 10000;
  //  NSLog(@"RANDOM NO IS ====%i",randomNumber);
    
    NSLog(@"This is myfinal array in app delegate---%@",myFinalArray);
    
    
        
   
    
    
    
   // randomNumber = [self randomStringWithLength:5];
    myFinalArray = [[NSMutableArray alloc] init];
    
     myFinalArray=[[[NSUserDefaults standardUserDefaults]objectForKey:@"MyArray"]mutableCopy];
    

       
    //[myFinalArray addObject:@"{}"];

    // logic to set random value only once for push notificiton hub and service !!!! start.
    
    // one time condition !!!! start !
    
  NSString *  setLocal = @"rohit.123";
    
    // for getting ....
    
    NSString *  KEY_PASSWORD = @"appleDevelopment";
    NSString *  idfv_Local = [[KeyChainValteck keyChainLoadKey:setLocal] valueForKey:KEY_PASSWORD];
    NSLog(@"saved key  is =====%@",idfv_Local);
    
    // end
    
    
    
    
    
    
    
    if (idfv_Local ==nil) {
        
        NSLog(@"it is empty !");
        
        // save here alphanumeric , & it will be executed only once !
        
        
      
        
        
        
        ///// for settting ....
        
        if(randomNumber.length == 0){
            
            randomNumber = @"";
        }
        
        NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        [usernamepasswordKVPairs setObject:randomNumber forKey:@"appleDevelopment"];
        [KeyChainValteck keyChainSaveKey:setLocal data:usernamepasswordKVPairs];
        
        ///// end
        
    }else {
        
        // for getting ....
        
        NSString *  KEY_PASSWORD = @"appleDevelopment";
        NSString *  idfv_Local = [[KeyChainValteck keyChainLoadKey:setLocal] valueForKey:KEY_PASSWORD];
        
        randomNumber = idfv_Local ;
        
        // end
        
    }
    
    ///////////////////////////// one time condition !!!!  end !

      NSLog(@"random no is === %@",randomNumber);
    
    
    // logic to set random value only once for push notificiton hub and service !!!! end.

    
    //////// setting values to keychain........extra "quhqtyq" --hji Remove the extra.
       putValueToKeyChain=@"Times_Of_India_Newspaper12346789Maharashtra619ss1apkhji";
    //////// setting values to keychain........

    // Override point for customization after application launch.
  // [self checkUserAlreadyAvailableService];
    
   // [UIApplication sharedApplication].statusBarHidden=YES;
  
    // Let the device know we want to receive push notifications
    

//	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    

    //[UIApplication sharedApplication].applicationIconBadgeNumber = 0;
  
    
    
#pragma mark ####################################################################
#pragma mark ##   Remote notification for both ios 7 & lower and ios 8!!!!!!!!!!!
#pragma mark ####################################################################
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        
        // use registerUserNotificationSettings
        
        NSLog(@"for ios 8");
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
        
    } else {
        // use registerForRemoteNotifications
        
        NSLog(@"for ios 7");
        
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        
    }
#else
    // use registerForRemoteNotifications
    
    NSLog(@"for ios 7");
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    
#endif

    
#pragma mark ####################################################################
#pragma mark ######## internet connectivity delegates ###########################
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSUserDefaults standardUserDefaults]setValue:@"reachable" forKeyPath:@"connection_Internet"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            // internet is available!!!!
        });
    };

    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //   NSLog(@"inside not reachable!");
            [[NSUserDefaults standardUserDefaults]setValue:@"not_reachable" forKeyPath:@"connection_Internet"];
            [[NSUserDefaults standardUserDefaults]synchronize];

            
            
        });
    };
    
    [reach startNotifier];

#pragma mark ####################################################################
#pragma mark ######## internet connectivity delegates ###########################
    
   
#pragma mark ####################################################################
#pragma mark ######## internet connectivity notifier ###########################
   
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];

#pragma mark ####################################################################
#pragma mark ######## internet connectivity notifier ###########################

    
 
#pragma mark ####################################################################
#pragma mark ##     Start     StoryBoard of iPhone 4S , iPad , iPhone 5        ##
#pragma mark ####################################################################
    
    CGSize size = [[UIScreen mainScreen]bounds].size;
    
    UIStoryboard *mainStoryboard = nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {  // for iphone ....
        
        if (size.height==568)
        {
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        }
        else
        {
            mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone3.5" bundle:nil];
        }
        
        
    } // end for iphone .....
    
    
    else{   // for ipad .....
        
      //  mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
        
    }// end for ipad ......
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [mainStoryboard instantiateInitialViewController];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0,320, 20)];
        view.backgroundColor=[UIColor whiteColor];
        view.tag = 109 ;
        [self.window.rootViewController.view addSubview:view];
    }
    
    [self.window makeKeyAndVisible];
  
    // return YES;

#pragma mark ####################################################################
#pragma mark ##   End            StoryBoard of iPhone 4S , iPad , iPhone 5     ##
#pragma mark ####################################################################

    return YES;
    
}


-(void)hideIt{

    [[self.window.rootViewController.view viewWithTag:109] setHidden:YES];
 
}


-(void)showIt {
    

    [[self.window.rootViewController.view viewWithTag:109] setHidden:NO];

}


-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        //  NSLog(@"reachable!");
        [[NSUserDefaults standardUserDefaults]setValue:@"reachable" forKeyPath:@"connection_Internet"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    else
    {
        //  NSLog(@"not reachable!");
        [[NSUserDefaults standardUserDefaults]setValue:@"not_reachable" forKeyPath:@"connection_Internet"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}


#pragma mark ####################################################################
#pragma mark ##     PUSH NOTIFICATION HANDLING      ## START
#pragma mark ####################################################################

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken{
   
    NSLog(@"======%@",deviceToken);

    NSString *strWithoutSpaces  = [NSString stringWithFormat:@"%@",deviceToken];
    strWithoutSpaces = [strWithoutSpaces stringByReplacingOccurrencesOfString:@" " withString:@""];
    strWithoutSpaces = [strWithoutSpaces stringByReplacingOccurrencesOfString:@"<" withString:@""];
    device_Token = [strWithoutSpaces stringByReplacingOccurrencesOfString:@">" withString:@""];
     NSLog(@"Push Token is: %@", device_Token);
    
    /*
     NSCharacterSet *angleBrackets = [NSCharacterSet characterSetWithCharactersInString:@"<>"];
     self.device_Token = [[deviceToken description] stringByTrimmingCharactersInSet:angleBrackets];
     */
     
    // Push Token is: 8f19f49d3dd43ef564d781df65dbe90f2934b4d28db968dabe2540ef95d41c34

    //////
    // for getting ....
    NSString *  KEY_PASSWORD = @"com.toi.app.password";
    NSString *  idfv_Local = [[KeyChainValteck keyChainLoadKey:putValueToKeyChain] valueForKey:KEY_PASSWORD];
    NSLog(@"idfv is =====%@",idfv_Local);
    // for getting .....

    /*
     // older !!!
     
     SBNotificationHub* hub = [[SBNotificationHub alloc] initWithConnectionString:
     @"Endpoint=sb://toicjnotificationhub-ns.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=P6k4oyfooa2E7KZz+wNJ7/kTM3nPM3H2ZKM9Fneuu+A=" notificationHubPath:@"toicjnotificationhub"];
  
     */
    
    /*SBNotificationHub* hub = [[SBNotificationHub alloc] initWithConnectionString:
                              @"Endpoint=sb://toicjnotificationhubns.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=U3Mmj1sRJwXa5PwEJBwBj26JiiMPihR9niJpJokwpI4=" notificationHubPath:@"toicjnotificationhub"];
     */
    
    
    
    
    /*
    SBNotificationHub* hub = [[SBNotificationHub alloc] initWithConnectionString:
                              @"Endpoint=sb://toicrnotification-ns.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=L04ekioSLXTMHbpRGG1GT3CbcJbSPsmHSqoDZ4b0v/I=" notificationHubPath:@"toicrnotification"];
    */
    
    
    
    // changed on 19- jan - 2016..
    
   /* SBNotificationHub* hub = [[SBNotificationHub alloc] initWithConnectionString:
                              @"Endpoint=sb://toicrnotification-ns.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=L04ekioSLXTMHbpRGG1GT3CbcJbSPsmHSqoDZ4b0v/I=" notificationHubPath:@"timesgroupcrhub"];
    
    */
    
    
   // Changed on 22 -Jan - 2015.
    
    /*SBNotificationHub* hub = [[SBNotificationHub alloc] initWithConnectionString:
                              @"Endpoint=sb://toicrnotification-ns.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=LKKzl6zmgrNk8sYRnA1wP1syiyVHdLu+edZLcGZ3COE=" notificationHubPath:@"timesgroupcrhub"];
    
    */
    
    //changed on 23-01-2016
    
    
    SBNotificationHub* hub = [[SBNotificationHub alloc] initWithConnectionString:
                              @"Endpoint=sb://timesgroupcr-ns.servicebus.windows.net/;SharedAccessKeyName=DefaultFullSharedAccessSignature;SharedAccessKey=4gmNpJrY/N0GkbdjqC3rEvf3IOpu4++pUJXbvmD1Z+U=" notificationHubPath:@"timesgroupcr-hub"];
    
    
    
    
    
    
    
    //[NSString stringWithFormat:@"%i",randomNumber]
    NSSet *setis = [NSSet setWithObjects:randomNumber, nil];

    [hub registerNativeWithDeviceToken:deviceToken tags:setis completion:^(NSError* error) {
        if (error != nil) {
            NSLog(@"Error registering for notifications: %@", error);
        }
    }];

    
}




- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error{
    
	NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
	application.applicationIconBadgeNumber=application.applicationIconBadgeNumber+1;
    
    // NSLog(@"userInfo is =====%@",userInfo);
    
    UIApplicationState state = [application applicationState];
    
    if (state == UIApplicationStateActive){   // for active state .....
        
        //Do stuff that you would do if the application is active

        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        //////////////window azure..
        
        /*
         
         o/p of push notification from azure is -{
         aps =     {
         alert = "Your article has been published";
         };
         }

         
         */
        NSLog(@"o/p of push notification from azure is -%@", userInfo);
        
        
        NSString *message = [[userInfo valueForKey:@"aps"]valueForKey:@"alert"];
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        ///window azure....

    } else{    // for background state .....
        
        //Do stuff that you would do if the application was not active
        
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        
        NSLog(@"o/p of push notification from azure is -%@", userInfo);
        /*
         
         aps =     {
         alert = "Notification Hub test notification";
         };
         }
         
         
         
         */
        
        
        NSString *message = [[userInfo valueForKey:@"aps"]valueForKey:@"alert"];

        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }
    
}

#pragma mark ####################################################################
#pragma mark ##     PUSH NOTIFICATION HANDLING      ## END
#pragma mark ####################################################################

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    
    [self.window endEditing:YES];

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
   
    
   
    
    NSLog(@"MyArray is ===== %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"MyArray"]);
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)getCategory{

    __block id json;
   id_CategoryArray=[[NSMutableArray alloc]init];
    categoryNameArray=[[NSMutableArray alloc]init];
    
    // categoryNameArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",nil] ;
    
   // NSString *idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    /////////////////////start
    NSMutableDictionary *finalDictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *headerDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionaryTemp = [NSMutableDictionary dictionary];
    
    
    // for getting ....
    NSString *  KEY_PASSWORD = @"com.toi.app.password";
    NSString *  idfv_Local = [[KeyChainValteck keyChainLoadKey:putValueToKeyChain] valueForKey:KEY_PASSWORD];
    NSLog(@"getCategory idfv_Local  is =====%@",idfv_Local);
    // for getting .....
    

    [headerDict setValue:idfv_Local forKey:@"DeviceId"];  // THIS WILL CHANGE & WILL USE "idfv"
    [headerDict setValue:[[NSUserDefaults standardUserDefaults]stringForKey:@"userID_Default"] forKey:@"UserId"];
    [headerDict setValue:@"Maharashtra" forKey:@"Source"];
    
    [finalDictionary setObject:headerDict forKey:@"header"];
    [finalDictionary setValue:dictionaryTemp forKey:@"data"];
    
    NSLog(@"get Category data is = %@",finalDictionary);
    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:finalDictionary
                        
                                                       options:kNilOptions
                                                         error:&error];
    
// http://timesgroupcrapi.cloudapp.net   <---->  http://78dbfe55d0844370aacb49be8d573db3 <---> http://toicj
    
    NSURL *url = [NSURL URLWithString:@"http://timesgroupcrapi.cloudapp.net/api/Category"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (response ==nil || data ==nil) {
                                   
                                   NSLog(@"error catched!");

                               }
                               
                               else{
                               NSError *jsonError;
                                json = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&jsonError];
                               
                               NSLog(@"o/p of getCategory  is =   %@",json);
                               
                               if (json) {
                                  
                                   if([json valueForKey:@"Message"] != nil) {
                                       // The key existed...
                                       
                                       // amit joshi commented  5 august ...
                                     NSLog(@"go back to main !");
// /*
                                      // getting .....
                                      AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                      NSString *  KEY_PASSWORD = @"com.toi.app.password";
                                      NSString *    idfv = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
                                      NSLog(@"idfv is =====%@",idfv);
                                      // getting ...
                                     

                                     ///// for settting ....
                                     NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
                                     [usernamepasswordKVPairs setObject:@"Amit_Parameter_argument" forKey:KEY_PASSWORD];
                                     [KeyChainValteck keyChainSaveKey:app.putValueToKeyChain data:usernamepasswordKVPairs];
                                     
                                     /// for setting ......
                                     
                                     NSString *    idfvAfter = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
                                    
                                     NSLog(@"idfv is =====%@",idfvAfter);
                                    // [[NSNotificationCenter defaultCenter]postNotificationName:@"goBackToHome" object:nil];
                                       // amit joshi commented  5 august ...
 //*/

                                   }
                                   else {
                                       // No joy...

                                [ id_CategoryArray addObject: [[[json valueForKey:@"data"]valueForKey:@"Categories"]valueForKey:@"Id_Category"]];
                                [ categoryNameArray addObject: [[[json valueForKey:@"data"]valueForKey:@"Categories"]valueForKey:@"Name"]];
                                     
                                   }

                                   
                                   /*
                                    
                                    json is  {
                                    Message = "DeviceId is invalid";
                                    }
                                    
                                    //////
                                    
                                    json is  {
                                    data =     {
                                    Categories =         (
                                    {
                                    "Id_Category" = 1;
                                    Name = "Road Accident";
                                    },
                                    {
                                    "Id_Category" = 2;
                                    Name = Politics;
                                    },
                                    {
                                    "Id_Category" = 3;
                                    Name = Business;
                                    },
                                    {
                                    "Id_Category" = 4;
                                    Name = Technology;
                                    }
                                    );
                                    };
                                    header =     {
                                    DeviceId = "a@gmail.com";
                                    UserId = 50397;
                                    };
                                    }
                                    */
                                   
                                   
                                   
                                   
                                   // PickerViewForCategory.delegate=self;
                                   //return to main thread
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       NSLog(@"inside main thread!");
                                       [self registerPushNotification_Method];
                                   });
                                   
                               }
                               else{
                                   
                                   NSLog(@"An error occured: %@", jsonError);
                              
                               }
                             
                               }
                               ///////
                               if([json valueForKey:@"Message"] != nil) {
// /*
                                   // amit joshi commented  5 august ...
  
                                  // The key existed...
                                  
                               NSLog(@"go back to main !");
                                 
                                 // getting .....
                                 AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                 NSString *  KEY_PASSWORD = @"com.toi.app.password";
                                 NSString *    idfv = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
                                 NSLog(@"idfv is =====%@",idfv);
                                 // getting ...
                                 
                                 
                                 ///// for settting ....
                                 NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
                                 [usernamepasswordKVPairs setObject:@"Amit_Parameter_argument" forKey:KEY_PASSWORD];
                                 [KeyChainValteck keyChainSaveKey:app.putValueToKeyChain data:usernamepasswordKVPairs];
                                 
                                 /// for setting ......
                                 
                                 NSString *    idfvAfter = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
                                 
                                 NSLog(@"idfv is =====%@",idfvAfter);
                                // [[NSNotificationCenter defaultCenter]postNotificationName:@"goBackToHome" object:nil];
                               
                                 // amit joshi commented  5 august ...
// */
                                   
                               }else{
                                   
                                   

                               ///////
                               
                               }

                               //////
                               
                               
                               
                               
                           }];
    
    
}


-(void)registerPushNotification_Method{
    // for getting ....

    NSString *  KEY_PASSWORD = @"com.toi.app.password";
    NSString *  idfv_Local = [[KeyChainValteck keyChainLoadKey:putValueToKeyChain] valueForKey:KEY_PASSWORD];
    NSLog(@"idfv is =====%@",idfv_Local);
    // for getting .....

    __block id json;
    NSMutableDictionary *finalDictionary = [NSMutableDictionary dictionary];
    
    //[NSString stringWithFormat:@"%i",randomNumber]  for channeluri..
    
    [finalDictionary setValue:@"ios" forKey:@"platform"];
    [finalDictionary setValue:@"" forKey:@"instId"];
    [finalDictionary setValue:randomNumber forKey:@"channelUri"];
    [finalDictionary setValue:device_Token forKey:@"deviceToken"];
    [finalDictionary setValue:idfv_Local forKey:@"deviceId"];
    [finalDictionary setValue:[[NSUserDefaults standardUserDefaults]stringForKey:@"userID_Default"] forKey:@"userId"];
   // [finalDictionary setValue:@"TOI" forKey:@"Source"];
    
    
    NSLog(@"final dict is amit====%@",finalDictionary);
   // NSLog(@"push notification ====%@",finalDictionary);
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:finalDictionary
                        
                                                       options:kNilOptions
                                                         error:&error];
//timesgroupcrapi
    NSURL *url = [NSURL URLWithString:@"http://timesgroupcrapi.cloudapp.net/api/registerdevice"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];

    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (response ==nil || data ==nil) {
                                   
                                   NSLog(@"error catched!");

                               }
                               
                               else{
                                   NSError *jsonError;
                                   
                                   
                                   json = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&jsonError];
                                   
                                   
                    NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                NSLog(@"o/p is ==== %@",text);

                                   //o/p is ==== "successfully updated" //
                                   /*
                                    
                                    •	JSON format is used to send notifications.
                                    {“data”:{“message”:”The report has been published”}}.
                                    
                                    */

                                   if (json) {
                                       
                                   }else{
                                       
                                      // NSLog(@"error occured!");
                                   }
                                   
                                   
                               }
                               
                               
                           }];
    
}


@end
