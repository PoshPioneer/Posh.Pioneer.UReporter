//
//  UploadPhoto.m
//  TOIAPP
//
//  Created by Valeteck on 29/07/14.
//  Copyright (c) 2014 CYNOTECK. All rights reserved.
//

#import "UploadPhoto.h"
#import "AppDelegate.h"
#import "IQActionSheetPickerView.h"
#import "Setting_Screen.h"
#import "KeyChainValteck.h"
//#import <AssetsLibrary/AssetsLibrary.h>
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";


@interface UploadPhoto ()//<IQActionSheetPickerViewDelegate>
{
NSURLSessionUploadTask *task;
NSMutableData *responseData;
    
    NSString *imagePath;
    NSString* localUrl;
    
   
}
@end
@implementation UploadPhoto


@synthesize photoDataDictionary;
@synthesize circular_Progress_View;
@synthesize segment_Outlet;
@synthesize txt_Title,txt_View;
@synthesize mainImage;
@synthesize written_Address;
@synthesize cut_Sec,lbl_AddStory_Outlet,lbl_finalPicker_Selected,lbl_Select_new_Category,lbl_selected_File_Outlet,lbl_Title,image_AddStory_Outlet,image_Select_NewCategory,image_Title_Outlet,img_View_Selected_File_Outlet,btn_Reset_Outlet,btn_Selected_new_Category_Outlet,btn_Upload_Outlet;
@synthesize alert_Message;
@synthesize progressView,responseDataForRestOfTheDetailService;
@synthesize ok_For_Success_Outlet;
@synthesize img_ForSuccess_Unsuccess,view_ForSuccess_Unsuccess,isItFirstService;
@synthesize with_Address_Optional_Written;
@synthesize handleView,lbl_output_category ,cutboolValue;

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

- (void)viewDidLoad{
    
    [super viewDidLoad];
    img_ForSuccess_Unsuccess.userInteractionEnabled = YES;

    photoDataDictionary=[NSMutableDictionary dictionary];
    
    [lbl_output_category setUserInteractionEnabled:NO];
    timerCheck = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkCategoryData) userInfo:nil repeats:YES];
    
    
    segment_Outlet.selectedSegmentIndex=-1;
    segment_Outlet.layer.cornerRadius=2.0;
	segment_Outlet.tintColor =[UIColor redColor];
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSLog(@"id's  are =====%@",app.id_CategoryArray);
    NSLog(@"names are =====%@",app.categoryNameArray);
    
}

-(void)viewWillAppear:(BOOL)animated{
    

    NSLog(@"viewwillAppear!!!!");
    segment_Outlet.tintColor =[UIColor colorWithRed:180.0/255.0 green:32.0/255.0 blue:33.0/255.0 alpha:1.0];
    
}


-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidLayoutSubviews{
    
    NSLog(@"viewDidLayoutSubviews called.");
    // 12 August code .
    
    if (!handleView)
    {
        // photo is not taken !!!!!
   
        NSLog(@"inside !handleView");
        [self doItResize:@"hide"];
        

    }else
    {
        // photo has been taken !!!!

                    if (cutboolValue) // when cut_Selected tapped!!!!!!
                    {
                        
                        NSLog(@"inside cutboolValue");
                        cutboolValue=NO ;
                        [self doItResize:@"hide"];
                        
                    }else if (mainImage==nil){ // when no image !!!!!!
                        
                        NSLog(@"inside mainImage==nil");
                        
                        if (isPickerTapped) {
                            
                            [self doItResize:@"hide"];
                        }
                        

                    }else{
                        
                        NSLog(@"inside else below mainImage==nil");

                        [lbl_selected_File_Outlet setHidden:NO];
                        [img_View_Selected_File_Outlet setHidden:NO];
                        [lbl_finalPicker_Selected setHidden:NO];
                        [cut_Sec setHidden:NO];
                        
                        
                        
                        if ([lbl_finalPicker_Selected.text length]==0) {
                            
                            lbl_finalPicker_Selected.text=[self  generateUniqueName];
                            
                        }
                        if (isCameraClicked) {
                            
                            if ([lbl_selected_File_Outlet.text length]==0) {
                                
                                lbl_selected_File_Outlet.text= @"Captured photo";
                            }
                            
                        }else{
                            if ([lbl_selected_File_Outlet.text length]==0) {
                                
                                lbl_selected_File_Outlet.text= @"Selected file";
                                
                            }
                        }
                        
                        
                    }


    }
    
    
    
    // 12 August code
    
    
        /*
    NSLog(@"handle view is = %i",handleView);
    
    //if (handleView) return ;
    
    NSLog(@"viewdidLayoutSubviews called.");
    
    if (isPickerTapped) {
        
        isPickerTapped=NO;
        
        if (mainImage==nil) {
            
            [self doItResize:@"hide"];
            NSLog(@"photo is yet to be  taken!");
            segment_Outlet.selectedSegmentIndex=-1;

        }
        
    }else{
        
        NSString *server = [[NSUserDefaults standardUserDefaults]stringForKey:@"Photo_Check"];
        
        if (!server) {
            
            if (handleView) return ;

            [self doItResize:@"hide"];
            NSLog(@"image is = %@",mainImage);
            NSLog(@"photo is yet to be  taken!!");
            //segment_Outlet.selectedSegmentIndex=-1;
            //   lbl_finalPicker_Selected.text=nil;
            
            ////////hiding //////////
            
            //        [lbl_selected_File_Outlet setHidden:YES];
            //        [img_View_Selected_File_Outlet setHidden:YES];
            //        [lbl_finalPicker_Selected setHidden:YES];
            //        [cut_Sec setHidden:YES];
            
            
        }else{
          //  segment_Outlet.selectedSegmentIndex=-1;
            
            //  when photo has been taken.....
            
            

           // if (handleView) return ;
            
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Photo_Check"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            NSLog(@"photo has been taken!");
            // [self doItResize:@"show"];
            [lbl_selected_File_Outlet setHidden:NO];
            [img_View_Selected_File_Outlet setHidden:NO];
            [lbl_finalPicker_Selected setHidden:NO];
            [cut_Sec setHidden:NO];
            
            lbl_finalPicker_Selected.text=[self  generateUniqueName];
            if (isCameraClicked) {
                lbl_selected_File_Outlet.text= @"Captured photo";
                
            }else{
                lbl_selected_File_Outlet.text= @"Selected file";
                
                
            }

            
        }

        
    }
     
     */
    
   
  }

-(void)doItResize:(NSString *)hideAndShow{
    
   // segment_Outlet.selectedSegmentIndex=-1;

    NSLog(@"doItResize called.");
    
    int  increment_Decrement=0;
    
    NSString *hide_Show = hideAndShow;
    
    if ([hide_Show isEqualToString:@"show"]) {
        
        increment_Decrement=+56;
        
        [lbl_selected_File_Outlet setHidden:NO];
        [img_View_Selected_File_Outlet setHidden:NO];
        [lbl_finalPicker_Selected setHidden:NO];
        [cut_Sec setHidden:NO];

        
    }else{
        lbl_finalPicker_Selected.text=nil;
        mainImage=nil;
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
    /////
    
   // [self.view setNeedsDisplay];

}



#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000

- (BOOL)prefersStatusBarHidden {
    return shouldHideStatusBar;
}

#endif

- (IBAction)segmentController_Handler:(id)sender {


//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
//
//    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [appDel hideIt];
//     shouldHideStatusBar = YES ;
//    [self prefersStatusBarHidden];
//    
//#endif
   
    if (IS_OS_8_OR_LATER) {   // code for ios 8 or above !!!!!!!!!

    ////////
        
        
        if ([sender selectedSegmentIndex]==0) {
            [self.view endEditing:YES];
            NSLog(@"capture photo tapped");
            
            isCameraClicked=YES;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
//            [self addChildViewController:picker];
//            [picker didMoveToParentViewController:self];
//            [self.view addSubview:picker.view];
            [self presentViewController:picker animated:YES completion:NULL];
 
            
        }else if ([sender selectedSegmentIndex]==1){
            
            [self.view endEditing:YES];
            NSLog(@"Browose Tapped");
            
            isCameraClicked=NO;
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
//            [self addChildViewController:picker];
//            [picker didMoveToParentViewController:self];
//            [self.view addSubview:picker.view];
            [self presentViewController:picker animated:YES completion:NULL];

        }
  
    ///////
    
    }else{
    
    if ([sender selectedSegmentIndex]==0) {
        
        NSLog(@"capture photo tapped");
        
        isCameraClicked=YES;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }else if ([sender selectedSegmentIndex]==1){
        
        NSLog(@"Browose Tapped");
        
        isCameraClicked=NO;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
      
        [self presentViewController:picker animated:YES completion:NULL];
       
    }
    
    }
    
}

-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}



#pragma mark - Image Picker Controller delegate methods   starts ...

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    mainImage = chosenImage;
//   localUrl = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
//    NSLog(@"imagepath==================== %@",localUrl);
    
    if(isCameraClicked)
    {
        UIImageWriteToSavedPhotosAlbum(mainImage,  nil,  nil, nil);
        
        
    }
    
    NSLog(@"image is ========%@",mainImage);
    
    NSLog(@"info==============%@",info);
    
    //New chamges
    
UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
//    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    
    
    NSString *documentsDirectory;
    for (int i=0; i<[pathArray count]; i++) {
        documentsDirectory =[pathArray objectAtIndex:i];
    }
    
    //Gaurav's logic
    
    NSLog(@"%lu",(unsigned long)[[[NSUserDefaults standardUserDefaults]objectForKey:@"MyArray"] count]);
    
   
   // NSString *myUniqueName = [NSString stringWithFormat:@"%@-%u", name, (NSUInteger)([[NSDate date] timeIntervalSince1970]*10.0)];

    //mohit logic
    
    NSString *fileName = [NSString stringWithFormat:@"%lu.png",(NSUInteger)([[NSDate date] timeIntervalSince1970]*10.0)];
    
    
    //
    
    
   // NSString *documentsDirectory = [pathArray objectAtIndex:0];
    
    localUrl =  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName];//[documentsDirectory stringByAppendingPathComponent:fileName];
    NSLog (@"File Path = %@", localUrl);
    
    // Get PNG data from following method
    NSData *myData =     UIImagePNGRepresentation(editedImage);
    // It is better to get JPEG data because jpeg data will store the location and other related information of image.
    [myData writeToFile:localUrl atomically:YES];
    
    // Now you can use filePath as path of your image. For retrieving the image back from the path
   // UIImage *imageFromFile = [UIImage imageWithContentsOfFile:filePath];
    
    
    [[NSUserDefaults standardUserDefaults]setValue:@"DonePhoto" forKey:@"Photo_Check"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //[picker dismissViewControllerAnimated:YES completion:NULL];
    
    handleView = YES ;
    
    
//    if (IS_OS_8_OR_LATER) {
//        [picker.view removeFromSuperview] ;
//        [picker removeFromParentViewController] ;
//        
//    }else{
    
        [picker dismissViewControllerAnimated:YES completion:nil];
    [self.view setNeedsLayout];
  //  }
   
    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
//
//     AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
//     [appDel showIt];
//     shouldHideStatusBar = NO;
//     [self prefersStatusBarHidden];
//    [self.view setNeedsLayout];
//    
//#endif
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    NSLog(@"cancel Tapped!");
   
    isPickerTapped = YES;
    segment_Outlet.selectedSegmentIndex=-1;
  
    
    
//    if (IS_OS_8_OR_LATER) {   // code for ios 8 or above !!!!!!!!!
//        
//        [picker.view removeFromSuperview] ;
//        [picker removeFromParentViewController] ;
//        
//    }else {
        [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.view setNeedsLayout];

//    }
    
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
//    
//     AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
//     [appDel showIt];
//     shouldHideStatusBar = NO;
//     [self prefersStatusBarHidden];
//    [self.view setNeedsLayout];
//
//#endif


    
}

#pragma mark - Image Picker Controller delegate methods   ends ...

- (IBAction)cut_Selected_FileTapped:(id)sender {
   
    cutboolValue = YES ;
    
    segment_Outlet.selectedSegmentIndex=-1;
//    mainImage=nil;
//    lbl_finalPicker_Selected.text=nil;

    //[self.view setNeedsDisplay];
    [self.view setNeedsLayout];

    
    
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

-(void)enableOff{
    
    [segment_Outlet setUserInteractionEnabled:NO];
    [cut_Sec setUserInteractionEnabled:NO];
    [lbl_output_category setUserInteractionEnabled:NO];
    [txt_Title setUserInteractionEnabled:NO];
    [txt_View setUserInteractionEnabled:NO];
}

-(void)doneClicked:(UIBarButtonItem*)button
{
    [self.view endEditing:YES];
    //isPickerTapped = NO ;
    
    [segment_Outlet setUserInteractionEnabled:YES];
    [cut_Sec setUserInteractionEnabled:YES];
    [lbl_output_category setUserInteractionEnabled:YES];
    [txt_Title setUserInteractionEnabled:YES];
    [txt_View setUserInteractionEnabled:YES];

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



- (IBAction)back_Tapped:(id)sender {
    
    if ([lbl_output_category.text length]>0 ||  mainImage !=nil  || [txt_Title.text length]>0 || [txt_View.text length]>0) {
        
        goBackAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Are you sure you want to cancel this news submission?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [goBackAlert show];
        
    
    }else{
        

        txt_View.text=nil;
        txt_Title.text=nil;
        lbl_finalPicker_Selected.text=nil;
        lbl_output_category.text=@"Choose Category";
         mainImage=nil;
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (IBAction)reset_Tapped:(id)sender {

        txt_View.text=nil;
        txt_Title.text=nil;
        lbl_finalPicker_Selected.text=nil;
        lbl_output_category.text=nil;
        mainImage=nil;
    
       segment_Outlet.selectedSegmentIndex=-1;
    
      if (IS_OS_8_OR_LATER) {
        //cutboolValue = YES;
      }
      else{
       
        [self doItResize:@"hide"];
       }
      cutboolValue = YES;
     [self.view setNeedsLayout];
    
    //  [self doItResize:@"hide"];
    
}

- (IBAction)upload_Tapped:(id)sender {
    
    [self.view endEditing:YES];
    
    NSString *server = [[NSUserDefaults standardUserDefaults]stringForKey:@"connection_Internet"];
    if ([server isEqualToString:@"reachable"]) {
    
    if ([lbl_finalPicker_Selected.text length]==0 || [lbl_output_category.text length]==0 || [txt_Title.text length]==0 || [txt_View.text  length]==0 || mainImage ==nil) {
        
        if ([lbl_finalPicker_Selected.text length]==0 || mainImage ==nil) {
            
            alert_Message=@"Please select a file";
        }else if ([lbl_output_category.text length ]==0){
            
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
            
            with_Address = [[UIAlertView alloc]initWithTitle:@"Your current location" message:[NSString stringWithFormat:@"%@\n\nIIf incorrect, please enter the location(city) for your news/story",checkStr] delegate:self cancelButtonTitle:@"Submit" otherButtonTitles:nil ,nil];
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
        
        [self  sendphoto_ToServer];
            
       // }
        
    }else if(alertView == without_Address){
        
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
            [self  sendphoto_ToServer];
            
            NSLog(@"seocnd one ");
            NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
            
            //  [with_Address dismissWithClickedButtonIndex:2 animated:YES];
            
        }
        
    }else if (alertView == goBackAlert){
        
        if (buttonIndex==0) {
            
            
            // do nothing ........
            // cancel tapped ...do nothing .....
            
        }else if(buttonIndex==1){
            
            
            txt_View.text=nil;
            txt_Title.text=nil;
            lbl_finalPicker_Selected.text=nil;
            lbl_output_category.text=@"Choose Category";
            mainImage=nil;
            
            
             [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Photo_Check"];
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
                [self  sendphoto_ToServer];
                
                
                
            }else{
                // for second service ...
                // ok tapped Try Again....
                NSLog(@"OK_Tapped");
                [self  sendRestOfThePhotoDATA:responseDataForRestOfTheDetailService];
                
            }
            
        }
   
    }

    
}

-(void)sendphoto_ToServer{
    // for gradient...........
    
    layer = [CAGradientLayer layer];
    layer.frame = self.view.bounds;
    UIColor *blackColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
    UIColor *clearColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
    
    // hiding !!!!!
    ///////////////////////////////////////////
    //////////////////////////////////////////
    // looping all subviews except circular view for showing progress...
    
    // working.
    
    [lbl_finalPicker_Selected removeFromSuperview];
    [cut_Sec removeFromSuperview];
    [img_View_Selected_File_Outlet removeFromSuperview];

    
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
    
    layer.colors = [NSArray arrayWithObjects:(id)clearColor.CGColor, (id)blackColor.CGColor, nil];
    [self.view.layer insertSublayer:layer atIndex:1];
    
    //for gradient.........

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
     
     NSData *imageData = UIImageJPEGRepresentation(mainImage, 1.0);
     
     NSString *boundary = @"unique-consistent-ssssssss";
     
     // set Content-Type in HTTP header
     NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
     [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
     
     // post body
     NSMutableData *body = [NSMutableData data];
     
     // add params (all params are strings)
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@\r\n\r\n", @"imageCaption"] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"%@\r\n", @"Some Caption"] dataUsingEncoding:NSUTF8StringEncoding]];
     
     // add image data
     if (imageData) {
     [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n", @"imageFormKey",lbl_finalPicker_Selected.text] dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
     [body appendData:imageData];
     [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
     }
    
     
     [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
     
     // setting the body of the post to the reqeust
     [request setHTTPBody:body];
     
     // set the content-length
     NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
     [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
     // NSData *postData = [NSJSONSerialization dataWithJSONObject:finalDictionary options:0 error:&error];
     //[request setHTTPBody:postData];
    
     task = [session uploadTaskWithStreamedRequest:request];
     [task resume];
     
    
}
#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"%lld %lld %lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
    
    if (totalBytesExpectedToSend==totalBytesSent) {
        
    }
    
    float progress = (double)totalBytesSent / (double)totalBytesExpectedToSend;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [progressView setHidden:NO];
        [self.progressView setProgress:progress];
        self.circular_Progress_View.progress = progress;
        
    });

}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task needNewBodyStream:(void (^)(NSInputStream *bodyStream))completionHandler
{
    // completionHandler(self.inputStream);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{

    
    
    NSLog(@"%s: error =========+++++ %@; data =========+++++ %@", __PRETTY_FUNCTION__, error, [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.circular_Progress_View removeFromSuperview];
        [self.view setAlpha:1];
        [self.view setUserInteractionEnabled:YES];
        //[layer removeFromSuperlayer];
        
        if (error==nil) {
            
            NSLog(@"successfully submitted");

            responseDataForRestOfTheDetailService =[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            [self sendRestOfThePhotoDATA:[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]];

            
        }else{
            
            //when not successfully submitted!!!!!
            
            NSLog(@"error available!");
            
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

-(void)sendRestOfThePhotoDATA:(NSString *)Id_BlobFromService{
    
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
    [dictionaryTemp setValue:@"2" forKey:@"Id_MainCategory"];
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

    NSLog(@" subodh value of addres is ======%@",[dictionaryTemp valueForKey:@"LocationDetails"]);
    
    [finalDictionary setObject:headerDict forKey:@"header"];
    [finalDictionary setValue:dictionaryTemp forKey:@"data"];
    
     NSLog(@"Request ON Photo ===%@",finalDictionary);
    
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
//                                                               NSLog(@"final photo o/p is  ==== %@",text);
                                                               
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
                                                                   
                                                                   NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
                                                                [dateFormatter setDateFormat:@"dd/MM/yyyy"];
                                                                   NSString *date=[dateFormatter stringFromDate:[NSDate date]];
//                                                                   NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
                                                                   
                                                                   NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                                   [formatter setDateFormat:@"hh:mm a"];
                                                                   NSString *time=[formatter stringFromDate:[NSDate date]];
                                                                   
                                                                   if([app.myFinalArray count]==0){
                                                                   
                                                                       app.myFinalArray=[[NSMutableArray alloc]init];
                                                                       
                                                                   }else{
                                                                   
                                                                       //do Nothing
                                                                   
                                                                   }
                                                                   
                                                                   
                                                                   
                                                                   
                                                                   
                                                                   [photoDataDictionary setValue:[lbl_output_category.text uppercaseString] forKey:@"CategoryName"];
                                                                   [photoDataDictionary setValue:txt_Title.text forKey:@"Title"];
                                                                   [photoDataDictionary setValue:txt_View.text forKey:@"FullStory"];
                                                                   [photoDataDictionary setValue:@"PHOTO" forKey:@"Type"] ;
                                                                   
                                                                   
                                                                   
                                                                   [photoDataDictionary setValue:[NSString stringWithFormat:@"%@",localUrl] forKey:@"imagePath"];
                                                                   [photoDataDictionary setValue: date forKey:@"Date"];
                                                                   [photoDataDictionary setValue:time forKey:@"Time"];
                                                                   
                                                                   if([app.myFinalArray count]<15){
                                                                   
                                                                   [app.myFinalArray addObject:photoDataDictionary];
                                                                   }
                                                                   else{
                                                                       [app.myFinalArray removeObjectAtIndex:0];
                                                                   }
                                                                   
                                                                   [[NSUserDefaults standardUserDefaults]setObject:app.myFinalArray forKey:@"MyArray"];
                                                                   [[NSUserDefaults standardUserDefaults]synchronize];
                                                                   
                                                                   
                                                                   NSLog(@"MyArray is ===== %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"MyArray"]);

                                                                   
                                                                   
//                                                                //   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:[NSString stringWithFormat:@"%@",[[array valueForKey:@"data"] valueForKey:@"ErrorMessage"]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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
                                                                   
                                                                   NSLog(@"gaurav kestwal");
                                                                   isItFirstService=2;
                                                                   try_AgainInternet_Check = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Internet connection is not available. Please try again." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                                                                   [try_AgainInternet_Check show];
                                                                   

                                                                   

                                                                   
                                                               }
                                                               
                                                               
                                                               
                                                           }else {
                                                               
                                                               // if not successfull............
                                                               NSLog(@"gaurav kestwal2");

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

-(NSString *)generateUniqueName{
    
  //  NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
   // NSString *finalUnique= [NSString stringWithFormat:@"Photo_%.0f.jpg", time];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd_HHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
   // int randomValue = arc4random() % 1000;
  //  NSString *unique = [NSString stringWithFormat:@"%@%d",dateString,randomValue];
    NSString *finalUnique = [NSString stringWithFormat:@"Photo_%@.jpg",dateString];
    return finalUnique;

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
    
    if (textField == lbl_output_category)
    {
        
        isPickerTapped= YES ;
        
    }
    
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



- (IBAction)setting_Tapped:(id)sender {
    
    Setting_Screen *setting=[[Setting_Screen alloc]initWithNibName:@"Setting_Screen" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];

    
    
}
- (void)btn_Success_Tapped:(id)sender {
    
    
    if (ok_For_Success_Outlet.tag==1) {
        
        // on successfull completion....
        txt_View.text=nil;
        txt_Title.text=nil;
        lbl_finalPicker_Selected.text=nil;
        lbl_output_category.text=@"Choose Category";
        mainImage=nil;
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else{
        // when failed!!!
        
        txt_View.text=nil;
        txt_Title.text=nil;
        lbl_finalPicker_Selected.text=nil;
        lbl_output_category.text=@"Choose Category";
        mainImage=nil;
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }
    
    
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
