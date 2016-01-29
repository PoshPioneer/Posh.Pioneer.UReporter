//
//  UploadAudioView.m
//  TOIAPP
//
//  Created by amit bahuguna on 7/29/14.
//  Copyright (c) 2014 CYNOTECK. All rights reserved.
//

#import "UploadAudioView.h"
#import "RecordAudioView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "IQActionSheetPickerView.h"
#import "Setting_Screen.h"
#import "KeyChainValteck.h"
#import <QuartzCore/QuartzCore.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface UploadAudioView ()//<IQActionSheetPickerViewDelegate>
{
    
    NSURLSessionUploadTask *task;
    NSMutableData *responseData;
   RecordAudioView *recordAudio;

}

@end

@implementation UploadAudioView
@synthesize audioDataDictionary;           //New changes
@synthesize with_Address_Optional_Written;
@synthesize img_ForSuccess_Unsuccess,view_ForSuccess_Unsuccess,ok_For_Success_Outlet;
@synthesize txt_Title,txt_View;
@synthesize circular_Progress_View;
@synthesize written_Address;
@synthesize cut_Sec,lbl_AddStory_Outlet,lbl_finalPicker_Selected,lbl_Select_new_Category,lbl_selected_File_Outlet,lbl_Title,image_AddStory_Outlet,image_Select_NewCategory,image_Title_Outlet,img_View_Selected_File_Outlet,btn_Reset_Outlet,btn_Selected_new_Category_Outlet,btn_Upload_Outlet;
@synthesize capture_Audio_Outlet;
@synthesize isItFirstService,responseDataForRestOfTheDetailService;
@synthesize isPickerTapped;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)checkCategoryData {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
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

    
  recordAudio=[[RecordAudioView alloc]init];
    audioDataDictionary=[NSMutableDictionary dictionary];
    [lbl_output_category setUserInteractionEnabled:NO];
    timerCheck = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkCategoryData) userInfo:nil repeats:YES];

    
    lbl_finalPicker_Selected.textColor=[UIColor grayColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(callNotification) name:@"doChangeForIt" object:nil];

}

-(void)viewWillAppear:(BOOL)animated{
    
   // [self checkForInternetConnection];
    [self.view setNeedsLayout];
    
}

-(void)viewDidLayoutSubviews{
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (app.recordedData==nil ) {
        
    }
    else{
        [[NSUserDefaults standardUserDefaults]setValue:@"taken" forKeyPath:@"Audio_Check"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        lbl_selected_File_Outlet.text=@"Recorded audio";
        lbl_finalPicker_Selected.text = app.uniqueNameForLableAudio;
        
        
      }
    
    if (isPickerTapped) {
        
        isPickerTapped=NO;
        
        if (app.recordedData==nil) {
            [self doItResize:@"hide"];
            NSLog(@"audio file  is yet to be  taken!");
            
        }
    }else{
        
        NSString *server = [[NSUserDefaults standardUserDefaults]stringForKey:@"Audio_Check"];
        if (!server) {
            [self doItResize:@"hide"];
            NSLog(@"audio  is yet to be  taken!");
            
        }else{
            
            if (finalCheckForServiceBool) {
                
                // do nothing .....
           
            
            }else{
                
            //  when audio has been taken.....
                [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Audio_Check"];
                [[NSUserDefaults standardUserDefaults]synchronize];
            NSLog(@"audio has been taken!");
            // [self doItResize:@"show"];
            [lbl_selected_File_Outlet setHidden:NO];
            [img_View_Selected_File_Outlet setHidden:NO];
            [lbl_finalPicker_Selected setHidden:NO];
            [cut_Sec setHidden:NO];
                
           // lbl_finalPicker_Selected.text=[self  generateUniqueName];
            }

        }
        
    }
  
}

-(void)doItResize:(NSString *)hideAndShow{
    
    int  increment_Decrement=0;
    
    NSString *hide_Show = hideAndShow;
    
    if ([hide_Show isEqualToString:@"show"]) {
        
        increment_Decrement=+56;
        NSLog(@"it is second time ....");
        [lbl_selected_File_Outlet setHidden:NO];
        [img_View_Selected_File_Outlet setHidden:NO];
        [lbl_finalPicker_Selected setHidden:NO];
        [cut_Sec setHidden:NO];
        
    }else{
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        app.recordedData=nil;
        app.uniqueNameForLableAudio=nil;
        lbl_finalPicker_Selected.text=nil;
        
        increment_Decrement=-56;
        [lbl_selected_File_Outlet setHidden:YES];
        [img_View_Selected_File_Outlet setHidden:YES];
        [lbl_finalPicker_Selected setHidden:YES];
        [cut_Sec setHidden:YES];
        
    }
    
    [image_Select_NewCategory setFrame: CGRectMake(image_Select_NewCategory.frame.origin.x, image_Select_NewCategory.frame.origin.y+increment_Decrement, image_Select_NewCategory.frame.size.width, image_Select_NewCategory.frame.size.height)];
    
    [image_Title_Outlet setFrame:CGRectMake(image_Title_Outlet.frame.origin.x, image_Title_Outlet.frame.origin.y+increment_Decrement, image_Title_Outlet.frame.size.width, image_Title_Outlet.frame.size.height)];
    
    [image_AddStory_Outlet setFrame:CGRectMake(image_AddStory_Outlet.frame.origin.x, image_AddStory_Outlet.frame.origin.y+increment_Decrement, image_AddStory_Outlet.frame.size.width, image_AddStory_Outlet.frame.size.height)];
    
    [btn_Reset_Outlet setFrame:CGRectMake(btn_Reset_Outlet.frame.origin.x, btn_Reset_Outlet.frame.origin.y+increment_Decrement, btn_Reset_Outlet.frame.size.width, btn_Reset_Outlet.frame.size.height)];
    
    [btn_Upload_Outlet setFrame:CGRectMake(btn_Upload_Outlet.frame.origin.x, btn_Upload_Outlet.frame.origin.y+increment_Decrement, btn_Upload_Outlet.frame.size.width, btn_Upload_Outlet.frame.size.height)];
    
    [lbl_AddStory_Outlet setFrame:CGRectMake(lbl_AddStory_Outlet.frame.origin.x, lbl_AddStory_Outlet.frame.origin.y+increment_Decrement, lbl_AddStory_Outlet.frame.size.width, lbl_AddStory_Outlet.frame.size.height)];
    
    [lbl_Title setFrame:CGRectMake(lbl_Title.frame.origin.x, lbl_Title.frame.origin.y+increment_Decrement, lbl_Title.frame.size.width, lbl_Title.frame.size.height)];
    
    [lbl_output_category setFrame:CGRectMake(lbl_output_category.frame.origin.x, lbl_output_category.frame.origin.y+increment_Decrement, lbl_output_category.frame.size.width, lbl_output_category.frame.size.height)];
    
    [btn_Selected_new_Category_Outlet setFrame:CGRectMake(btn_Selected_new_Category_Outlet.frame.origin.x, btn_Selected_new_Category_Outlet.frame.origin.y+increment_Decrement, btn_Selected_new_Category_Outlet.frame.size.width, btn_Selected_new_Category_Outlet.frame.size.height)];
    
    [lbl_Select_new_Category setFrame:CGRectMake(lbl_Select_new_Category.frame.origin.x, lbl_Select_new_Category.frame.origin.y+increment_Decrement, lbl_Select_new_Category.frame.size.width, lbl_Select_new_Category.frame.size.height)];
    
    [txt_View setFrame:CGRectMake(txt_View.frame.origin.x, txt_View.frame.origin.y+increment_Decrement, txt_View.frame.size.width, txt_View.frame.size.height)];
    
    
    [txt_Title setFrame:CGRectMake(txt_Title.frame.origin.x, txt_Title.frame.origin.y+increment_Decrement, txt_Title.frame.size.width, txt_Title.frame.size.height)];
    
    /////
    [cut_Sec setFrame:CGRectMake(cut_Sec.frame.origin.x, cut_Sec.frame.origin.y+increment_Decrement, cut_Sec.frame.size.width, cut_Sec.frame.size.height)];
    [img_View_Selected_File_Outlet setFrame:CGRectMake(img_View_Selected_File_Outlet.frame.origin.x, img_View_Selected_File_Outlet.frame.origin.y+increment_Decrement, img_View_Selected_File_Outlet.frame.size.width, img_View_Selected_File_Outlet.frame.size.height)];
    
    [lbl_selected_File_Outlet setFrame:CGRectMake(lbl_selected_File_Outlet.frame.origin.x, lbl_selected_File_Outlet.frame.origin.y+increment_Decrement, lbl_selected_File_Outlet.frame.size.width, lbl_selected_File_Outlet.frame.size.height)];
    [lbl_finalPicker_Selected setFrame:CGRectMake(lbl_finalPicker_Selected.frame.origin.x, lbl_finalPicker_Selected.frame.origin.y+increment_Decrement, lbl_finalPicker_Selected.frame.size.width, lbl_finalPicker_Selected.frame.size.height)];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back_Tapped:(id)sender {
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if ([lbl_output_category.text length]>0 ||  app.recordedData !=nil  || [txt_Title.text length]>0 || [txt_View.text length]>0) {
        
        goBackAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Are you sure you want to cancel this news submission?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [goBackAlert show];
        
    }else{
        
        AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        txt_View.text=nil;
        txt_Title.text=nil;
        lbl_finalPicker_Selected.text=nil;
        lbl_output_category.text=@"Choose Category";
        app.recordedData=nil;
        app.uniqueNameForLableAudio=nil;
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Audio_Check"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (IBAction)capture_audio_tapped:(id)sender{
    
    //isBrowserTapped=YES;
    AppDelegate *app =(AppDelegate *)[UIApplication sharedApplication].delegate;
    app.recordedData=nil;
     [self doItResize:@"hide"];
    RecordAudioView *recordview=[[RecordAudioView alloc]initWithNibName:@"RecordAudioView" bundle:Nil];
    [self presentViewController:recordview animated:NO completion:nil];
    
    
}
- (IBAction)reset_Tapped:(id)sender {
    
    AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    txt_View.text=nil;
    txt_Title.text=nil;
    lbl_finalPicker_Selected.text=nil;
    lbl_output_category.text=nil;
    app.recordedData=nil;
    app.uniqueNameForLableAudio=nil;
    
    if (IS_OS_8_OR_LATER) {
        
    }
    else{
        
        [self doItResize:@"hide"];
    }
   // cutboolValue = YES;
    [self.view setNeedsLayout];
    
}

- (IBAction)upload_Tapped:(id)sender {
    
    [self.view endEditing:YES];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    NSString *server = [[NSUserDefaults standardUserDefaults]stringForKey:@"connection_Internet"];
    
    if ([server isEqualToString:@"reachable"]) {
    
    
    NSString *alert_Message;
    if ([lbl_finalPicker_Selected.text length]==0 || [lbl_output_category.text length]==0 || [txt_Title.text length]==0 || [txt_View.text  length]==0 || app.recordedData ==nil) {
                            
        if ([lbl_finalPicker_Selected.text length]==0 || app.recordedData==nil) {
                                
                                alert_Message=@"Please select a file";
                }else if ([lbl_output_category.text length]==0){
                                
                                alert_Message=@"Please select a category";
                }else if ([txt_Title.text length]==0){
                                
                                alert_Message=@"Please enter a title";
                }else if ([txt_View.text length]==0){
                                
                                alert_Message = @"Please enter a story";
                }
                            
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:alert_Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
    
    if (alertView==without_Address) {

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

            [self  sendAudio_ToServer];
 //       }
        
        
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
            [self  sendAudio_ToServer];

            NSLog(@"seocnd one ");
            NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
            
            //  [with_Address dismissWithClickedButtonIndex:2 animated:YES];
            
            
        }
        
    }else if (alertView ==goBackAlert){
        
        if (buttonIndex==0) {
            
            // do nothing....
            //cancel tapped..
            
            
        }else if (buttonIndex==1){
            
            AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
            txt_View.text=nil;
            txt_Title.text=nil;
            lbl_finalPicker_Selected.text=nil;
            lbl_output_category.text=@"Choose Category";
            app.recordedData=nil;
            app.uniqueNameForLableAudio=nil;
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Audio_Check"];
            [[NSUserDefaults standardUserDefaults]synchronize];

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
            
            if (isItFirstService==1) {
                
                // for first service ....
                // ok tapped Try Again....
                NSLog(@"OK_Tapped");
                
                [self  sendAudio_ToServer];
                
                
                
            }else{
                // for second service ...
                // ok tapped Try Again....
                NSLog(@"OK_Tapped");
                [self  sendRestOfTheTextDATA:responseDataForRestOfTheDetailService];
                
            }
            
        }
        
    }
    
    
    
}


-(void)sendAudio_ToServer{
    //////for gradient......
    
    finalCheckForServiceBool=YES;
    layer = [CAGradientLayer layer];
    layer.frame = self.view.bounds;
    UIColor *blackColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
    UIColor *clearColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
    layer.colors = [NSArray arrayWithObjects:(id)clearColor.CGColor, (id)blackColor.CGColor, nil];
    [self.view.layer insertSublayer:layer atIndex:1];

    // hiding !!!!!
    ///////////////////////////////////////////
    //////////////////////////////////////////
    // looping all subviews except circular view for showing progress...
    
    for (UIView *subview in self.view.subviews)
    {
        
        if ([subview isEqual:circular_Progress_View]) {
            
            subview.hidden=NO;
            // do nothing .
        }else{
            
            subview.hidden = YES;
            
        }
        
        
    }
    ///////////////////////////////////////
    ///////////////////////////////////////
    
    //////for gradient.......
    [self.view setAlpha:0.4];
    [self.view setUserInteractionEnabled:NO];
    self.circular_Progress_View.frame = CGRectMake(71, 197, 175, 135);
    [self.view addSubview:self.circular_Progress_View];
    self.circular_Progress_View.thicknessRatio = 0.111111;
    self.circular_Progress_View.outerBackgroundColor=[UIColor lightGrayColor];
    self.circular_Progress_View.innerBackgroundColor=[UIColor lightGrayColor];

    self.circular_Progress_View.progressFillColor=[UIColor redColor];

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    
    //timesgroupcrapi  http://timesgroupcrapi.cloudapp.net/api/UserDet
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://timesgroupcrapi.cloudapp.net/api/blobs?id=%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"userID_Default"]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:300];

    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    //    NSData *imageData = UIImageJPEGRepresentation(mainImage, 1.0);
    //
    NSString *boundary = @"unique-consistent-ssssssss";
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    //    // add params (all params are strings)
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n", @"imageCaption"] dataUsingEncoding:NSUTF8StringEncoding]];
    //    [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"Some Caption"] dataUsingEncoding:NSUTF8StringEncoding]];
    //
    // add image data
   // audioData = [[NSData alloc] initWithContentsOfFile:[_audioRecorder.url path]];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.recordedData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n", @"imageFormKey",lbl_finalPicker_Selected.text] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:app.recordedData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    //    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    task = [session uploadTaskWithStreamedRequest:request];

    
    [task resume];
    
    
    
}

//// DELEGATE METHODS FOR NSURLSESSION

//// delegate methods

#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"%lld %lld %lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
    
    [lbl_selected_File_Outlet setHidden:YES];
    [img_View_Selected_File_Outlet setHidden:YES];
    [lbl_finalPicker_Selected setHidden:YES];
    [cut_Sec setHidden:YES];
        
    if (totalBytesExpectedToSend==totalBytesSent) {
        
    }
    
    float progress = (double)totalBytesSent / (double)totalBytesExpectedToSend;
    
    dispatch_async(dispatch_get_main_queue(), ^{


        self.circular_Progress_View.progress = progress;
        
    });

    
    }

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream *bodyStream))completionHandler
{
    // completionHandler(self.inputStream);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"%s: error = %@; data = %@", __PRETTY_FUNCTION__, error, [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.circular_Progress_View removeFromSuperview];
        [self.view setAlpha:1];
        [self.view setUserInteractionEnabled:YES];
       // [layer removeFromSuperlayer];

        
        if (error==nil) {
            
            NSLog(@"successfully submitted");
            
            
            
            responseDataForRestOfTheDetailService =[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            [self sendRestOfTheTextDATA:[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]];
            

        }else{
            
            NSLog(@"error available!");
            // [self   sendVideo_ToServer];
            isItFirstService=1;
            
            try_AgainInternet_Check = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
            [try_AgainInternet_Check show];
            
//            ok_For_Success_Outlet.tag=2;
//            CGSize size = [[UIScreen mainScreen]bounds].size;
//            
//            if (size.height==480) {
//                [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess3.5.png"]];
//                
//                
//            }else{
//                [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess.png"]];
//            }
//            
//            [self.view addSubview:self.view_ForSuccess_Unsuccess];
            
        }
        
        
    });

}


#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    
    responseData = [NSMutableData data];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

/////////
-(void)sendRestOfTheTextDATA:(NSString *)Id_BlobFromService{
    
    __block  NSString *categoryId_String;
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [ [app.categoryNameArray objectAtIndex:0] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        
        NSString *campareStr = [NSString stringWithFormat:@"%@",[[app.categoryNameArray objectAtIndex:0]objectAtIndex:idx]];
        if ([campareStr isEqualToString:lbl_output_category.text]) {
            
            categoryId_String = [NSString stringWithFormat:@"%@",[[app.id_CategoryArray objectAtIndex:0]objectAtIndex:idx]];
            
        }
        
    }];
    
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    
    //timesgroupcrapi   http://timesgroupcrapi.cloudapp.net/api/UserDet
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
    [dictionaryTemp setValue:@"3" forKey:@"Id_MainCategory"];
    [dictionaryTemp setValue:Id_BlobFromService forKey:@"Id_Blob"];
    
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
    
    NSLog(@" value of addres is ======%@",[dictionaryTemp valueForKey:@"LocationDetails"]);
    
    [finalDictionary setObject:headerDict forKey:@"header"];
    [finalDictionary setValue:dictionaryTemp forKey:@"data"];
    
    
    NSLog(@"Request ON Audio ===%@",finalDictionary);
    
    
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

    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"Response:%@ %@\n", response, error);
                                                           if(error == nil)
                                                           {
//                                                               NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
//                                                               NSLog(@"final audio o/p is  ==== %@",text);
                                                               
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
                                                               
                                                               NSString *strId = [NSString stringWithFormat:@"%@",[[array valueForKey:@"data"]valueForKey:@"ErrorId"]];
                                                               
                                                               if ([strId isEqualToString:@"114"]) {
                                                                   
//                                                                   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",[[array valueForKey:@"data"] valueForKey:@"ErrorMessage"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                                                                   [alert show];
                                                                   NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                                                                   [dateFormatter setDateFormat:@"dd/MM/yyyy"];
                                                                   NSString *date=[dateFormatter stringFromDate:[NSDate date]];
                                                                   
                                                                   
                                                                   
                                                                   NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                                   [formatter setDateFormat:@"hh:mm a"];
                                                                   NSString *time=[formatter stringFromDate:[NSDate date]];
                                                                   NSLog(@"Time is ======%@",time);
                                                                   
                                                                   
                                                                   
                                                                   if([app.myFinalArray count]==0){
                                                                       
                                                                       app.myFinalArray=[[NSMutableArray alloc]init];
                                                                       
                                                                   }else{
                                                                       
                                                                       //do Nothing
                                                                       
                                                                   }
                                                                   
                                                                
                                                                   
                                                                   [audioDataDictionary setValue:[lbl_output_category.text uppercaseString] forKey:@"CategoryName"];
                                                                   [audioDataDictionary setValue:txt_Title.text forKey:@"Title"];
                                                                   [audioDataDictionary setValue:txt_View.text forKey:@"FullStory"];
                                                                   [audioDataDictionary setValue:@"AUDIO" forKey:@"Type"];
                                                                   
                                                                   [audioDataDictionary setValue:date forKey:@"Date"];
                                                                   [audioDataDictionary setValue:time forKey:@"Time"];
                                                                   [audioDataDictionary setObject:app.soundFilePathData forKey:@"AudioPath"];
                                                                   NSLog(@"audioDataDictionary=====%@",audioDataDictionary);
                                                                   NSLog(@"audioUrl is=========%@",app.soundFilePathData);
                                                                   
                                                                   
                                                                   NSLog(@"AudiodataDictionary======%@",audioDataDictionary);
                                                                
                                                                   
                                                                   if([app.myFinalArray count]<15){
                                                                       
                                                                       [app.myFinalArray addObject:audioDataDictionary];
                                                                   }
                                                                   else{
                                                                       [app.myFinalArray removeObjectAtIndex:0];
                                                                   }
                                                                   
                                                                   
                                                                   [[NSUserDefaults standardUserDefaults]setValue:app.myFinalArray forKey:@"MyArray"];
                                                                   // [[NSUserDefaults standardUserDefaults]synchronize];
                                                                   
                                                                   
                                                                   
                                                                   
                                                                   
                                                                   NSLog(@"My Array is ===== %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"MyArray"]);
                                                                   
                                                                   ok_For_Success_Outlet.tag=1;
                                                                   
                                                                   CGSize size = [[UIScreen mainScreen]bounds].size;
                                                                   
                                                                   if (size.height==480) {
                                                                       [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"success3.5.png"]];
                                                                       UIButton *btnUpload=[[UIButton alloc]initWithFrame:CGRectMake(102.0, 318.0, 115.0, 38.0)];
                                                                       [btnUpload setImage:[UIImage imageNamed:@"btn_ip5.png"] forState:UIControlStateNormal];
                                                                       [btnUpload addTarget:self action:@selector(btn_Success_Tapped:) forControlEvents:UIControlEventTouchUpInside];
                                                                       
                                                                       [img_ForSuccess_Unsuccess addSubview:btnUpload];
                                                                       
                                                                   }else{
                                                                       [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"success.png"]];
                                                                       UIButton *btnUpload=[[UIButton alloc]initWithFrame:CGRectMake(103.0, 385.0, 115.0, 38.0)];
                                                                       [btnUpload setImage:[UIImage imageNamed:@"btn_ip5.png"] forState:UIControlStateNormal];
                                                                       [btnUpload addTarget:self action:@selector(btn_Success_Tapped:) forControlEvents:UIControlEventTouchUpInside];
                                                                       
                                                                       [img_ForSuccess_Unsuccess addSubview:btnUpload];
                                                                   }
                                                                   [self.view addSubview:self.view_ForSuccess_Unsuccess];
                                                                   

                                                                   
                                                                   
                                                               }else{
                                                                   
                                                                   
                                                                   /*
                                                                   ok_For_Success_Outlet.tag=2;
                                                                   CGSize size = [[UIScreen mainScreen]bounds].size;
                                                                   
                                                                   if (size.height==480) {
                                                                       [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess3.5.png"]];
                                                                       
                                                                       
                                                                   }else{
                                                                       [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess.png"]];
                                                                   }
                                                                   
                                                                   [self.view addSubview:self.view_ForSuccess_Unsuccess];
                                                                    
                                                                    */
                                                                   
                                                                   isItFirstService=2;
                                                                   try_AgainInternet_Check = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                                                                   [try_AgainInternet_Check show];
                                                              
                                                               }
                                                               
                                                               
                                                               
                                                           }else {
                                                
                                                               // if not successfull............
                                                               isItFirstService=2;
                                                               try_AgainInternet_Check = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                                                               [try_AgainInternet_Check show];
                                                               
                                                               
                                                               /*
                                                               
                                                               ok_For_Success_Outlet.tag=2;
                                                               CGSize size = [[UIScreen mainScreen]bounds].size;
                                                               
                                                               if (size.height==480) {
                                                                   [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess3.5.png"]];
                                                                   
                                                                   
                                                               }else{
                                                                   [img_ForSuccess_Unsuccess setImage:[UIImage imageNamed:@"unsuccess.png"]];
                                                               }
                                                               
                                                               [self.view addSubview:self.view_ForSuccess_Unsuccess];
                                                                
                                                                */

                                                               

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
    
     AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self doItResize:@"hide"];
     app.recordedData=nil;
    lbl_finalPicker_Selected.text=nil;
    app.uniqueNameForLableAudio=nil;
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
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [lbl_output_category setItemList:[NSArray arrayWithArray:[app.categoryNameArray objectAtIndex:0]]];
    
    
}

-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
}



#pragma mark unused code ios 7.
/*
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

- (IBAction)btn_Selected_new_Category_Tapped:(id)sender {
    
    [self.view endEditing:YES];
    
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
        if ([app.categoryNameArray count]==0 || [app.id_CategoryArray count]==0) {
    
           // NSLog(@"quite empty!!!!");
            // [app getCategory];
            
            NSLog(@"coming!");
        }else{
    
    
    isPickerTapped=YES;
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:@"Choose Category" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    [picker setTag:9];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [picker setTitlesForComponenets:[NSArray arrayWithArray:app.categoryNameArray]];
    [picker showInView:self.view];
            
        }
    
}

*/


- (IBAction)setting_Tapped:(id)sender {
    
    Setting_Screen *setting=[[Setting_Screen alloc]initWithNibName:@"Setting_Screen" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];

}


-(void)callNotification{
    
    if (ok_For_Success_Outlet.tag==1) {
        
        // on successfull completion....
        AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        txt_View.text=nil;
        txt_Title.text=nil;
        lbl_finalPicker_Selected.text=nil;
        lbl_output_category.text=@"Choose Category";
        app.recordedData=nil;
        app.uniqueNameForLableAudio=nil;
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Audio_Check"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else{
        // when failed!!!
        
        AppDelegate *app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        txt_View.text=nil;
        txt_Title.text=nil;
        lbl_finalPicker_Selected.text=nil;
        lbl_output_category.text=@"Choose Category";
        app.recordedData=nil;
        app.uniqueNameForLableAudio=nil;
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Audio_Check"];
        [[NSUserDefaults standardUserDefaults]synchronize];

        
        [self.navigationController popViewControllerAnimated:YES];
        
    }

    
}


- (void)btn_Success_Tapped:(id)sender {
  
    [[NSNotificationCenter defaultCenter]postNotificationName:@"doChangeForIt" object:nil];
    
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
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
