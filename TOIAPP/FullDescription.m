//
//  FullDescription.m
//  TOIAPP
//
//  Created by Subodh Dharmwan on 02/12/15.
//  Copyright (c) 2015 CYNOTECK. All rights reserved.
//

#import "FullDescription.h"
#import "AppDelegate.h"

@interface FullDescription (){

    AppDelegate *app;


}

@end

@implementation FullDescription
@synthesize txtDescription;
@synthesize lblTitle;

#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    app=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    lblTitle.text=app.Title;
    txtDescription.textColor = [UIColor colorWithRed:65.0/255.0 green:65.0/255.0 blue:65.0/255.0 alpha:1.0];
    txtDescription.text=app.Description;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IBActionBack

- (IBAction)btnBackTo_tapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
