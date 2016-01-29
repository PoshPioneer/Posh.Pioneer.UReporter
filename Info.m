//
//  Info.m
//  TOIAPP
//
//  Created by Valeteck on 12/08/14.
//  Copyright (c) 2014 CYNOTECK. All rights reserved.
//

#import "Info.h"
#import "Setting_Screen.h"
#import <QuartzCore/QuartzCore.h>
@interface Info ()

@end

@implementation Info
@synthesize web_View;
@synthesize txt_View;

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
    // Do any additional setup after loading the view from its nib.
    
    txt_View.layer.cornerRadius=2.0;
   [ txt_View setBackgroundColor:[UIColor clearColor]];
    [txt_View setEditable:NO];
    [txt_View setSelectable:NO];
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"info-2" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [web_View loadHTMLString:htmlString baseURL:nil];
    web_View.layer.cornerRadius=2.0;
    [web_View setBackgroundColor:[UIColor clearColor]];
    //[web_View setOpaque:NO];
    web_View.scrollView.layer.cornerRadius = 3.0;
    web_View.scrollView.layer.borderWidth = 0.15;
    web_View.scrollView.layer.borderColor=[UIColor grayColor].CGColor;


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back_Tapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)setting_Tapped:(id)sender {
    
     Setting_Screen *setting=[[Setting_Screen alloc]initWithNibName:@"Setting_Screen" bundle:nil];
     [self.navigationController pushViewController:setting animated:YES];

}

@end
