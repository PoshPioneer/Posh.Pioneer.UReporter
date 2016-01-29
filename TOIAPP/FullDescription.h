//
//  FullDescription.h
//  TOIAPP
//
//  Created by Subodh Dharmwan on 02/12/15.
//  Copyright (c) 2015 CYNOTECK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FullDescription : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UITextView *txtDescription;

- (IBAction)btnBackTo_tapped:(id)sender;

@end
