//
//  ViewController.m
//  TOIAPP
//
//  Created by CYNOTECK on 7/25/14.
//  Copyright (c) 2014 CYNOTECK. All rights reserved.
//
//this is device id---C30E91B0-7795-4427-A4F2-9AED0D897A7A
#import "ViewController.h"
#import "UploadView.h"
#import "Reachability.h"
#import "KeyChainValteck.h"
#import "AppDelegate.h"
#import "IQActionSheetPickerView.h"
#import "MobileVarification.h"
#import "EditProfile.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ViewController ()//<IQActionSheetPickerViewDelegate>
{
    
    NSMutableData *responseData;
    NSString *idfv;
    NSString *DeviceIdStringForCondition;
    NSMutableDictionary *finalDictionary;
   
    
}
@end

@implementation ViewController
@synthesize txt_Email,txt_First_Name,txt_Last_Name,txt_Phone;
@synthesize messageDisplayForAlert;
@synthesize switch_LocationEnable;
@synthesize checkServiceType;
@synthesize submit_Outlet;
@synthesize scrollView,addViewOnScrollView;
@synthesize txt_Age,txt_adderss,txt_Occupation,txt_LanguageSpoken,txt_Education,txt_Special_Interests;
@synthesize Outlet_PoliticalGroupNO,Outlet_PoliticalGroupYes,Outlet_ProsecutionNO,Outlet_ProsecutionYes;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        checkServiceType=0;
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        only_Once = YES ;
    }
    else
    {
        NSLog(@"There IS internet connection");
        only_Once = NO ;
    }
    
    check_Uncheck_Bool=YES;
    
    [self ShowViewContent];
    

    /*
    
//    NSString *server = [[NSUserDefaults standardUserDefaults]stringForKey:@"connection_Internet"];
//    
//    if ([server isEqualToString:@"reachable"]) {
//  
    
        if ([[[NSUserDefaults standardUserDefaults]stringForKey:@"TimesOfIndiaRegistrationID"] isEqualToString:@"110"]) {
    
            CGSize size = [[UIScreen mainScreen]bounds].size;
            
            if (size.height==480) {
                UploadView *up=[[UploadView alloc]initWithNibName:@"UploadView3.5" bundle:nil];
                [self.navigationController pushViewController:up animated:YES];

                
            }else{
                UploadView *up=[[UploadView alloc]initWithNibName:@"UploadView" bundle:nil];
                [self.navigationController pushViewController:up animated:YES];

            }
            
        }else{

        [self checkUserAlreadyAvailableService];
        }
        
//  }else{
//        m_SplashView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 568.0)];
//        m_SplashView.image = [UIImage imageNamed:@"Default.png"];
//        
//        [self.view addSubview:m_SplashView];
//        [self.view bringSubviewToFront:m_SplashView];
//
//       alertFor_Internet = [[UIAlertView alloc]initWithTitle:@"Message!" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alertFor_Internet show];
//        
//    }
     
     
     */
    
    
   // [self checkUserAlreadyAvailableService];
    /*
     
     // getting .....
     AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
     NSString *  KEY_PASSWORD = @"com.toi.app.password";
     NSString *    idfv = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
     NSLog(@"idfv is =====%@",idfv);
     // getting ...
     
     */
    
}

-(void)ShowViewContent{
    
   /* [self CallMethodForPicker];*/
    
    [Outlet_PoliticalGroupNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
    [Outlet_ProsecutionNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
    
    //self.view.backgroundColor=[UIColor blackColor];
    self.navigationController.navigationBarHidden=YES;
    
   // [self checkForInternetConnection];
    
    self.scrollView.frame=CGRectMake(0, 86, 320, 700);
    self.scrollView.contentSize = CGSizeMake(320,1290);
    [scrollView setBackgroundColor:[UIColor clearColor]];
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    scrollView.clipsToBounds = YES;
    scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    [scrollView addSubview:addViewOnScrollView];
    
    scrollView.userInteractionEnabled=YES;
    scrollView.exclusiveTouch=YES;

}



-(void)viewWillAppear:(BOOL)animated{
    
     ///// Dismiss KeyBord touch of View
     UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
     [scrollView addGestureRecognizer:tapGesture];
    ///// END..
    
    NSString *  KEY_PASSWORD = @"com.toi.app.password";
    
    // for getting ....
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSMutableDictionary *keyDict = [KeyChainValteck keyChainLoadKey:app.putValueToKeyChain];
    // for getting .....
    
    NSLog(@"keyDict is ======%@",keyDict);


    NSString *strForAlreadyChecking = [keyDict valueForKey:KEY_PASSWORD];
    
    if ([keyDict count]==0 || [strForAlreadyChecking isEqualToString:@"Amit_Parameter_argument"]) {
        
        NSLog(@"keychain is nil for all.");
        
        
//        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
//        {
//            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
        
            
            if ([[[UIDevice currentDevice] systemVersion] floatValue] > 9.2 ) {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"This app is not compatible with the OS version on your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        //}

        
        
        // first time ....empty!
        if (only_Once) {   // Internet connection is not available !! so show alert
            
            alertFor_Internet = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertFor_Internet show];
            
        }
        
        
        
        

        
    }else{
        
        CGSize size = [[UIScreen mainScreen]bounds].size;
        if (size.height==480) {
            UploadView *up=[[UploadView alloc]initWithNibName:@"UploadView3.5" bundle:nil];
            [self.navigationController pushViewController:up animated:NO];
            
            
        }else{
            UploadView *up=[[UploadView alloc]initWithNibName:@"UploadView" bundle:nil];
            [self.navigationController pushViewController:up animated:NO];
            
        }
        
    }

    
}

//[[NSUserDefaults standardUserDefaults]stringForKey:@"userID_Default"]

-(void)checkForInternetConnection{
    
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
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertFor_Internet==alertView) {
    exit(1);
    }else if (alertFor_Navigate==alertView){
       /*
        
        CGSize size = [[UIScreen mainScreen]bounds].size;
        
        if (size.height==480) {
            
           // UploadView *up=[[UploadView alloc]initWithNibName:@"UploadView3.5" bundle:nil];
           // [self.navigationController pushViewController:up animated:YES];
            
        // Updated New Code 2015.
            
            MobileVarification *mobile = [[MobileVarification alloc]initWithNibName:@"MobileVarification3.5" bundle:nil];
            [self.navigationController pushViewController:mobile animated:YES];
            
            
        }else{
            
          //  UploadView *up=[[UploadView alloc]initWithNibName:@"UploadView" bundle:nil];
           // [self.navigationController pushViewController:up animated:YES];
            
            // Updated New Code 2015.
            MobileVarification *mobile = [[MobileVarification alloc]initWithNibName:@"MobileVarification" bundle:nil];
            [self.navigationController pushViewController:mobile animated:YES];
        }

     */
        
    }
}



- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    
    return YES;
    
}


-(void)viewDidLayoutSubviews {
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
    [self.view setUserInteractionEnabled:YES];
    [spinner removeSpinner];

    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Alert" message:@"There was an error while getting the location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
                                       
                                       if (!address) {
                                           
                                           check_Uncheck_Bool=NO;
                                           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"There was an error while getting the location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                           [alert show];
                                           
                                       }else{
                                           
                                           check_Uncheck_Bool=YES;
                                           // do nothing!!!!!
//                                           if ([txt_First_Name.text length]==0 || [txt_Last_Name.text length]==0 || [txt_Email.text length]==0 || [txt_Phone.text length]==0 || [txt_Phone.text length]!=10) {
//                                               
//                                               
//                                           }else{
//                                               
//                                               
//                                               submit_Outlet.highlighted=YES;
//                                               
//                                               
//                                           }
                                           
                                       }
                                       
                                       
                                       NSLog(@"inside main thread!");
                                   });
                               }
                               else{
                                   
                                   [self.view setUserInteractionEnabled:YES];
                                   [spinner removeSpinner];

                                   //error while getting location so we need to set bool no here !!!!!!
                                   check_Uncheck_Bool=NO;
                                   NSLog(@"An error occured: %@", jsonError);
                                   
                               }
                           }];
    
    // coding to send data to server .......end..
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)checkUserAlreadyAvailableService{
    
    checkServiceType=1;

    [self.view setUserInteractionEnabled:NO];
    spinner=[SpinnerView loadSpinnerIntoView:self.view];
    
    
    ///////////////////////////
    // getting .....
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *  KEY_PASSWORD = @"com.toi.app.password";
    NSString *    idfv_Local = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
    // getting ...
    
    //////////////////////////

   //timesgroupcrapi  <-->  78dbfe55d0844370aacb49be8d573db3
    NSString* urlString = [NSString stringWithFormat:@"http://timesgroupcrapi.cloudapp.net/api/userdetails?deviceId=%@&source=%@", [[NSString stringWithFormat:@"\"%@\"",idfv_Local] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"Maharashtra"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
   [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
}

#pragma mark ####################################################################
#pragma mark ##############      TextField Delegate    ##########################
#pragma mark ####################################################################

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   // textField.text=@"";
    static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
    static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
    static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
    static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
    static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
    
    CGRect textFieldRect;
    CGRect viewRect;
    
    textFieldRect =[self.view.window convertRect:textField.bounds fromView:textField];
    viewRect =[self.view.window convertRect:self.view.bounds fromView:self.view];
    
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =[[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame;
    
    viewFrame= self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    if(textField.tag==0)
    {
        static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
        CGRect viewFrame;
        
        viewFrame= self.view.frame;
        viewFrame.origin.y += animatedDistance;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        
        
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
        
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [self.view  endEditing:YES]; //may be not required
//    [super touchesBegan:touches withEvent:event]; //may be not required
//    [self  dismissControls];
}

#pragma mark -
#pragma mark ---------------               RESIGN KEYBOARD on touch Method                ---------------
#pragma mark -

- (void)dismissControls
{
    [self.view  endEditing:YES]; //may be not required
    
}

#pragma mark ################ Reset Tapped ############################

- (IBAction)Reset_Tapped:(id)sender {
    
    //txt_Age,txt_Gender,txt_adderss,txt_MaritalStatus,txt_Occupation,txt_LanguageSpoken,txt_Education,txt_Special_Interests

    ////// do empty all fields .....
    
    txt_First_Name.text=nil;
    txt_Last_Name.text=nil;
    txt_Email.text=nil;
    txt_Phone.text=nil;
    txt_Age.text = nil;
    txt_Gender.text = nil;
    txt_adderss.text = nil;
    txt_MaritalStatus.text = nil;
    txt_Occupation.text = nil;
    txt_LanguageSpoken.text = nil;
    txt_Education.text = nil;
    txt_MaritalStatus.text = nil;
    txt_Special_Interests.text = nil;
    
    [Outlet_PoliticalGroupYes setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    [Outlet_ProsecutionYes setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    [Outlet_PoliticalGroupNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
    [Outlet_ProsecutionNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];

    ////// do empty all fields .....
    
}




#pragma mark ################ Submit Tapped ############################





- (IBAction)submit_Tapped:(id)sender {
    
    [self.view endEditing:YES];
   
     NSString *server = [[NSUserDefaults standardUserDefaults]stringForKey:@"connection_Internet"];
   
       if ([server isEqualToString:@"reachable"]) {
   
        [self checkSubmitDetails];
           
       }else{
           
           UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [alrt show];
           
       }
}

-(void)checkSubmitDetails{
    
    if(/*[txt_First_Name.text length]==0 || [txt_Last_Name.text length]==0 ||*/ [txt_Email.text length]==0 || [txt_Phone.text length]==0 || [txt_Phone.text length]!=10 /*|| [txt_Age.text length]==0 || [txt_Gender.text length]==0 ||[txt_adderss.text length]==0 || [txt_MaritalStatus.text length]==0 || [txt_Occupation.text length]==0 || [txt_LanguageSpoken.text length]==0 || [txt_Education.text length]==0  || [txt_Special_Interests.text length]==0*/) //|| ([[Outlet_PoliticalGroupNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]] && [[Outlet_PoliticalGroupYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]]) || ([[Outlet_ProsecutionYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]] && [[Outlet_ProsecutionNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]])) {
    {
        if ([txt_Email.text length]==0) {
            
            messageDisplayForAlert= @"Please enter an email id";
            
        }else if ([txt_Phone.text length]==0){
            
            messageDisplayForAlert= @"Please enter a mobile number";
            
        }else if ([txt_Phone.text length]!=10){
            
            
            messageDisplayForAlert = @"Please enter a valid mobile number";
            
        }/*else if ([txt_Phone.text length]==0){
            
            messageDisplayForAlert= @"Please enter a mobile number";
        }*/
        /*
        else if([txt_Phone.text length]!=10){
            
            messageDisplayForAlert = @"Please enter a valid mobile number";
        }
        else if ([txt_Age.text length] == 0){
            
            messageDisplayForAlert = @"Please enter your age";
        }
        else if ([txt_Gender.text length] == 0){
            
            messageDisplayForAlert = @"Please select your gender";
        }
        else if ([txt_adderss.text length]==0){
            
            messageDisplayForAlert = @"Please enter your city";
        }
        else if ([txt_Occupation.text length] == 0){
            
            messageDisplayForAlert = @"Please enter your occupation";
        }
        else if ([txt_LanguageSpoken.text length] ==0){
            
            messageDisplayForAlert = @"Please enter your spoken language";
        }
        else if ([txt_Education.text length] == 0){
            
            messageDisplayForAlert = @"Please enter your highest level of education";
        }*
        else if ([txt_MaritalStatus.text length] == 0)
        {
            messageDisplayForAlert = @"Please select your marital status";
        }
        else if ([txt_Special_Interests.text length]== 0)
        {
            messageDisplayForAlert = @"Please enter your special interests";
        }*/
//        else if (([[Outlet_PoliticalGroupNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]] && [[Outlet_PoliticalGroupYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]])){
//            
//            messageDisplayForAlert = @"Please select option for member of any political group.";
//        }
//        else if ( ([[Outlet_ProsecutionYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]] && [[Outlet_ProsecutionNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]])){
//            
//            messageDisplayForAlert = @"Please select option for prosecution if any.";
//        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:messageDisplayForAlert delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

    }/*else if ([txt_Age.text intValue]<=0){
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Plaese enter  a valid age" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }*/
    
    
    else if (![self validateEmail:txt_Email.text]){
        
        messageDisplayForAlert=@"Please enter a valid email id";
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:messageDisplayForAlert delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    }else
        
    {
        [self callMethodForLoginService]; // call method  on registration.
        
    }
    
}

- (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}


-(void)callMethodForLoginService{

    NSString *str =[NSString stringWithFormat:@"%@",txt_Email.text];
    NSLog(@"str is ====%@",str);
    

    //    ///// for settting ....
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate ;
//    NSString *  KEY_PASSWORD = @"com.toi.app.password";
//    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
//    [usernamepasswordKVPairs setObject:str forKey:KEY_PASSWORD];
//    [KeyChainValteck keyChainSaveKey:app.putValueToKeyChain data:usernamepasswordKVPairs];
//    
//    /// for setting ......
//    
//    // for getting ....
//    idfv = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
//    NSLog(@"idfv is =====%@",idfv);
//    // for getting .....
//
//    checkServiceType=2;
////    [self.view setUserInteractionEnabled:NO];
////    spinner=[SpinnerView loadSpinnerIntoView:self.view];
//  
// 

    // idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
   
    NSLog(@"============= Testing for Pioneer App =============================");
    
    finalDictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *headerDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionaryTemp = [NSMutableDictionary dictionary];
    
    [headerDict setValue:txt_Email.text forKey:@"DeviceId"];  // THIS WILL CHANGE & WILL USE "idfv"
    [headerDict setValue:@":" forKey:@"UserId"];
    [headerDict setValue:@"Maharashtra" forKey:@"Source"];

    [dictionaryTemp setValue:@"" forKey:@"FirstName"];
    [dictionaryTemp setValue:txt_Email.text forKey:@"Email"];
    [dictionaryTemp setValue:txt_Phone.text forKey:@"Phone"];
    [dictionaryTemp setValue:@"" forKey:@"LastName"];
    
    // Adding New Data on Service..
    [dictionaryTemp setValue:@"" forKey:@"Age"];
    [dictionaryTemp setValue:@"" forKey:@"Gender"];
    [dictionaryTemp setValue:@"" forKey:@"Address"];
    
   /* if([[Outlet_PoliticalGroupYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"check_radial.png"]]){
        
        [dictionaryTemp setValue:@"true" forKey:@"IsMemberofPoliticalGroup"];
        
    }else if ([[Outlet_PoliticalGroupNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"check_radial.png"]]) {
        
        [dictionaryTemp setValue:@"false" forKey:@"IsMemberofPoliticalGroup"];
    }*/
    
  /*  if ([[Outlet_ProsecutionYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"check_radial.png"]]) {
        
        [dictionaryTemp setValue:@"true" forKey:@"FacingLegalProsecution"];
        
    }else if ([[Outlet_ProsecutionNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"check_radial.png"]]){
        
        [dictionaryTemp setValue:@"false" forKey:@"FacingLegalProsecution"];
        
    }*/
    
    [dictionaryTemp setValue:@"" forKey:@"Qualification"];
    [dictionaryTemp setValue:@"" forKey:@"MaritalStatus"];
    [dictionaryTemp setValue:@"" forKey:@"SpecialInterests"];
    [dictionaryTemp setValue:@"" forKey:@"LanguagesSpoken"];
    [dictionaryTemp setValue:@"" forKey:@"Occupation"];
    // END..
    
    
    if (check_Uncheck_Bool) {
        
        [dictionaryTemp setValue:@"true" forKey:@"IsLocationEnabled"];
        [dictionaryTemp setValue:[[NSUserDefaults standardUserDefaults]stringForKey:@"address_Default"] forKey:@"LocationDetails"];
        
    }else{
        
        [dictionaryTemp setValue:@"false" forKey:@"IsLocationEnabled"];

    }

    [finalDictionary setObject:headerDict forKey:@"header"];
    [finalDictionary setValue:dictionaryTemp forKey:@"data"];

    
    NSLog(@"while registration data sent is = %@",finalDictionary);
   
    
    // NO Need of OTP///
    
    [self ServiceOTP];
    
    
//    NSError *error = nil;
//
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:finalDictionary
//                        
//                                                       options:kNilOptions
//                                                         error:&error];
//    
//    
//    NSURL *url = [NSURL URLWithString:@"http://toicj.cloudapp.net/api/UserDetails"];
//    
//    
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:jsonData];
//    
//    
//    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
//    [connection start];
    
    //////////////////// end

    
}

#pragma mark OTP Service
-(void)ServiceOTP{
    
    [self.view setUserInteractionEnabled:NO];
    spinner=[SpinnerView loadSpinnerIntoView:self.view];
    
    NSString * MobNo= txt_Phone.text;
 
    //timesgroupcrapi  <-->  78dbfe55d0844370aacb49be8d573db3
    NSString* urlString = [NSString stringWithFormat:@"http://timesgroupcrapi.cloudapp.net/api/OTP/GetOTP?MobileNo=%@&Source=%@",MobNo,@"Maharashtra"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
}

#pragma mark Login Service....

-(void)methodToRegisterUser {
    
    [self.view setUserInteractionEnabled:NO];
    spinner=[SpinnerView loadSpinnerIntoView:self.view];
    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:finalDictionary
                        
                                                       options:kNilOptions
                                                         error:&error];
    //timesgroupcrapi  http://timesgroupcrapi.cloudapp.net/api/UserDet
    NSURL *url = [NSURL URLWithString:@"http://timesgroupcrapi.cloudapp.net/api/UserDetails"];
    
    NSLog(@"DICT IS===%@",finalDictionary);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *jsonError;
                               
                               NSLog(@"data = %@",data);
                               NSLog(@"response = %@",response);
                               NSLog(@"error = %@",error);
                               
                               if (data==nil || response==nil) {
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       NSLog(@"inside main thread!");
                                       NSLog(@"An error occured: %@", jsonError);
                                       [self.view setUserInteractionEnabled:YES];
                                       [spinner removeSpinner];
                                   });
                                   
                                   
                               }else{
                                   
                                   
                                   id  json = [NSJSONSerialization JSONObjectWithData:data
                                                                              options:kNilOptions
                                                                                error:&jsonError];
                                   NSLog(@"json is for UserDetails== %@",json);
                                   
                                   
                                   if ( error ==nil) {
                                       
                                       if (json) {
                                           
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               NSLog(@"inside main thread!");
                                               
                                               [self.view setUserInteractionEnabled:YES];
                                               [spinner removeSpinner];
                                               
                                               /////////////
                                               
                                               NSString *strCompare = [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"ErrorId"]];
                                               
                                               if ([strCompare isEqualToString:@"110"] || [strCompare isEqualToString:@"111"]) {
                                                   
                                                   //   NSString *userID_Default = [NSString stringWithFormat:@"%@",[[json valueForKey:@"header"] valueForKey:@"UserId"]];
                                                   
                                                   
                                                   [[NSUserDefaults standardUserDefaults]setValue:[NSString stringWithFormat:@"%@",[[json valueForKey:@"header"] valueForKey:@"UserId"]] forKeyPath:@"userID_Default"];
                                                   
                                                   
                                                   
                                                   
                                                   [[NSUserDefaults standardUserDefaults]setValue:strCompare forKeyPath:@"TimesOfIndiaRegistrationID"];
                                                   [[NSUserDefaults standardUserDefaults]synchronize];
                                                   
                                                   
                                                   
                                                   NSLog(@"id is = %@",[[NSUserDefaults standardUserDefaults]stringForKey:@"userID_Default"]);
                                                   
                                                   
                                                   //////////////////////////////////////////////////
                                                   //////////////////////////////////////////////////
                                                   
                                                   ///// for settting ....
                                                   AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate ;
                                                   NSString *  KEY_PASSWORD = @"com.toi.app.password";
                                                   NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
                                                   [usernamepasswordKVPairs setObject:[[finalDictionary valueForKey:@"data"] valueForKey:@"Email"] forKey:KEY_PASSWORD];
                                                   [KeyChainValteck keyChainSaveKey:app.putValueToKeyChain data:usernamepasswordKVPairs];
                                                   
                                                   /// for setting ......
                                                   
                                                   // for getting ....
                                                   NSString *  valueIs = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
                                                   NSLog(@"idfv is =====%@",valueIs);
                                                   // for getting .....
                                                   
                                                   /////////////////////////////////////////////////
                                                   /////////////////////////////////////////////////
                                                   
                                                   if ([strCompare isEqualToString:@"110"]) {
                                                       
                                                       UploadView *upload = [[UploadView alloc]initWithNibName:@"UploadView" bundle:nil];
                                                       
                                                       // mobile.getData =[finalDictionary copy];
                                                       //  mobile.getOTP =[[json valueForKey:@"data"]valueForKey:@"ErrorMessage"];
                                                       
                                                       // for current time
                                                       NSDate *myDate = [NSDate date];
                                                       NSTimeInterval getcurrentTime = [myDate timeIntervalSince1970];
                                                       NSLog(@"this is current time now===%f",getcurrentTime);
                                                       //  mobile.getTime = getcurrentTime;
                                                       [self.navigationController pushViewController:upload animated:YES];
                                                       
                                                       //first time registration...
                                                       
//                                                       successful_AlertShow = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Profile registered successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                                       [successful_AlertShow show];
                                                       
                                                       
                                                   }else{
                                                       // second time ......
                                                       
//                                                       successful_AlertShow = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Your profile updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                                       [successful_AlertShow show];
                                                       
                                                       
                                                       
                                                   }
                                                   
                                               }  /// end of correct condition to navigate ...
                                               
                                               
                                               //////////////
                                               
                                           });
                                       }
                                       
                                   } // error == nil check !!!end
                                   else{
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           NSLog(@"inside main thread!");
                                           NSLog(@"An error occured: %@", jsonError);
                                           [self.view setUserInteractionEnabled:YES];
                                           [spinner removeSpinner];
                                       });
                                   }
                               }
                           }];
    
}



#pragma marks NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error is %@",[error localizedDescription]);
    
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
    NSLog(@"final json ===OTP %@",json);
    
    NSString * strCheck =[NSString stringWithFormat:@"%@",[[json valueForKey:@"data"]valueForKey:@"ErrorId"]];
     
    if ([strCheck isEqualToString:@"0"])
    {
        CGSize size = [[UIScreen mainScreen]bounds].size;
        if (size.height==480) {
            
            MobileVarification *mobile = [[MobileVarification alloc]initWithNibName:@"MobileVarification3.5" bundle:nil];
            mobile.getData =[finalDictionary copy];
            mobile.getOTP =[[json valueForKey:@"data"]valueForKey:@"ErrorMessage"];
            // for current time
            NSDate *myDate = [NSDate date];
            NSTimeInterval getcurrentTime = [myDate timeIntervalSince1970];
            NSLog(@"this is current time now===%f",getcurrentTime);
            mobile.getTime = getcurrentTime;
            
            [self.navigationController pushViewController:mobile animated:YES];
            
            
        }else{
            
            UploadView *upload = [[UploadView alloc]initWithNibName:@"UploadView" bundle:nil];
            
           // mobile.getData =[finalDictionary copy];
          //  mobile.getOTP =[[json valueForKey:@"data"]valueForKey:@"ErrorMessage"];
            
            // for current time
            NSDate *myDate = [NSDate date];
            NSTimeInterval getcurrentTime = [myDate timeIntervalSince1970];
            NSLog(@"this is current time now===%f",getcurrentTime);
          //  mobile.getTime = getcurrentTime;
            [self methodToRegisterUser];
           /// [self.navigationController pushViewController:upload animated:YES];
        }

    }
    else{
        
       UIAlertView * alertFor = [[UIAlertView alloc]initWithTitle:@"Message" message:[[json valueForKey:@"data"]valueForKey:@"ErrorMessage"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertFor show];
        
    }
    
    
    return ;
    
    if (checkServiceType==1) {
        checkServiceType=0;
        
        if (!json) {
            
            // json is empty!!!!!!!
            
            
        }else{
        
        
        // for checking user already available or not!!!!!!!!
        
        NSString *compareStr = [NSString stringWithFormat:@"%@",[[[json valueForKey:@"data"]valueForKey:@"ErrorInfo"]valueForKey:@"ErrorId"]];
        if ([compareStr isEqualToString:@"110"] ) {
            
        }
            
        NSLog(@"availability ----%@",json);
            
        }
        
    }else if(checkServiceType==2) {
        
       checkServiceType=0;
       NSLog(@"json is  %@",json);
    
        
        
        /*
         
         json is  {
         data =     {
         ErrorId = 110;
         ErrorMessage = "User Details have been submitted successfully.";
         };
         header =     {
         DeviceId = "7003AF40-9093-433B-9A02-17E31FDF452E";
         UserId = 40527;
         };
         }
         
         */
        
        /*
        json is  {
            data =     {
                ErrorId = 110;
                ErrorMessage = "User Details have been submitted successfully.";
            };
            header =     {
                DeviceId = 38423740239841;
                UserId = 40523;
            };
        }
         
         */

        NSString *strCompare = [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"ErrorId"]];
        
        if ([strCompare isEqualToString:@"110"] || [strCompare isEqualToString:@"111"]) {
            
            NSString *userID_Default = [NSString stringWithFormat:@"%@",[[json valueForKey:@"header"] valueForKey:@"UserId"]];
            
                   [[NSUserDefaults standardUserDefaults]setValue:userID_Default forKeyPath:@"userID_Default"];
                   [[NSUserDefaults standardUserDefaults]setValue:strCompare forKeyPath:@"TimesOfIndiaRegistrationID"];
                   [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            if ([strCompare isEqualToString:@"110"]) {
                
                //first time registration...
                
                alertFor_Navigate = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Profile registered successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertFor_Navigate show];

            }else{
                // second time ......
                
                alertFor_Navigate = [[UIAlertView alloc]initWithTitle:@"Message" message:@"Your profile updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertFor_Navigate show];
                
            }
            
        }  /// end of correct condition to navigate ...
        
    }
    
}

- (IBAction)enableStateChanged:(id)sender {
    
    if (switch_LocationEnable.on) {
        check_Uncheck_Bool=YES;
        [self.view setUserInteractionEnabled:NO];
        spinner=[SpinnerView loadSpinnerIntoView:self.view];

        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if(IS_OS_8_OR_LATER) {
            
            [locationManager requestAlwaysAuthorization];
            [locationManager startUpdatingLocation];

       
        }else  {
            
            [locationManager startUpdatingLocation];

        }

        
    }else{
        check_Uncheck_Bool=NO;
        
    }

    
}

/*

 if ([string isEqualToString:@""]) {
 NSLog(@"Backspace");
 }
 return YES;
 
 
 */

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
   // NSLog(@"range is =====%i",range.length);
    
    if (range.length==1) {
        return YES;
    }
    
    if (textField ==txt_Phone ) {
        
        if ([txt_Phone.text length]>=10) {
            return NO;
        }
        
    }
    if (textField == txt_Age)
    {
        if ([txt_Age.text length]>=2)
        {
            return NO;
        }
    }
    if(textField == txt_First_Name)
    {
           NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        if ([txt_First_Name.text length]>=15)
        {
            return NO;
        }
        else{
            
            return [string isEqualToString:filtered];
        }
        
    }
    
    
    
    if(textField == txt_Last_Name)
    {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        if([txt_Last_Name.text length]>=15){
            
            return NO;
        }else{
            return [string isEqualToString:filtered];
        }
    }
    if (textField==txt_LanguageSpoken) {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz, "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        if([txt_LanguageSpoken.text length]>=100){
            
            return NO;
        }else{
            
            return [string isEqualToString:filtered];
        }
    }
    if (textField==txt_Occupation) {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz, "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    if(textField==txt_Special_Interests){
    
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ,abcdefghijklmnopqrstuvwxyz "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        if([txt_Special_Interests.text length]>=250){
            return NO;
        }
        else{
            return [string isEqualToString:filtered];
        }
    
    
    }
    if (textField==txt_Education) {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ,abcdefghijklmnopqrstuvwxyz "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        if([txt_Education.text length]>=50){
            return NO;
        }else{
            return [string isEqualToString:filtered];
        }
    }
    if (textField == txt_adderss)
    {
        if ([txt_adderss.text length]>=400)
        {
            return NO;
        }
    }
    
    if (textField == txt_Email)
    {
        if ([txt_Email.text length]>=150)
        {
            return NO;
        }
    }
    
    return YES;
    
}
/*
- (IBAction)btn_PoliticalGroupYes:(id)sender {
    
    [Outlet_PoliticalGroupYes setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
    [Outlet_PoliticalGroupNO setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    
    
    
}*/
/*
- (IBAction)btn_PoliticalGroupNo:(id)sender {
    
    [Outlet_PoliticalGroupYes setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    [Outlet_PoliticalGroupNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
    
}
*/

- (IBAction)btn_ProsecutionYes:(id)sender {
    
    [Outlet_ProsecutionYes setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
    [Outlet_ProsecutionNO setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];

}

- (IBAction)btn_ProsecutionNo:(id)sender {
    
    [Outlet_ProsecutionYes setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    [Outlet_ProsecutionNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];

}


# pragma Mark Use picker for ios 8 & 7 ..

-(void)CallMethodForPicker{
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    txt_Gender.inputAccessoryView = toolbar;
    txt_MaritalStatus.inputAccessoryView = toolbar;
   
    [txt_Gender setItemList:[NSArray arrayWithObjects:@"Male",@"Female", nil]];
    [txt_MaritalStatus setItemList:[NSArray arrayWithObjects:@"Single",@"Married", nil]];
    
}

-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}



#pragma mark Unused code for IOS 7 Picker

/*
- (IBAction)btn_genderPicker:(id)sender {
    
    NSLog(@"called picker for Gender");
   [self.view endEditing:YES];
 // txt_Age,txt_Gender,txt_adderss,txt_MaritalStatus,txt_Occupation,txt_LanguageSpoken,txt_Education,txt_Special_Interests
    
//    [txt_Age resignFirstResponder];
//    [txt_Gender resignFirstResponder];
//    [txt_adderss resignFirstResponder];
//    [txt_MaritalStatus resignFirstResponder];
//    [txt_Occupation resignFirstResponder];
//    [txt_LanguageSpoken resignFirstResponder];
//    [txt_Education resignFirstResponder];
//    [txt_Special_Interests resignFirstResponder];
    
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Choose Gender" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:5];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"MALE",@"FEMALE", nil];
    NSMutableArray *outerArr = [NSMutableArray  array];
    [outerArr addObject:arr];
    [picker setTitlesForComponenets:[NSArray arrayWithArray:outerArr]];
    [picker showInView:self.view];

}

- (IBAction)btn_maritalStatus:(id)sender {
    
    NSLog(@"called picker for Marital Status");
    [self.view endEditing:YES];
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Choose Marital Status" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:6];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"MARRIED",@"UNMARRIED", nil];
    NSMutableArray *outerArr = [NSMutableArray  array];
    [outerArr addObject:arr];
    [picker setTitlesForComponenets:[NSArray arrayWithArray:outerArr]];
    [picker showInView:self.view];

}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
{
    switch (pickerView.tag)
    {
        case 5: txt_Gender.text=[titles componentsJoinedByString:@" - "];
            break;
        case 6:txt_MaritalStatus.text=[titles componentsJoinedByString:@" - "];
            
        default:
            break;
    }
}

*/


// method to hide keyboard when user taps on a scrollview
-(void)hideKeyboard
{
    [self.view  endEditing:YES];
}



@end
