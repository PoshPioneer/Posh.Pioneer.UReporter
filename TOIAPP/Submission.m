//
//  Submission.m
//  TOIAPP
//
//  Created by Subodh Dharmwan on 25/11/15.
//  Copyright (c) 2015 CYNOTECK. All rights reserved.
//

#import "Submission.h"
#import "Setting_Screen.h"
#import "RecordAudioView.h"
#import "ReporterEntry.h"
#import "AppDelegate.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuickLook/QuickLook.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "FullDescription.h"
#import "PlayRecordedAudio.h"


@interface Submission (){
    AppDelegate *app;
   NSMutableArray *reverseArray;
    NSURL *yourFileURL;
    int i;
    QLPreviewController *previewController;
    UIImage *image;
    NSString *urlString;
    AVAudioPlayer *player;
    RecordAudioView *recordAudio;
    MPMoviePlayerController *controller;
    NSInteger rowCount;
    UIAlertView *alert;
    int tempTag;
    
    
    
    

}

@end

@implementation Submission
@synthesize myTable;
@synthesize lblMeassage;
#pragma mark - viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
   [myTable setSeparatorInset:UIEdgeInsetsZero];
    myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    myTable.opaque = YES;
    myTable.backgroundView = nil;
    myTable.backgroundColor=[UIColor clearColor];
    // Do any additional setup after loading the view from its nib.
    recordAudio=[[RecordAudioView alloc]init];
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    reverseArray=[[NSMutableArray alloc]init];
    reverseArray = [[[app.myFinalArray reverseObjectEnumerator]allObjects]mutableCopy];
  
    self.myTable.opaque=NO;
    
    previewController=[[QLPreviewController alloc]init];
    previewController.delegate=self;
    previewController.dataSource=self;
    
}


#pragma mark - viewWillAppear

-(void)viewWillAppear:(BOOL)animated{
    //[[app.myFinalArray reverseObjectEnumerator]allObjects];
    if ([app.myFinalArray count]==0) {
        lblMeassage.hidden=NO;
    } else{
    lblMeassage.hidden=YES;
    }
    [myTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView DataSources

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        
    if ([app.myFinalArray count]==0) {
        lblMeassage.hidden=NO;
    } else{
        
        lblMeassage.hidden=YES;
        }
        return [app.myFinalArray count];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellIdentityfier=@"cell";
    ReporterEntry *cell = (ReporterEntry *)[tableView dequeueReusableCellWithIdentifier:cellIdentityfier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReporterEntry" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    rowCount=indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lblCatgory.text=[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"CategoryName"];
        cell.lblTitle.text=[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"Title"];
        cell.lblFullStory.text=[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"FullStory"];
        cell.lblType.text=[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"Type"];
        cell.lblDate.text=[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"Date"];
        cell.lblTime.text=[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"Time"];
        [cell.btnDelete addTarget:self action:@selector(btnDataDelete:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnReadMore addTarget:self action:@selector(btnReadMore:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnReadMore.tag=indexPath.row;
        app.indexpath=cell.btnReadMore.tag;
        cell.btnDelete.tag = indexPath.row;
        cell.backgroundColor=[UIColor clearColor];
    
    return cell;
    }

#pragma mark - ReadMoreButton

-(void)btnReadMore:(id)sender{
    app.Title=[[reverseArray objectAtIndex:[sender tag]]valueForKey:@"Title"];
    app.Description=[[reverseArray objectAtIndex:[sender tag]]valueForKey:@"FullStory"];
    app.indexpath=[sender tag];
    CGSize size = [[UIScreen mainScreen]bounds].size;
    
    if (size.height==480) {
        
        FullDescription *fulldes=[[FullDescription alloc]initWithNibName:@"FullDescription3.5" bundle:nil];
        [self.navigationController pushViewController:fulldes animated:YES];
        }else{
        FullDescription *fullDescription=[[FullDescription alloc]initWithNibName:@"FullDescription" bundle:nil];
        [self.navigationController pushViewController:fullDescription animated:YES];
        }
     }


#pragma mark - deleteButton

-(void)btnDataDelete:(id)sender{
    
    alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Are you sure you want to delete this record?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];

    [alert show];
    tempTag = (int)[sender tag];


}
#pragma mark - AlertViewDelegates

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==0) {
        //do Nothing
    } else if (buttonIndex==1){
    
        [reverseArray removeObjectAtIndex:tempTag];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MyArray"];
        
        [app.myFinalArray removeAllObjects];
        
        for(NSDictionary *d in reverseArray){
                        [app.myFinalArray addObject:d];
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:[[app.myFinalArray objectEnumerator]allObjects] forKey:@"MyArray"];
        [[[app.myFinalArray reverseObjectEnumerator]allObjects]mutableCopy];
        [myTable reloadData];
      }
}

#pragma mark - TableViewDelegates

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if([[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"Type"] isEqualToString:@"PHOTO" ])
    {
       urlString=[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"imagePath"] ;
       image =  [[UIImage alloc] initWithContentsOfFile:urlString];
       [previewController reloadData];
       [self presentViewController:previewController animated:YES completion:nil];
       [previewController.navigationItem setRightBarButtonItem:nil];
    }else if([[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"Type"] isEqualToString:@"VIDEO"]){
        
        NSURL *videoURL=[NSURL fileURLWithPath:[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"videoPath"]];
        controller = [[MPMoviePlayerController alloc]
                                               initWithContentURL:videoURL];
        self.mc = controller;
        controller.view.frame = self.view.bounds;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MPMoviePlayerDidExitFullscreen:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
        [self.view addSubview:controller.view]; //Show the view
        [controller play]; //Start playing
        
        } else if([[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"Type"] isEqualToString:@"AUDIO"]){
        
        
        CGSize size = [[UIScreen mainScreen]bounds].size;
        if (size.height==480) {
            
            app.yourFileURL = [NSURL URLWithString:[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"AudioPath"]];
            PlayRecordedAudio *playObj=[[PlayRecordedAudio alloc]initWithNibName:@"PlayRecordedAudio3.5" bundle:nil];
            [self.navigationController pushViewController:playObj animated:YES];
            
        } else{
            
            app.yourFileURL = [NSURL URLWithString:[[reverseArray objectAtIndex:indexPath.row]valueForKey:@"AudioPath"]];
            
            PlayRecordedAudio *playObj=[[PlayRecordedAudio alloc]initWithNibName:@"PlayRecordedAudio" bundle:nil];
            
            [self.navigationController pushViewController:playObj animated:YES];
            
            }
    }
    }
#pragma mark - MPMoviePlayer Stop

- (void)MPMoviePlayerDidExitFullscreen:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerDidExitFullscreenNotification
                                                  object:nil];
    
    [controller stop];
    [controller.view removeFromSuperview];
}


#pragma mark - QLPreviewControlerDelegates

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{

    return  1;
    
    
}
- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    
   
    if (urlString.length == 0){
        urlString = @"";
    }
    NSURL *url=[NSURL fileURLWithPath:urlString];
    return url;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - BackButton
- (IBAction)btnBackTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
