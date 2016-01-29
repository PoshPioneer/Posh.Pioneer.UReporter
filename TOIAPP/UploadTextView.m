//
//  UploadTextView.m
//  TOIAPP
//
//  Created by amit bahuguna on 7/30/14.
//  Copyright (c) 2014 CYNOTECK. All rights reserved.
//

#import "UploadTextView.h"
#import "RecordAudioView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "IQActionSheetPickerView.h"
#import "Setting_Screen.h"
#import "KeyChainValteck.h"


@interface UploadTextView()//<IQActionSheetPickerViewDelegate>

@end

@implementation UploadTextView
@synthesize txt_Title,txt_View;
@synthesize segment_Outlet;

@synthesize textDataDictionary;          //New changes

@synthesize cut_Sec,lbl_AddStory_Outlet,lbl_finalPicker_Selected,lbl_Select_new_Category,lbl_selected_File_Outlet,lbl_Title,image_AddStory_Outlet,image_Select_NewCategory,image_Title_Outlet,img_View_Selected_File_Outlet,btn_Reset_Outlet,btn_Selected_new_Category_Outlet,btn_Upload_Outlet;
@synthesize written_Address;
@synthesize img_ForSuccess_Unsuccess,view_ForSuccess_Unsuccess,ok_For_Success_Outlet;
@synthesize with_Address_Optional_Written;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)checkCategoryData {
    
  //  AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([app.categoryNameArray count]==0 || [app.id_CategoryArray count]==0) {
        
        NSLog(@"quite empty!!!!");
        // [app getCategory];
        
        NSLog(@"coming!");
    }else{
        
        lbl_output_category.userInteractionEnabled=YES ;
        [self CallMethodForPicker];
        [timerCheck invalidate];
        
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    img_ForSuccess_Unsuccess.userInteractionEnabled = YES;
    
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [lbl_output_category setUserInteractionEnabled:NO];
    timerCheck = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkCategoryData) userInfo:nil repeats:YES];

    
    // Do any additional setup after loading the view from its nib.
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"it's great !");
    segment_Outlet.selectedSegmentIndex=0;
	// Set a tint color
    
    segment_Outlet.layer.cornerRadius=2.0;
	segment_Outlet.tintColor =[UIColor redColor];     //[UIColor colorWithRed:255/196 green:255/51 blue:255/41 alpha:1.0];
    
    
}

-(void)viewDidLayoutSubviews{
    
    //AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"id is =====%@",app.id_CategoryArray);//  app.id_CategoryArray
    NSLog(@"name is ===%@",app.categoryNameArray);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back_Tapped:(id)sender {
    
    if ([lbl_output_category.text length]>0 || [txt_Title.text length]>0 || [txt_View.text length]>0) {
        
        
        goBackAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Are you sure you want to cancel this news submission?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [goBackAlert show];
       
    }else{
        
        txt_View.text=nil;
        txt_Title.text=nil;
        lbl_finalPicker_Selected.text=nil;
        lbl_output_category.text=@"Choose Category";
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (IBAction)reset_Tapped:(id)sender {
    
    txt_View.text=nil;
    txt_Title.text=nil;
    lbl_finalPicker_Selected.text=nil;
    lbl_output_category.text=nil;
    
    
}
/*NSString *rawString = [textField text]; NSRange range = [rawString rangeOfCharacterFromSet:whitespace]; */

- (IBAction)upload_Tapped:(id)sender {
    
    
    [self.view endEditing:YES];

    NSString *message;
    
    

    
    
    
    NSString *server = [[NSUserDefaults standardUserDefaults]stringForKey:@"connection_Internet"];
    
    if ([server isEqualToString:@"reachable"]) {
    

    if ([lbl_output_category.text length]==0 || [txt_Title.text length]==0 || [txt_View.text length]==0) {
        
        if ([lbl_output_category.text length]==0) {
            
             message = @"Please select a category";
            
        }else if ([txt_Title.text length]==0){
             message=@"Please enter a title";
            
            
        }else if ([txt_View.text length]==0){
            
             message = @"Please enter a story";
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        
        NSString *checkStr =    [[NSUserDefaults standardUserDefaults]stringForKey:@"address_Default"];
        
        if (!checkStr) {
            
            without_Address = [[UIAlertView alloc]initWithTitle:@"Location auto capturing is off" message:@"Please enter the location(city) for your news/story" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
            without_Address.alertViewStyle=UIAlertViewStylePlainTextInput;
            UITextField *txtLocation = [without_Address textFieldAtIndex:0];
            txtLocation.delegate     = self;
            txtLocation.text         = @"";
            txtLocation.clearButtonMode = UITextFieldViewModeWhileEditing;
            [txtLocation setPlaceholder:@"Location"];
            [without_Address show];
            
        }else{
            
            with_Address = [[UIAlertView alloc]initWithTitle:@"Your current location" message:[NSString stringWithFormat:@"%@\n\nIf incorrect, please enter the location(city) for your news/story",checkStr] delegate:self cancelButtonTitle:@"Submit" otherButtonTitles:nil ,nil];
            with_Address.alertViewStyle=UIAlertViewStylePlainTextInput;
            
            UITextField *txtLocation = [with_Address textFieldAtIndex:0];
            txtLocation.delegate     = self;
            txtLocation.text         = @"";
            txtLocation.clearButtonMode = UITextFieldViewModeWhileEditing;
            [txtLocation setPlaceholder:@"Location"];
            [with_Address show];
            
            
        }
        
    }
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Internet connection is not available. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];

        
    }
    
    
}



- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    
    if (alertView == without_Address) {
        
    UITextField *textField = [alertView textFieldAtIndex:0];
        
    if ([textField.text length] == 0)
    {
        return NO;
    }
        written_Address=[alertView textFieldAtIndex:0].text;

    }else if (alertView==with_Address){
        
        with_Address_Optional_Written=[alertView textFieldAtIndex:0].text;
        
    }

    return YES;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (alertView == with_Address) {
        
        // do nothing for now !!!
        
//        if (buttonIndex==0) {
//            
//            NSLog(@"cancel tapped!");
//            
//        }else{
        
        with_Address_Optional_Written=[alertView textFieldAtIndex:0].text;
        
            [self  sendText_ToServer];
            
       // }
        
        
    }else if(alertView ==without_Address){
        
        
        if (buttonIndex == 0)
        {
            //    UITextField *Location = [alertView textFieldAtIndex:0];
            //    NSLog(@"username: %@", username.text);
            
            NSLog(@"first one ");
            NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
            
            if ([[alertView textFieldAtIndex:0].text length]<=0) {
                
                
                
            }
            
        }
        else{
            [self  sendText_ToServer];
            
            NSLog(@"seocnd one ");
            NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
            
            //  [with_Address dismissWithClickedButtonIndex:2 animated:YES];
            
            
        }
        
    }else if (alertView ==goBackAlert){
        
        if (buttonIndex==0) {
            
            // cancel tapped...
            
            
        }else if(buttonIndex ==1){

            txt_View.text=nil;
            txt_Title.text=nil;
            lbl_finalPicker_Selected.text=nil;
            lbl_output_category.text=@"Choose Category";
            [self.navigationController popViewControllerAnimated:YES];

        }

    }else if (try_AgainInternet_Check==alertView){
        
        if (buttonIndex==0) {
            
            // for first send service....
            // cancel tapped.......
            NSLog(@"cancel_Tapped");
            
            ok_For_Success_Outlet.tag=2;
            CGSize size = [[UIScreen mainScreen]bounds].size;
            
            if (size.height==480) {
                [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess3.5.png"]];
                
                UIButton *btnUpload=[[UIButton alloc]initWithFrame:CGRectMake(102.0, 299.0, 115.0, 38.0)];
                
                
                [btnUpload setImage:[UIImage imageNamed:@"btn_ip5.png"] forState:UIControlStateNormal];
                [btnUpload addTarget:self action:@selector(btn_Success_Tapped:) forControlEvents:UIControlEventTouchUpInside];
               
                // [button addTarget:self
                      //     action:@selector(aMethod:)
                // forControlEvents:UIControlEventTouchUpInside];
                [img_ForSuccess_Unsuccess addSubview:btnUpload];
                
                
                
            }else{
                [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess.png"]];
                UIButton *btnUpload=[[UIButton alloc]initWithFrame:CGRectMake(103.0, 345.0, 115.0, 38.0)];
                [btnUpload setImage:[UIImage imageNamed:@"btn_ip5.png"] forState:UIControlStateNormal];
                [btnUpload addTarget:self action:@selector(btn_Success_Tapped:) forControlEvents:UIControlEventTouchUpInside];

                [img_ForSuccess_Unsuccess addSubview:btnUpload];
            }
            
            [self.view addSubview:self.view_ForSuccess_Unsuccess];
            
            
            
        }else if (buttonIndex==1){
            
            // on ok tapped!!!!!!!!!!!

            [self sendText_ToServer];
            
        }
        
    }
}



//h ttp://hayageek.com/ios-nsurlsession-example/#get-post
-(void)sendText_ToServer {
    
    
    layer = [CAGradientLayer layer];
    layer.frame = self.view.bounds;
    UIColor *blackColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
    UIColor *clearColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
    layer.colors = [NSArray arrayWithObjects:(id)clearColor.CGColor, (id)blackColor.CGColor, nil];
    [self.view.layer insertSublayer:layer atIndex:1];
    
    __block  NSString *categoryId_String;
    
    //AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [ [app.categoryNameArray objectAtIndex:0] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        
        NSString *campareStr = [NSString stringWithFormat:@"%@",[[app.categoryNameArray objectAtIndex:0]objectAtIndex:idx]];
        if ([campareStr isEqualToString:lbl_output_category.text]) {
            
            categoryId_String = [NSString stringWithFormat:@"%@",[[app.id_CategoryArray objectAtIndex:0]objectAtIndex:idx]];
            
        }
        
    }];
    
    // hiding !!!!!
    ///////////////////////////////////////////
    //////////////////////////////////////////
    // looping all subviews except circular view for showing progress...
    
    for (UIView *subview in self.view.subviews)
    {
        
        
            subview.hidden = YES;
            
        
    }
    
    
    ///////////////////////////////////////
    ///////////////////////////////////////
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    
    //timesgroupcrapi  http://timesgroupcrapi.cloudapp.net/api/UserDet
    NSURL * url = [NSURL URLWithString:@"http://timesgroupcrapi.cloudapp.net/api/CJDetails"];
  //  NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
   
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:300];

    
    NSMutableDictionary *finalDictionary = [NSMutableDictionary dictionary];
    NSMutableDictionary *headerDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionaryTemp = [NSMutableDictionary dictionary];
    
    ///////////////////////////
    // getting .....
    NSString *  KEY_PASSWORD = @"com.toi.app.password";
    NSString *    idfv = [[KeyChainValteck keyChainLoadKey:app.putValueToKeyChain] valueForKey:KEY_PASSWORD];
    // getting ...
    
    //////////////////////////
    
    [headerDict setValue:idfv forKey:@"DeviceId"];
    [headerDict setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"userID_Default"] forKey:@"UserId"];  // user id is yet to set ....
    [headerDict setValue:@"Maharashtra" forKey:@"Source"];
    
    [dictionaryTemp setValue:txt_Title.text forKey:@"Title"];
    [dictionaryTemp setValue:txt_View.text forKey:@"FullStory"];
    [dictionaryTemp setValue:categoryId_String forKey:@"Id_Category"];    // picker view 's category.....
    [dictionaryTemp setValue:[[NSUserDefaults standardUserDefaults] stringForKey:@"userID_Default"] forKey:@"SubmittedBy"];         // user id need to get set here .
    [dictionaryTemp setValue:@"Submitted" forKey:@"JournalStatus"];
    [dictionaryTemp setValue:@"4" forKey:@"Id_MainCategory"];
    [dictionaryTemp setValue:@"" forKey:@"Id_Blob"];
    
    
    
    NSString *checkStr =    [[NSUserDefaults standardUserDefaults]stringForKey:@"address_Default"];
    
    if (!checkStr) {
      // when it's empty!!!!!
        
        [dictionaryTemp setValue:written_Address forKeyPath:@"LocationDetails"];
    
    }else{
        
        // when it's not empty  (address is not empty!!!!)
        
        NSCharacterSet *charSet = [NSCharacterSet whitespaceCharacterSet];
        NSString *trimmedString = [with_Address_Optional_Written stringByTrimmingCharactersInSet:charSet];
        if ([trimmedString isEqualToString:@""]) {
            
            // it's empty or contains only white spaces
            [dictionaryTemp setValue:checkStr forKey:@"LocationDetails"];
            
        }else{
            
            [dictionaryTemp setValue:with_Address_Optional_Written forKey:@"LocationDetails"];
        }
        
    }
    
    NSLog(@" subodh value of addres is ======%@",[dictionaryTemp valueForKey:@"LocationDetails"]);

    [finalDictionary setObject:headerDict forKey:@"header"];
    [finalDictionary setValue:dictionaryTemp forKey:@"data"];
    
     NSLog(@"Request ON Text ===%@",finalDictionary);
    
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];

    [urlRequest setHTTPMethod:@"POST"];
    NSError *error;

    [urlRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:finalDictionary
                                                             options:kNilOptions
                                                               error:&error]];
    
    
    /*
     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
     cachePolicy:NSURLRequestUseProtocolCachePolicy
     timeoutInterval:300];
     */
    
    //AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"Response:%@ %@\n", response, error);
                                                           if(error == nil)
                                                           {
//                                                               NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//                                                               NSLog(@"o/p is ==== %@",text);
                                                               
                                                               NSError *jsonError;
                                                               NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                options:kNilOptions
                                                                                                                  error:&jsonError];
                                                               
                                                               
                                                               NSLog(@"array is ====%@",array);
                                                               
                                                               
                                                               /*
                                                                array is ===={
                                                                data =     {
                                                                ErrorId = 114;
                                                                ErrorMessage = "Story has been submitted successfully.";
                                                                };
                                                                header =     {
                                                                DeviceId = "<null>";
                                                                UserId = 0;
                                                                };
                                                                }
                                                                */
                                                               
                                                              // [layer removeFromSuperlayer];
                                                               NSString *strId = [NSString stringWithFormat:@"%@",[[array valueForKey:@"data"]valueForKey:@"ErrorId"]];
                                                               
                                                             //  NSMutableArray *arrTesting=[[NSMutableArray alloc]init];
                                                               
                                                               
                                                               
                                                               
                                                               if ([strId isEqualToString:@"114"]) {
                                                                   
                                                                   
                                                                   
                                                                   NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                                                                   [dateFormatter setDateFormat:@"dd/MM/yyyy"];
                                                                   NSString *date=[dateFormatter stringFromDate:[NSDate date]];
                                                                   
                                                                   NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                                   [formatter setDateFormat:@"hh:mm a"];
                                                                   NSString *time=[formatter stringFromDate:[NSDate date]];
                                                                   
//                                                                   NSLog(@"Current Date: %@", [formatter stringFromDate:[NSDate date]]);
                                                                   
                                                                   if([app.myFinalArray count]==0){
                                                                       
                                                                       app.myFinalArray=[[NSMutableArray alloc]init];
                                                                       
                                                                   }else{
                                                                       
                                                                       //do Nothing
                                                                       
                                                                   }
                                                                   
                                                                   textDataDictionary=[NSMutableDictionary dictionary];
                                                                   
                                                                   [textDataDictionary setValue:[lbl_output_category.text uppercaseString] forKey:@"CategoryName"];
                                                                   [textDataDictionary setValue:txt_Title.text forKey:@"Title"];
                                                                   [textDataDictionary setValue:txt_View.text forKey:@"FullStory"];
                                                                   [textDataDictionary setValue:@"TEXT" forKey:@"Type"];
                                                                   [textDataDictionary setValue:date forKey:@"Date"];
                                                                   [textDataDictionary setValue:time forKey:@"Time"];
                                                                   
                                                                   
                                                                   if([app.myFinalArray count]<15){
                                                                       
                                                                       [app.myFinalArray addObject:textDataDictionary];
                                                                   }
                                                                   else{
                                                                       [app.myFinalArray removeObjectAtIndex:0];
                                                                   }
                                                                   

                                                                   [[NSUserDefaults standardUserDefaults]setValue:app.myFinalArray forKey:@"MyArray"];
                                                                   NSLog(@"array length======%lu",[app.myFinalArray count]);
                                                                  // [[NSUserDefaults standardUserDefaults]synchronize];
                                                                   
                                                                   
                                                                   
                                                                   
                                                                   
                                                                   NSLog(@"My Array is ===== %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"MyArray"]);
                                                                   
                                                                   
//                                                                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",[[array valueForKey:@"data"] valueForKey:@"ErrorMessage"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                                                   [alert show];
                                                                   
                                                                   ok_For_Success_Outlet.tag=1;
                                                                   
                                                                   CGSize size = [[UIScreen mainScreen]bounds].size;
                                                                   
                                                                   if (size.height==480) {
                                                                       [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"success3.5.png"]];
                                                                       UIButton *btnUpload=[[UIButton alloc]initWithFrame:CGRectMake(102.0, 318.0, 115.0, 38.0)];
                                                                       [btnUpload setImage:[UIImage imageNamed:@"btn_ip5.png"] forState:UIControlStateNormal];
                                                                       [btnUpload addTarget:self action:@selector(btn_Success_Tapped:) forControlEvents:UIControlEventTouchUpInside];

                                                                       [img_ForSuccess_Unsuccess addSubview:btnUpload];
                                                                       
                                                                   }else{
                                                                  //     [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"success.png"]];
                                                                       
                                                                       
                                                                       [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"success.png"]];
                                                                       UIButton *btnUpload=[[UIButton alloc]initWithFrame:CGRectMake(103.0, 385.0, 115.0, 38.0)];
                                                                       [btnUpload setImage:[UIImage imageNamed:@"btn_ip5.png"] forState:UIControlStateNormal];
                                                                       [btnUpload addTarget:self action:@selector(btn_Success_Tapped:) forControlEvents:UIControlEventTouchUpInside];

                                                                       [img_ForSuccess_Unsuccess addSubview:btnUpload];
                                                                   }
                                                                   [self.view addSubview:self.view_ForSuccess_Unsuccess];
                                                                   
                                                                   
                                                               }else{
                                                                   
                                                                   
                                                                   ok_For_Success_Outlet.tag=2;
                                                                   
                                                                   
                                                                   CGSize size = [[UIScreen mainScreen]bounds].size;
                                                                   
                                                                   if (size.height==480) {
                                                                    //   [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess3.5.png"]];
                                                                       
                                                                       [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess3.5.png"]];
                                                                       UIButton *btnUpload=[[UIButton alloc]initWithFrame:CGRectMake(102.0, 299.0, 115.0, 38.0)];
                                                                       [btnUpload setImage:[UIImage imageNamed:@"btn_ip5.png"] forState:UIControlStateNormal];
                                                                       [btnUpload addTarget:self action:@selector(btn_Success_Tapped:) forControlEvents:UIControlEventTouchUpInside];

                                                                       [img_ForSuccess_Unsuccess addSubview:btnUpload];

                                                                       
                                                                   }else{
                                                                       [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess.png"]];
                                                                       UIButton *btnUpload=[[UIButton alloc]initWithFrame:CGRectMake(103.0, 345.0, 115.0, 38.0)];
                                                                       [btnUpload setImage:[UIImage imageNamed:@"btn_ip5.png"] forState:UIControlStateNormal];
                                                                       [btnUpload addTarget:self action:@selector(btn_Success_Tapped:) forControlEvents:UIControlEventTouchUpInside];

                                                                       [img_ForSuccess_Unsuccess addSubview:btnUpload];
                                                                   }
                                                                   
                                                                   [self.view addSubview:self.view_ForSuccess_Unsuccess];
                                                                   
                                                                   /*
                                                                   try_AgainInternet_Check = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                                                                   [try_AgainInternet_Check show]; */

                                                                   
                                                               }

                                                               
                                                           }else {
                                                               /*

                                                               try_AgainInternet_Check = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                                                               [try_AgainInternet_Check show]; */
                                                               
                                                               ok_For_Success_Outlet.tag=2;
                                                               CGSize size = [[UIScreen mainScreen]bounds].size;
                                                               
                                                               if (size.height==480) {
//                                                                   [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess3.5.png"]];
                                                                   
                                                                   [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess3.5.png"]];
                                                                   UIButton *btnUpload=[[UIButton alloc]initWithFrame:CGRectMake(102.0, 299.0, 115.0, 38.0)];
                                                                   [btnUpload setImage:[UIImage imageNamed:@"btn_ip5.png"] forState:UIControlStateNormal];
                                                                   [btnUpload addTarget:self action:@selector(btn_Success_Tapped:) forControlEvents:UIControlEventTouchUpInside];

                                                                   [img_ForSuccess_Unsuccess addSubview:btnUpload];
                                                                   
                                                                   
                                                               }else{
                                                                //   [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess.png"]];
                                                                   [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess.png"]];
                                                                   UIButton *btnUpload=[[UIButton alloc]initWithFrame:CGRectMake(103.0, 345.0, 115.0, 38.0)];
                                                                   [btnUpload setImage:[UIImage imageNamed:@"btn_ip5.png"] forState:UIControlStateNormal];
                                                                   [btnUpload addTarget:self action:@selector(btn_Success_Tapped:) forControlEvents:UIControlEventTouchUpInside];

                                                                   [img_ForSuccess_Unsuccess addSubview:btnUpload];
                                                               }
                                                               
                                                               [self.view addSubview:self.view_ForSuccess_Unsuccess];
                                                               


                                                           }
                                                           
                                                       }];
    [dataTask resume];

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
    //textField.text=@"";
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
- (void)dismissControls
{
    
    [self.view  endEditing:YES]; //may be not required
}

#pragma mark -
#pragma mark ---------------               RESIGN KEYBOARD on touch Method                ---------------
#pragma mark -



#pragma mark -
#pragma mark ---------------               Text View on touch Method                ---------------
#pragma mark -
/*
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(txt_View.text.length == 0){
            txt_View.textColor = [UIColor lightGrayColor];
            // txt_View.text = @"Enter Comment Here";
            [txt_View resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}
*/
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)string{
    
    if(range.length + range.location > textView.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [txt_View.text length] + [string length] - range.length;
    return newLength <= 4000;
    
}



-(void) textViewDidChange:(UITextView *)textView
{
    if(txt_View.text.length == 0){
        txt_View.textColor = [UIColor lightGrayColor];
        // txt_View.text = @"Enter Comment Here";
        [txt_View resignFirstResponder];
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (txt_View.textColor == [UIColor lightGrayColor]) {
        // txt_View.text = @"";
        txt_View.textColor = [UIColor blackColor];
    }
    
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
	return TRUE;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //textField.text=@"";
	static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
	static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
	static const CGFloat MAXIMUM_SCROLL_FRACTION = 1.0;
	static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
	static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
	
	CGRect textFieldRect;
	CGRect viewRect;
	
	
	textFieldRect =[self.view.window convertRect:textView.bounds fromView:textView];
	viewRect =[self.view.window convertRect:self.view  .bounds fromView:self.view  ];
	
	
	CGFloat midline = textFieldRect.origin.y + 1.0 * textFieldRect.size.height;
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
	
	viewFrame= self.view  .frame;
	viewFrame.origin.y -= animatedDistance;
	
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	
	[self.view   setFrame:viewFrame];
	
	[UIView commitAnimations];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
	if(textView.tag==0)
	{
		static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
		CGRect viewFrame;
		
		viewFrame= self.view  .frame;
		viewFrame.origin.y += animatedDistance;
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationBeginsFromCurrentState:YES];
		[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
		
		
		[self.view   setFrame:viewFrame];
		[UIView commitAnimations];
        
    }
    
}

/////// text view delegate ends here!!!!!!


- (IBAction)cut_Selected_FileTapped:(id)sender {
}



# pragma Mark Use picker for ios 8 & 7 ..

-(void)CallMethodForPicker{
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    lbl_output_category .inputAccessoryView = toolbar;
    //AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [lbl_output_category setItemList:[NSArray arrayWithArray:[app.categoryNameArray objectAtIndex:0]]];
    
}

-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}



#pragma mark unused code ios 7.
/*
- (IBAction)btn_Selected_new_Category_Tapped:(id)sender {
    [self.view endEditing:YES];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    if ([app.categoryNameArray count]==0 || [app.id_CategoryArray count]==0) {
        
        // NSLog(@"quite empty!!!!");
        // [app getCategory];
        
        NSLog(@"coming!");
    }else{
    
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Choose Category" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:9];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [picker setTitlesForComponenets:[NSArray arrayWithArray:app.categoryNameArray]];
    [picker showInView:self.view];
        
        
    }

}

-(void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectTitles:(NSArray *)titles
{
    switch (pickerView.tag)
    {
        case 9: lbl_output_category.text=[titles componentsJoinedByString:@" - "];
            break;
            
        default:
            break;
    }
}

*/


- (IBAction)setting_Tappeed:(id)sender {
    
    Setting_Screen *setting=[[Setting_Screen alloc]initWithNibName:@"Setting_Screen" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];

}

-(void) btn_Success_Tapped:(id)sender{
    
    
    if (ok_For_Success_Outlet.tag==1) {
        
        // on successfull completion....
        txt_View.text=nil;
        txt_Title.text=nil;
        lbl_finalPicker_Selected.text=nil;
        lbl_output_category.text=@"Choose Category";
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else{
        // when failed!!!
        
        txt_View.text=nil;
        txt_Title.text=nil;
        lbl_finalPicker_Selected.text=nil;
        lbl_output_category.text=@"Choose Category";
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
    }
    
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
//    
//    if (range.length==1) {
//        return YES;
//    }
//    
//    if (textField ==txt_Title) {
//        
//        if ([txt_Title.text length]>=50) {
//            return NO;
//        }
//        
//    }
//    return YES;
    
    if (textField == txt_Title)
    {
        if(range.length + range.location > txt_Title.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [txt_Title.text length] + [string length] - range.length;
        return newLength <= 50;
        
    }else{
        
        return YES;
    }

    
}


@end
