//
//  UploadView.h
//  TOIAPP
//
//  Created by CYNOTECK on 7/25/14.
//  Copyright (c) 2014 CYNOTECK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpinnerView.h"
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface UploadView : UIViewController<UIAlertViewDelegate,CLLocationManagerDelegate>{
    
    UIImageView *m_SplashView;
    SpinnerView *spinner;

    CLLocationManager *locationManager;
    
    
    

}

- (IBAction)Video_Tapped:(id)sender;
- (IBAction)Photo_Tapped:(id)sender;
- (IBAction)Audio_Tapped:(id)sender;
- (IBAction)Text_Tapped:(id)sender;

- (IBAction)setting_Tapped:(id)sender;
- (IBAction)i_ForContent_Tapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *iOutlet;
@property (nonatomic,strong) NSMutableDictionary *getData;
@property (nonatomic,strong) NSString *getOTP;
@property (nonatomic) float getTime;

@end
