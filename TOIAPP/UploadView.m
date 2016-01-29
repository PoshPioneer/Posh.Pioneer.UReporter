//
//  UploadView.m
//  TOIAPP
//
//  Created by CYNOTECK on 7/25/14.
//  Copyright (c) 2014 CYNOTECK. All rights reserved.
//

#import "UploadView.h"
#import "UploadVideoView.h"
#import "UploadPhoto.h"
#import "UploadTextView.h"
#import "Setting_Screen.h"
#import "UploadAudioView.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "KeyChainValteck.h"
#import "Info.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface UploadView (){
    
    NSMutableData *responseData;
}

@end

@implementation UploadView
@synthesize iOutlet;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self checkForInternetConnection];
    [self checkUserAlreadyAvailableService];

      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(gobackToHomeScreen) name:@"goBackToHome" object:nil];
    
   // NSString *server = [[NSUserDefaults standardUserDefaults]stringForKey:@"connection_Internet"];
    
//    if ([server isEqualToString:@"reachable"]) {
//        
    
  //  }else{
//        m_SplashView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 568.0)];
//        m_SplashView.image = [UIImage imageNamed:@"Default.png"];
//        
//        [self.view addSubview:m_SplashView];
//        [self.view bringSubviewToFront:m_SplashView];
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message!" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
    
    //}
    
    // getting .....
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *  KEY_PASSWORD = @"com.toi.app.password";
NSString *    idfv = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
    NSLog(@"idfv is =====%@",idfv);
    // getting ...
    
     
    
}

-(void)gobackToHomeScreen{
    
    NSLog(@"goBackToHomeScreen");
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //[iOutlet setUserInteractionEnabled:NO];

    
}

-(void)checkUserAlreadyAvailableService{
    // getting .....
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *  KEY_PASSWORD = @"com.toi.app.password";
    NSString *    idfv = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
    NSLog(@"idfv is =====%@",idfv);
    // getting ...

    //http://toicj.cloudapp.net/api/UserDetails?deviceId="dhdhdh@gmail.com"&source="TOI"
    
    [self.view setUserInteractionEnabled:NO];
    spinner=[SpinnerView loadSpinnerIntoView:self.view];
  //  NSString* urlString = [NSString stringWithFormat:@"http://toicj.cloudapp.net/api/UserDetails?deviceId=%@&source=%@", [[NSString stringWithFormat:@"\"%@\"",idfv] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"TOI"];
    
    
   // NSString *toi = @"TOI";
    //timesgroupcrapi  <-->  78dbfe55d0844370aacb49be8d573db3
    NSString* urlString = [NSString stringWithFormat:@"http://timesgroupcrapi.cloudapp.net/api/UserDetails?deviceId=%@&source=%@",idfv,@"Maharashtra"];
    
    NSLog(@"URL===%@",urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
}

-(void)checkForInternetConnection{
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // internet is available!!!!
            [[NSUserDefaults standardUserDefaults]setValue:@"reachable" forKeyPath:@"connection_Internet"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            

        });
    };

    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // no internet...!!
            [[NSUserDefaults standardUserDefaults]setValue:@"not_reachable" forKeyPath:@"connection_Internet"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            

        });
    };
    
    [reach startNotifier];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    exit(1);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Video_Tapped:(id)sender {
    
    [self checkforNavigationInternetconnection:1];

}

- (IBAction)Photo_Tapped:(id)sender {
    
    [self checkforNavigationInternetconnection:2];
    
}

- (IBAction)Audio_Tapped:(id)sender {
    
    [self checkforNavigationInternetconnection:3];

    
}

- (IBAction)Text_Tapped:(id)sender {
    
    [self checkforNavigationInternetconnection:4];

}

- (IBAction)setting_Tapped:(id)sender {
    
    [self checkforNavigationInternetconnection:5];

}

- (IBAction)i_ForContent_Tapped:(id)sender {
    

    CGSize size = [[UIScreen mainScreen]bounds].size;
    
    if (size.height==480) {
        
        Info *uploadV = [[Info alloc]initWithNibName:@"info3.5" bundle:nil];
        [self.navigationController pushViewController:uploadV animated:YES];
        
    }else{
        
        Info *uploadV = [[Info alloc]initWithNibName:@"Info" bundle:nil];
        [self.navigationController pushViewController:uploadV animated:YES];
        
    }
    
    
}


-(void)checkforNavigationInternetconnection:(int)type{
    
    /*
    ////////////////////////////////////   if internet comes late .... starts ..
    ////////////////////////////////////

    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    if ([app.categoryNameArray count]==0 || [app.id_CategoryArray count]==0) {
        
       // NSLog(@"quite empty!!!!");
         [app getCategory];
    }
    
    ////////////////////////////////// if internet comes late ...... ends ....
    //////////////////////////////////
     
     */
    
    NSString *server = [[NSUserDefaults standardUserDefaults]stringForKey:@"connection_Internet"];
    
    if ([server isEqualToString:@"reachable"]) {
        
          if (type==1) {
              
              CGSize size = [[UIScreen mainScreen]bounds].size;
              
              if (size.height==480) {

                  UploadVideoView *uploadV = [[UploadVideoView alloc]initWithNibName:@"UploadVideoView3.5" bundle:nil];
                  [self.navigationController pushViewController:uploadV animated:YES];
                  
              }else{
                  
                  UploadVideoView *uploadV = [[UploadVideoView alloc]initWithNibName:@"UploadVideoView" bundle:nil];
                  [self.navigationController pushViewController:uploadV animated:YES];
                  
              }
              
        }else if (type==2) {
            
            CGSize size = [[UIScreen mainScreen]bounds].size;
            
            if (size.height==480) {
                
                UploadPhoto *uploadP = [[UploadPhoto alloc]initWithNibName:@"UploadPhoto3.5" bundle:nil];
                [self.navigationController pushViewController:uploadP animated:YES];
                
            }else{
                
                UploadPhoto *uploadP = [[UploadPhoto alloc]initWithNibName:@"UploadPhoto" bundle:nil];
                [self.navigationController pushViewController:uploadP animated:YES];
                
            }

            
        }else if (type ==3){
            
            
            CGSize size = [[UIScreen mainScreen]bounds].size;
            
            if (size.height==480) {
                
                UploadAudioView *uploadP = [[UploadAudioView alloc]initWithNibName:@"UploadAudioView3.5" bundle:nil];
                [self.navigationController pushViewController:uploadP animated:YES];

            }else{
                
                UploadAudioView *uploadP = [[UploadAudioView alloc]initWithNibName:@"UploadAudioView" bundle:nil];
                [self.navigationController pushViewController:uploadP animated:YES];
 
            }
            
        }else if (type==4){
            
            CGSize size = [[UIScreen mainScreen]bounds].size;
            
            if (size.height==480) {
                UploadTextView *text=[[UploadTextView alloc]initWithNibName:@"UploadTextView3.5" bundle:nil];
                [self.navigationController pushViewController:text animated:YES];
                
            }else{
                UploadTextView *text=[[UploadTextView alloc]initWithNibName:@"UploadTextView" bundle:nil];
                [self.navigationController pushViewController:text animated:YES];
                
            }

            
            
            
            
        }else if (type ==5){
            
            Setting_Screen *setting=[[Setting_Screen alloc]initWithNibName:@"Setting_Screen" bundle:nil];
            [self.navigationController pushViewController:setting animated:YES];
            
        }

    }else{
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Internet connection is not available. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }


}



#pragma marks NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error is %@",[error localizedDescription]);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"There was an error while processing the request." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];

    [self.view setUserInteractionEnabled:YES];
    [spinner removeSpinner];
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData  appendData:data];
    
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    responseData = [[NSMutableData alloc]initWithLength:0 ];
    
    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //parse out the json data
    
    [self.view setUserInteractionEnabled:YES];
    [spinner removeSpinner];
    
    
    
    NSError* error;
    id json = [NSJSONSerialization JSONObjectWithData:responseData
                                              options:kNilOptions
                                                error:&error];
    
    
        if (!json) {
            
            // json is empty!!!!!!!
            
            
        }else{
            
//            // for checking user already available or not!!!!!!!!
//            
//            NSString *compareStr = [NSString stringWithFormat:@"%@",[[[json valueForKey:@"data"]valueForKey:@"ErrorInfo"]valueForKey:@"ErrorId"]];
//            if ([compareStr isEqualToString:@"110"]) {
//                
//            }
            

            NSLog(@"availability ----%@",json);
            
            /*
             availability ----{
             data =     {
             Email = "ankur@gmail.com";
             ErrorInfo =         {
             ErrorId = 113;
             ErrorMessage = "User has already registered with us.";
             };
             FirstName = ankur;
             "Id_UserDetail" = 50386;
             IsLocationEnabled = 0;
             LastName = joshi;
             LocationDetails = "<null>";
             Phone = 1234567890;
             };
             header =     {
             DeviceId = "ankur@gmail.com";
             UserId = 50386;
             };
             }
             
             */
            

            if ([[NSString stringWithFormat:@"%@",[[json valueForKey:@"data"]valueForKey:@"IsLocationEnabled"]] isEqualToString:@"0"]) {
                
                // no location details are there ...
                
                
            }else{
                
                
                ///// we need to fetch location.....
                [self.view setUserInteractionEnabled:NO];
                spinner=[SpinnerView loadSpinnerIntoView:self.view];
                
                locationManager = [[CLLocationManager alloc] init];
                locationManager.delegate = self;
                locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                [locationManager startUpdatingLocation];
                
                if(IS_OS_8_OR_LATER) {
                    
                    [locationManager requestAlwaysAuthorization];
                    [locationManager startUpdatingLocation];
                    
                    
                }else  {
                    
                    [locationManager startUpdatingLocation];
                    
                }


            }
            
            
            
            
            NSString *userID_Default = [NSString stringWithFormat:@"%@",[[json valueForKey:@"header"] valueForKey:@"UserId"]];
            
            NSLog(@"userid is ======%@",userID_Default);
            [[NSUserDefaults standardUserDefaults]setValue:userID_Default forKeyPath:@"userID_Default"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            AppDelegate *app =(AppDelegate *)[UIApplication sharedApplication].delegate;
            [app getCategory];
            
        }
    
    }

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
    [self.view setUserInteractionEnabled:YES];
    [spinner removeSpinner];
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Alert" message:@"There was an error while getting the location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        NSLog(@"lat is ====%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        NSLog(@"lat is ====%@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude]);
        [self getAdrressFromLatLong:currentLocation.coordinate.latitude lon:currentLocation.coordinate.longitude];
        [locationManager stopUpdatingLocation];
        
        
    }
}


-(void)getAdrressFromLatLong : (CGFloat)lat lon:(CGFloat)lon{
    // coding to send data to server .......start
    
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&amp;sensor=false",lat,lon];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *jsonError;
                               NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                                                options:kNilOptions
                                                                                  error:&jsonError];
                               if (array) {
                                   
                                   for (NSDictionary * dict in array) {
                                       
                                       NSLog(@"op address is ===%@",[[[array valueForKey:@"results"] valueForKey:@"formatted_address"]objectAtIndex:0]);
                                       [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[[[array valueForKey:@"results"] valueForKey:@"formatted_address"]objectAtIndex:0]] forKey:@"address_Default"];
                                       [[NSUserDefaults standardUserDefaults]synchronize];
                                       
                                   }
                                   //return to main thread
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       
                                       [self.view setUserInteractionEnabled:YES];
                                       [spinner removeSpinner];
                                       
                                       
                                       NSString *address = [[NSUserDefaults standardUserDefaults]stringForKey:@"address_Default"];
                                       [[NSUserDefaults standardUserDefaults]synchronize];
                                       
                                       if (!address) {
                                           
                                           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"There was an error while getting the location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                           [alert show];
                                           
                                       }else{
                                           // do nothing!!!!!
                                       }
                                       NSLog(@"inside main thread!");
                                   });
                               }
                               else{
                                   [self.view setUserInteractionEnabled:YES];
                                   [spinner removeSpinner];
                                   
                                   //error while getting location so we need to set bool no here !!!!!!
                                   NSLog(@"An error occured: %@", jsonError);
                                   
                               }
                           }];

    // coding to send data to server .......end..
    
}


@end
