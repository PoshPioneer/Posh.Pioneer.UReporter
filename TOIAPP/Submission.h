//
//  Submission.h
//  TOIAPP
//
//  Created by Subodh Dharmwan on 25/11/15.
//  Copyright (c) 2015 CYNOTECK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface Submission : UIViewController < UITableViewDelegate,UITableViewDataSource, QLPreviewControllerDelegate, QLPreviewControllerDataSource,UIDocumentInteractionControllerDelegate,AVAudioPlayerDelegate,UIAlertViewDelegate>{
    
    AVAudioPlayer *audioPlayer;
    MPMoviePlayerController *moviePlayer;
    
    
}
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@property (weak, nonatomic) IBOutlet UILabel *lblMeassage;

- (IBAction)btnBackTapped:(UIButton *)sender;
@property (nonatomic,strong) MPMoviePlayerController* mc;

@end
