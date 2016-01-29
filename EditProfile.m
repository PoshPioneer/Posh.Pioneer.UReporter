//
//  EditProfile.m
//  TOIAPP
//
//  Created by Valeteck on 31/07/14.
//  Copyright (c) 2014 CYNOTECK. All rights reserved.
//

#import "EditProfile.h"
#import "KeyChainValteck.h"
#import "AppDelegate.h"
#import "IQActionSheetPickerView.h"
#import "MobileVarification.h"
#import "UploadView.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface EditProfile ()//<IQActionSheetPickerViewDelegate>
{
    
    NSMutableData *responseData;
    NSMutableDictionary *finalDictionary;
    NSString * localPoliticalStr;
    NSString * localProsecutionStr;
    
    BOOL checkBoolForRestValuePolitical;
    BOOL checkBoolForRestVlaueProsecutin;
   
    
        
}

@end

@implementation EditProfile
@synthesize txt_Email,txt_First_Name,txt_Last_Name,txt_Phone;
@synthesize messageDisplayForAlert;
@synthesize switch_LocationEnable;
@synthesize checkServiceType;
@synthesize reset_Email,reset_FirstName,reset_IsLocationEnable,reset_LastName,reset_Phone,reset_Age,reset_Gender,reset_adderss,reset_MaritalStatus,reset_Occupation,reset_LanguageSpoken,reset_Education,reset_Special_Interests;
@synthesize reset_CompareValeForlocationEnable;
@synthesize scrollView,addViewOnScrollView;
@synthesize txt_Age,txt_adderss,txt_Occupation,txt_LanguageSpoken,txt_Education,txt_Special_Interests;
@synthesize Outlet_PoliticalGroupNO,Outlet_PoliticalGroupYes,Outlet_ProsecutionNO,Outlet_ProsecutionYes;
@synthesize reset_radiopolitical,reset_radioprosecution;


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
    [self CallMethodForPicker];
    
   /* [Outlet_PoliticalGroupYes setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    [Outlet_PoliticalGroupNO setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];*/
    [Outlet_ProsecutionYes setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    [Outlet_ProsecutionNO setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];

    
    self.scrollView.frame=CGRectMake(0, 86, 320, 700);
    self.scrollView.contentSize = CGSizeMake(320,1300);
    [scrollView setBackgroundColor:[UIColor clearColor]];
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    scrollView.clipsToBounds = YES;
    scrollView.scrollEnabled = YES;
    [self.view addSubview:self.scrollView];
    [scrollView addSubview:addViewOnScrollView];
    
    scrollView.userInteractionEnabled=YES;
    scrollView.exclusiveTouch=YES;
    
    [txt_Email setUserInteractionEnabled:NO];
    [txt_Phone setUserInteractionEnabled:YES];
    
    [self getAllDetails];
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    checkReset=0;
    
    ///// Dismiss KeyBord touch of View
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [scrollView addGestureRecognizer:tapGesture];
    ///// END..

}

-(void)viewDidAppear:(BOOL)animated{
    

}


- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView{
    
    return YES;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  
    if (alertView == alert_Internet) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else if (alertView ==finalAlert) {
//    //[self.navigationController popViewControllerAnimated:YES];
        
        
        
        for (UIViewController *controller in [self.navigationController viewControllers])
        {
            if ([controller isKindOfClass:[UploadView class]])
            {
                [self.navigationController popToViewController:controller animated:YES];
                break;
            }
        }
            
        
   
    }else if(alertView ==goBackAlert){
        
        if (buttonIndex==0) {
            
            // cancel pressed....

            // do nothing...
            
        }else if (buttonIndex==1){
            
            // ok pressed.......
            
            [self.navigationController popViewControllerAnimated:YES];

            
        }
        
    }


}

- (IBAction)back_Tapped:(id)sender {
    //Are you sure you want to cancel the changes in profile?
    
    /*
     reset_FirstName;
     reset_LastName;
     reset_Phone;
     reset_Email;
     reset_IsLocationEnable;
     */
    
 //reset_Age,reset_Gender,reset_adderss,reset_MaritalStatus,reset_Occupation,reset_LanguageSpoken,reset_Education,reset_Special_Interests
    
    if ([txt_First_Name.text isEqualToString:reset_FirstName] &&[txt_Last_Name.text isEqualToString:reset_LastName] && [txt_Email.text isEqualToString:reset_Email] && [txt_Phone.text isEqualToString:reset_Phone] && [txt_Age.text isEqualToString:reset_Age] && [txt_Gender.text isEqualToString:reset_Gender] && [txt_adderss.text isEqualToString:reset_adderss] && [txt_MaritalStatus.text isEqualToString:reset_MaritalStatus] && [txt_Occupation.text isEqualToString:reset_Occupation] && [txt_LanguageSpoken.text isEqualToString:reset_LanguageSpoken] && [txt_Education.text isEqualToString:reset_Education] && [txt_Special_Interests.text isEqualToString:reset_Special_Interests] && [localPoliticalStr isEqualToString:reset_radiopolitical] && [localProsecutionStr isEqualToString:reset_radioprosecution] &&(checkReset%2==0)) {
        
        // do nothing !!!!
        [self.navigationController popViewControllerAnimated:YES];

        
    }else{
        
        
        
        /*
         
         try_AgainInternet_Check = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
         [try_AgainInternet_Check show];
         
         
         */
        
      /*          goBackAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Are you sure you want to cancel the changes in the profile?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [goBackAlert show];
        */
        
        [self.navigationController popViewControllerAnimated:YES];
    }

    }


#pragma mark ################ Submit Tapped ############################

- (IBAction)submit_Tapped:(id)sender {
    
    [self.view endEditing:YES];

    if ([txt_First_Name.text isEqualToString:reset_FirstName] &&[txt_Last_Name.text isEqualToString:reset_LastName] && [txt_Email.text isEqualToString:reset_Email] && [txt_Phone.text isEqualToString:reset_Phone]  && [txt_Age.text isEqualToString:reset_Age] && [txt_Gender.text isEqualToString:reset_Gender] && [txt_adderss.text isEqualToString:reset_adderss] && [txt_MaritalStatus.text isEqualToString:reset_MaritalStatus] && [txt_Occupation.text isEqualToString:reset_Occupation] && [txt_LanguageSpoken.text isEqualToString:reset_LanguageSpoken] && [txt_Education.text isEqualToString:reset_Education] && [txt_Special_Interests.text isEqualToString:reset_Special_Interests] && [localPoliticalStr isEqualToString:reset_radiopolitical] && [localProsecutionStr isEqualToString:reset_radioprosecution] &&(checkReset%2==0)  ) {
        
        
        UIAlertView * DoNothing_alrt = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"There is no change in profile details" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
        [DoNothing_alrt show];
        
        
        
        
        // do nothing !!!!
        
    } else{
        
       
        
        
        
        NSLog(@"text Phone === %@",txt_Phone);
        NSLog(@"rest number ==%@",reset_Phone);
        
    NSString *server = [[NSUserDefaults standardUserDefaults]stringForKey:@"connection_Internet"];
    
    if ([server isEqualToString:@"reachable"]) {
        
        if ([txt_First_Name.text length]==0 || [txt_Last_Name.text length]==0 || [txt_Email.text length]==0 || [txt_Phone.text length]==0 || [txt_Phone.text length]!=10 || [txt_Age.text length]== 0 || [txt_Gender.text length] ==0 || [txt_MaritalStatus.text length]== 0 || [txt_adderss.text length]== 0 || [txt_Occupation.text length]==0 || [txt_LanguageSpoken.text length]== 0 || [txt_Education.text length]== 0 || [txt_Special_Interests.text length]==0 /*|| ([[Outlet_PoliticalGroupNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]] && [[Outlet_PoliticalGroupYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]]) */ || ([[Outlet_ProsecutionYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]] && [[Outlet_ProsecutionNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]]))  {
            
            if ([txt_First_Name.text length]==0) {
                
                messageDisplayForAlert = @"Please enter your first name";
                
            }else if ([txt_Last_Name.text length]==0){
                
                messageDisplayForAlert= @"Please enter your last name";
                
            }else if ([txt_Email.text length]==0){
                
                
                messageDisplayForAlert= @"Please enter an email id";
                
            }else if ([txt_Phone.text length]==0){
                
                messageDisplayForAlert= @"Please enter a mobile number";
            }
            
            else if([txt_Phone.text length]!=10){
                
                messageDisplayForAlert = @"Please enter a valid mobile number";
            }
            else if ([txt_Age.text length] == 0)
            {
                messageDisplayForAlert = @"Please enter your age";
            }
            else if ([txt_Gender.text length]==0)
            {
                messageDisplayForAlert = @"Please select your gender";
            }
            else if ([txt_adderss.text length] ==0)
            {
                messageDisplayForAlert = @"Please enter your city";
            }
            else if ([txt_MaritalStatus.text length]==0){
                
                messageDisplayForAlert = @"Please select your marital status";
            }
            else if ([txt_Occupation.text length]==0){
                
                messageDisplayForAlert = @"Please enter your occupation";
            }
            else if ([txt_LanguageSpoken.text length]==0)
            {
                messageDisplayForAlert = @"Please enter your spoken language";
            }
            else if ([txt_Education.text length] ==0)
            {
                messageDisplayForAlert = @"Please enter your highest level of education";
            }
            else if ([txt_Special_Interests.text length] ==0)
            {
                messageDisplayForAlert = @"Please enter special interests";
            }
//            else if (([[Outlet_PoliticalGroupNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]] && [[Outlet_PoliticalGroupYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]])){
//                
//                messageDisplayForAlert = @"Please select option for member of any political group.";
//            }
            else if ( ([[Outlet_ProsecutionYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]] && [[Outlet_ProsecutionNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"uncheck_radial.png"]])){
                
                messageDisplayForAlert = @"Please select option for prosecution if any.";
            }

            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:messageDisplayForAlert delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
            
        }else if ([txt_Age.text intValue]<=0){
        
        
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Plaese enter  a valid age" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        
        } else if (![self validateEmail:txt_Email.text]){
            
            messageDisplayForAlert=@"Please enter a valid email id";
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:messageDisplayForAlert delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            
        }else{
            
            
            [self callMethodFor_Submittion];
            
           // [self ServiceOTP];
            
        }
        
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message!" message:@"Internet connection is not available. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
        
    }
    
}

- (BOOL) validateEmail: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:candidate];
}

-(void)getAllDetails{
    
    checkServiceType=1;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.addViewOnScrollView setUserInteractionEnabled:NO];
    
    // getting .....
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *  KEY_PASSWORD = @"com.toi.app.password";
    NSString *    idfv = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
    NSLog(@"idfv is =====%@",idfv);
    // getting ...
    
   // NSString *toi = @"TOI";
    
    // http://timesgroupcrapi.cloudapp.net   http://timesgroupcrapi.cloudapp.net/api/UserDet
    
    NSString* urlString = [NSString stringWithFormat:@"http://timesgroupcrapi.cloudapp.net/api/userdetails?deviceId=%@&Source=%@", idfv,@"Maharashtra"];
   
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
}

#pragma marks NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error is %@",[error localizedDescription]);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.addViewOnScrollView setUserInteractionEnabled:YES];
    
   alert_Internet = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert_Internet show];

    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [responseData  appendData:data];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    responseData = [[NSMutableData alloc]initWithLength:0 ];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    [self.view setUserInteractionEnabled:YES];
    [spinner removeSpinner];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.addViewOnScrollView setUserInteractionEnabled:YES];

    NSError* error;
    id json = [NSJSONSerialization JSONObjectWithData:responseData
                                              options:kNilOptions
                                                error:&error];

    if (checkServiceType==1)
    {
        checkServiceType=0;
        
        NSLog(@"Edit profile view o/p is ====%@",json);
        /*
         
         data =     {
         Address = "it park dehradun";
         Age = 23;
         Email = "ravi.phulara@cynoteck.com";
         ErrorInfo =         {
         ErrorId = 113;
         ErrorMessage = "User has already registered with us.";
         };
         FacingLegalProsecution = "<null>";
         FirstName = ravi;
         Gender = MALE;
         "Id_UserDetail" = 60463;
         IsLocationEnabled = 1;
         IsMemberofPoliticalGroup = 0;
         LanguagesSpoken = hindi;
         LastName = phulara;
         LocationDetails = "<null>";
         MaritalStatus = UNMARRIED;
         Occupation = none;
         Phone = 7830904341;
         Qualification = btech;
         SpecialInterests = none;
         };
         header =     {
         DeviceId = "ravi.phulara@cynoteck.com";
         UserId = 60463;
         };
         }         */

        txt_First_Name.text       =    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"FirstName"]];
        txt_Last_Name.text        =    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"LastName"]];
        txt_Email.text            =    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"Email"]];
        txt_Phone.text            =    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"Phone"]];
        txt_Age.text              =    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"Age"]];
        txt_Gender.text           =    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"Gender"]];
        txt_adderss.text          =    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"Address"]];
        txt_MaritalStatus.text    =    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"MaritalStatus"]];
        txt_Occupation.text       =    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"Occupation"]];
        txt_LanguageSpoken.text   =    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"LanguagesSpoken"]];
        txt_Education.text        =    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"Qualification"]];
        txt_Special_Interests.text=    [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"SpecialInterests"]];
        
        // for political group..
        if ([[NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"IsMemberofPoliticalGroup"]] isEqualToString:@"1"])
        {
            [Outlet_PoliticalGroupYes setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
            
            localPoliticalStr =[NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"IsMemberofPoliticalGroup"]];
            
            
            
        }
        else if ([[NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"IsMemberofPoliticalGroup"]] isEqualToString:@"0"])
        {
            [Outlet_PoliticalGroupNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
            localPoliticalStr =[NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"IsMemberofPoliticalGroup"]];
            
            checkBoolForRestValuePolitical = YES;
            
        }
        else{
            
            [Outlet_PoliticalGroupNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
        }
        
        //for Legal Prosecution..
        if ([[NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"FacingLegalProsecution"]] isEqualToString:@"1"])
        {
            [Outlet_ProsecutionYes setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
            localProsecutionStr = [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"FacingLegalProsecution"]];
            
            
            
        }
        else if ([[NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"FacingLegalProsecution"]] isEqualToString:@"0"])
        {
            [Outlet_ProsecutionNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
            localProsecutionStr = [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"FacingLegalProsecution"]];
            
            checkBoolForRestVlaueProsecutin = YES;
            
        }
        else{
            [Outlet_ProsecutionNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
        }
        
                
        if ([[NSString stringWithFormat:@"%@",[[json valueForKey:@"data"]valueForKey:@"IsLocationEnabled"]] isEqualToString:@"0"]) {
         
            // no location details are there ...
            
            [switch_LocationEnable setOn:NO animated:YES];
            reset_IsLocationEnable=0;
            
        }else{
            
            [switch_LocationEnable setOn:YES animated:YES];
            reset_IsLocationEnable=1;
            
        }
        
        ///////////////setting reset values ...............
        reset_FirstName=txt_First_Name.text;
        reset_LastName=txt_Last_Name.text;
        reset_Email   =txt_Email.text;
        reset_Phone   =txt_Phone.text;
        reset_Age     = txt_Age.text;
        reset_Gender  = txt_Gender.text;
        reset_adderss = txt_adderss.text;
        reset_MaritalStatus = txt_MaritalStatus.text;
        reset_Occupation    = txt_Occupation.text;
        reset_LanguageSpoken = txt_LanguageSpoken.text;
        reset_Education      = txt_Education.text;
        reset_Special_Interests = txt_Special_Interests.text;
        reset_radiopolitical = localPoliticalStr;
        reset_radioprosecution = localProsecutionStr;
        ////////////// setting reset values ...............

        
    }else{
        
        checkServiceType=0;
        
        
        
        
        
        NSLog(@"o/p of data is =======%@",json);
        
        NSString *error_Id = [NSString stringWithFormat:@"%@",[[json valueForKey:@"data"] valueForKey:@"ErrorId"]];
        
        if ([error_Id isEqualToString:@"111"]) {
            
            if (![reset_Phone isEqualToString:txt_Phone.text]) {
                
                [self ServiceOTP];
                
                
            }
            
            else{
            
            finalAlert= [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Your profile updated successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [finalAlert show];
                
            }
            
        }
        
    }
    
}

#pragma mark ####################################################################
#pragma mark ################ Reset Tapped ######################################
#pragma mark ####################################################################

- (IBAction)Reset_Tapped:(id)sender {

    // setting previous values !!!!!!!!!!
    //reset_Age,reset_Gender,reset_adderss,reset_MaritalStatus,reset_Occupation,reset_LanguageSpoken,reset_Education,reset_Special_Interests
    
    checkReset=0;
    
    txt_First_Name.text        = reset_FirstName;
    txt_Last_Name.text         = reset_LastName;
    txt_Email.text             = reset_Email;
    txt_Phone.text             = reset_Phone;
    txt_Age.text               = reset_Age;
    txt_Gender.text            = reset_Gender;
    txt_adderss.text           = reset_adderss;
    txt_MaritalStatus.text     = reset_MaritalStatus;
    txt_Occupation.text        = reset_Occupation;
    txt_LanguageSpoken.text    = reset_LanguageSpoken;
    txt_Education.text         = reset_Education;
    txt_Special_Interests.text = reset_Special_Interests;
    
    // for political
    if (checkBoolForRestValuePolitical)
    {
        [Outlet_PoliticalGroupNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
        [Outlet_PoliticalGroupYes setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    }
    else{
        
        [Outlet_PoliticalGroupYes setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
        [Outlet_PoliticalGroupNO setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    }
    
    // for prosecution.
    if (checkBoolForRestVlaueProsecutin)
    {
        [Outlet_ProsecutionNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
        [Outlet_ProsecutionYes setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];

    }
    else{
        [Outlet_ProsecutionYes setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
        [Outlet_ProsecutionNO setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    }
    
    
  //  localPoliticalStr  = reset_radiopolitical;
   // localProsecutionStr = reset_radioprosecution;
    //reset_radiopolitical.text
    //reset_radioprosecution;
    
    if (reset_IsLocationEnable==0) {

        [switch_LocationEnable setOn:NO animated:YES];
        check_Uncheck_Bool=NO;
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"address_Default"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }else{
        [switch_LocationEnable setOn:YES animated:YES];
        check_Uncheck_Bool=YES;
 
    }
    
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
    [self.view  endEditing:YES]; //may be not required
    [super touchesBegan:touches withEvent:event]; //may be not required
    [self  dismissControls];
}

#pragma mark -
#pragma mark ---------------               RESIGN KEYBOARD on touch Method                ---------------
#pragma mark -

- (void)dismissControls
{
    
    [self.view  endEditing:YES]; //may be not required
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)enableStateChanged:(id)sender {
    
    checkReset++;
    
    if (switch_LocationEnable.on) {
        check_Uncheck_Bool=YES;
        reset_CompareValeForlocationEnable=1;
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

        
        
        
    }else{
        check_Uncheck_Bool=NO;
        reset_CompareValeForlocationEnable=0;
        
        
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  
        // NSLog(@"range is =====%i",range.length);
    
    if (range.length==1) {
        return YES;
    }
    
    if (textField ==txt_Phone) {
        
        if ([txt_Phone.text length]>=10) {
            return NO;
        }
        
    }
    if (textField == txt_Age)
    {
        if ([txt_Age.text length] >= 2)
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
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ,abcdefghijklmnopqrstuvwxyz "] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
        
        if([txt_LanguageSpoken.text length]>=100){
        
            return NO;
        }else{
        
        return [string isEqualToString:filtered];
        }
    }
    if (textField==txt_Occupation) {
        NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "] invertedSet];
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


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    
    [self.view setUserInteractionEnabled:YES];
    [spinner removeSpinner];
    check_Uncheck_Bool=NO;
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
                                       NSLog(@"Dictionary is %@",dict);

                                       
                                   }
                                   //return to main thread
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       
                                       [self.view setUserInteractionEnabled:YES];
                                       [spinner removeSpinner];
                                       
                                       
                                       NSString *address = [[NSUserDefaults standardUserDefaults]stringForKey:@"address_Default"];
                                       
                                       if (!address) {
                                           
                                           check_Uncheck_Bool=NO;
                                           UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"There was an error while getting the location." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                           [alert show];
                                           
                                       }else{
                                           check_Uncheck_Bool=YES;
                                           // do nothing!!!!!
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


-(void)callMethodFor_Submittion{
    
    checkServiceType=2;
    
    [self.view setUserInteractionEnabled:NO];
    spinner=[SpinnerView loadSpinnerIntoView:self.view];

    
    // getting .....
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *  KEY_PASSWORD = @"com.toi.app.password";
    NSString *    idfv = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
    NSLog(@"idfv is =====%@",idfv);
    // getting ...

   finalDictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *headerDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionaryTemp = [NSMutableDictionary dictionary];
    
    [headerDict setValue:idfv forKey:@"DeviceId"];  // THIS WILL CHANGE & WILL USE "idfv"
    [headerDict setValue:@":" forKey:@"UserId"];
    [headerDict setValue:@"Maharashtra" forKey:@"Source"];
    
    [dictionaryTemp setValue:txt_First_Name.text forKey:@"FirstName"];
    [dictionaryTemp setValue:txt_Email.text forKey:@"Email"];
    [dictionaryTemp setValue:txt_Phone.text forKey:@"Phone"];
    [dictionaryTemp setValue:txt_Last_Name.text forKey:@"LastName"];
    
    // Adding New Data on Service..
    [dictionaryTemp setValue:txt_Age.text forKey:@"Age"];
    [dictionaryTemp setValue:txt_Gender.text forKey:@"Gender"];
    [dictionaryTemp setValue:txt_adderss.text forKey:@"Address"];
    
    if([[Outlet_PoliticalGroupYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"check_radial.png"]]){
     
        [dictionaryTemp setValue:@"True" forKey:@"IsMemberofPoliticalGroup"];

    }else if ([[Outlet_PoliticalGroupNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"check_radial.png"]]) {
    
    
        [dictionaryTemp setValue:@"False" forKey:@"IsMemberofPoliticalGroup"];
    }

    if ([[Outlet_ProsecutionYes currentBackgroundImage] isEqual:[UIImage imageNamed:@"check_radial.png"]]) {
     
        [dictionaryTemp setValue:@"True" forKey:@"FacingLegalProsecution"];

    }else if ([[Outlet_ProsecutionNO currentBackgroundImage] isEqual:[UIImage imageNamed:@"check_radial.png"]]){
        
        [dictionaryTemp setValue:@"False" forKey:@"FacingLegalProsecution"];

    }
    [dictionaryTemp setValue:txt_Education.text forKey:@"Qualification"];
    [dictionaryTemp setValue:txt_MaritalStatus.text forKey:@"MaritalStatus"];
    [dictionaryTemp setValue:txt_Special_Interests.text forKey:@"SpecialInterests"];
    [dictionaryTemp setValue:txt_LanguageSpoken.text forKey:@"LanguagesSpoken"];
    [dictionaryTemp setValue:txt_Occupation.text forKey:@"Occupation"];
    
   // End
    
    if (check_Uncheck_Bool) {
        
        [dictionaryTemp setValue:@"true" forKey:@"IsLocationEnabled"];
        [dictionaryTemp setValue:[[NSUserDefaults standardUserDefaults]stringForKey:@"address_Default"] forKey:@"LocationDetails"];
        
    }else{
        
        [dictionaryTemp setValue:@"false" forKey:@"IsLocationEnabled"];
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"address_Default"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
    }
    
    [finalDictionary setObject:headerDict forKey:@"header"];
    [finalDictionary setValue:dictionaryTemp forKey:@"data"];
    
    
    
    
    NSLog(@"final Dictionary output ========= %@",finalDictionary);
    
    NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:finalDictionary
                        
                                                       options:kNilOptions
                                                         error:&error];
    
    //timesgroupcrapi  http://timesgroupcrapi.cloudapp.net/api/UserDet
    
    NSURL *url = [NSURL URLWithString:@"http://timesgroupcrapi.cloudapp.net/api/UserDetails"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
    //////////////////// end
    
}


#pragma mark OTP Service
-(void)ServiceOTP{
    
    [self.view setUserInteractionEnabled:NO];
    spinner=[SpinnerView loadSpinnerIntoView:self.view];
    
    NSString * MobNo= txt_Phone.text;
    
    //timesgroupcrapi http://timesgroupcrapi.cloudapp.net/api/UserDet
    
    NSString* urlString = [NSString stringWithFormat:@"http://timesgroupcrapi.cloudapp.net/api/OTP/GetOTP?MobileNo=%@&Source=%@",MobNo,@"Maharashtra"];

    //NSString* urlString = [NSString stringWithFormat:@"http://toicj.cloudapp.net/api/OTP/GetOTP?MobileNo=%@",MobNo];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               NSError *jsonError;
                               id  json = [NSJSONSerialization JSONObjectWithData:data
                                                                          options:kNilOptions
                                                                            error:&jsonError];
                               NSLog(@"json is for ServiceOTP== %@",json);
                               
                               
                               if (json) {
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       NSLog(@"inside main thread!");
                                       
                                       [self.view setUserInteractionEnabled:YES];
                                       [spinner removeSpinner];

                                       
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
                                               
                                               MobileVarification *mobile = [[MobileVarification alloc]initWithNibName:@"MobileVarification" bundle:nil];
                                               mobile.getData =[finalDictionary copy];
                                               mobile.getOTP =[[json valueForKey:@"data"]valueForKey:@"ErrorMessage"];
                                               
                                               // for current time
                                               NSDate *myDate = [NSDate date];
                                               NSTimeInterval getcurrentTime = [myDate timeIntervalSince1970];
                                               NSLog(@"this is current time now===%f",getcurrentTime);
                                               mobile.getTime = getcurrentTime;
                                               NSLog(@"check time==%f",mobile.getTime);
                                               
                                               [self.navigationController pushViewController:mobile animated:YES];
                                           }
                                           
                                           
                                       }
                                       else{
                                           
                                           UIAlertView * alertFor = [[UIAlertView alloc]initWithTitle:@"Message" message:[[json valueForKey:@"data"]valueForKey:@"ErrorMessage"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                           [alertFor show];
                                           
                                       }

                                       
                                   });
                               }
                               else{
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       NSLog(@"inside main thread!");
                                       NSLog(@"An error occured: %@", jsonError);
                                       [self.view setUserInteractionEnabled:YES];
                                       [spinner removeSpinner];
                                   });
                               }
                           }];

    
    
    
}



- (IBAction)btn_PoliticalGroupYes:(id)sender {
   
    localPoliticalStr = @"1";
    [Outlet_PoliticalGroupYes setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
    [Outlet_PoliticalGroupNO setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    
}

- (IBAction)btn_PoliticalGroupNo:(id)sender {
    
     localPoliticalStr = @"0";
    [Outlet_PoliticalGroupYes setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    [Outlet_PoliticalGroupNO setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
}

- (IBAction)btn_ProsecutionYes:(id)sender {
    
    localProsecutionStr = @"1";
    [Outlet_ProsecutionYes setBackgroundImage:[UIImage imageNamed:@"check_radial.png"] forState:UIControlStateNormal];
    [Outlet_ProsecutionNO setBackgroundImage:[UIImage imageNamed:@"uncheck_radial.png"] forState:UIControlStateNormal];
    
}

- (IBAction)btn_ProsecutionNo:(id)sender {
    
    localProsecutionStr = @"0";
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
    
    [txt_Gender setItemList:[NSArray arrayWithObjects:@"Male",@"Female", nil]];//MALE",@"FEMALE"
    [txt_MaritalStatus setItemList:[NSArray arrayWithObjects:@"Single",@"Married", nil]];//SINGLE",@"MARRIED
    
}


-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}


/*
 
- (IBAction)btn_genderPicker:(id)sender {
    
    NSLog(@"called picker");
    [self.view endEditing:YES];
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


-(void)viewWillDisappear:(BOOL)animated {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}

// method to hide keyboard when user taps on a scrollview
-(void)hideKeyboard
{
    [self.view  endEditing:YES];
}

/*
 if ([[NSString stringWithFormat:@"%@",[[json valueForKey:@"data"]valueForKey:@"LocationDetails"]] isEqualToString:@"<null>"]) {
 
 NSLog(@"location is empty!");
 
 }else{
 
 // we are getting here location details !!!!!!!
 }
 
 */
@end
