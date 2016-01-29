//
//  AppDelegate.h
//  TOIAPP
//
//  Created by CYNOTECK on 7/25/14.
//  Copyright (c) 2014 CYNOTECK. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>{
    
    
    UIImageView *m_SplashView;
    NSMutableArray *myFinalArray;

}

@property NSInteger indexpath;
@property (strong,nonatomic)NSString *Title,*Description;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong)NSString *putValueToKeyChain;
@property(nonatomic,strong)NSMutableArray *id_CategoryArray;
@property(nonatomic,strong)NSMutableArray *categoryNameArray;
@property(nonatomic,strong)NSData *recordedData ;
@property(strong,nonatomic)NSMutableString *soundFilePathData;

@property(nonatomic,strong)NSString *uniqueNameForLableAudio;
@property(nonatomic,strong)NSMutableData *responseData;

@property(strong,nonatomic)NSMutableArray *myFinalArray;      //New Changes

@property(strong,nonatomic)NSString *device_Token ;

-(void)getCategory;
@property(nonatomic,strong)NSURL *yourFileURL;

//@property(nonatomic,assign)int randomNumber;


@property(nonatomic,strong)NSString * randomNumber;

-(void)registerPushNotification_Method;


@property(nonatomic,strong) NSMutableArray * genderArr ;



-(void)showIt ;
-(void)hideIt;

@end
