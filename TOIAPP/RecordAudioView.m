//
//  RecordAudioView.m
//  TOIAPP
//
//  Created by amit bahuguna on 7/29/14.
//  Copyright (c) 2014 CYNOTECK. All rights reserved.


#import "RecordAudioView.h"
#import "UploadAudioView.h"
#import "AppDelegate.h"
#import "Setting_Screen.h"

NSString *letterForAudio = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";


@interface RecordAudioView (){

    NSMutableString * soundFilePath;
  

}

@end

@implementation RecordAudioView
@synthesize disable_EnableBack_Outlet;
@synthesize cut_Sec,lbl_finalPicker_Selected,lbl_record_outlet,lbl_selected_File_Outlet;
@synthesize play_Audio_Outlet,start_End_Recording_Outlet;
@synthesize back_To_Home_Outlet,cancel_OnSelected_File_Outlet,img_Outlet;
@synthesize record_Timer_Outlet;
@synthesize timer,timerCountInt;
@synthesize audioPlayer,audioRecorder;
@synthesize finalDoneTimer;
@synthesize final_Time_Recording;
@synthesize uploadupppar_Lbl_outlet,setting_Outlet;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}


-(void)viewDidLayoutSubviews{
    
    CGSize size = [[UIScreen mainScreen]bounds].size;
    
    
    if (size.height==480) {
        
        NSLog(@"i am being called!");
        disable_EnableBack_Outlet.frame=CGRectMake(16, 27, 54, 21);
        uploadupppar_Lbl_outlet.frame = CGRectMake(101, 27, 118, 21);
        setting_Outlet.frame          = CGRectMake(279, 27, 21, 21);
        
    }else{
        
        
        // do nothing....
    }
    
}
-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letterForAudio characterAtIndex: arc4random_uniform([letterForAudio length])]];
    }
    
    return randomString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    NSArray *dirPaths;
    NSString *docsDir;
    AppDelegate *app=[[UIApplication sharedApplication]delegate];
    
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
   // NSString *fileName = [NSString stringWithFormat:@"%@",[self randomStringWithLength:8]];
    
    NSString *fileName = [NSString stringWithFormat:@"%@.caf",[self randomStringWithLength:8]];

    app.soundFilePathData = [docsDir stringByAppendingPathComponent:fileName];

    
    NSURL *soundFileURL = [NSURL fileURLWithPath:app.soundFilePathData];
    //AppDelegate * app1=(AppDelegate*)[UIApplication sharedApplication].delegate;
    app.soundFilePathData=[NSMutableString stringWithString:app.soundFilePathData];
    NSLog(@"the sound file data is %@",app.soundFilePathData);
    
    
    NSLog(@"audioFileURL==%@",soundFileURL);
    
    NSDictionary *recordSettings = [NSDictionary
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16],
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2],
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0],
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                        error:nil];
    
    audioRecorder = [[AVAudioRecorder alloc]
                      initWithURL:soundFileURL
                      settings:recordSettings
                      error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [audioRecorder prepareToRecord];
    }
}



-(void)viewWillAppear:(BOOL)animated{
    
   
   
    timerCountInt=0;
    [back_To_Home_Outlet setHidden:YES];
    [play_Audio_Outlet setHidden:YES];
    [lbl_finalPicker_Selected setHidden:YES];
    [cancel_OnSelected_File_Outlet setHidden:YES];
    [img_Outlet setHidden:YES];
    lbl_selected_File_Outlet.text=@"Capture audio";
    
}

-(void)myViewWillAppear
{
 
    

    [timer invalidate];
    [finalDoneTimer invalidate];
    [audioPlayer stop];
    checkForPlay=NO;
    timerCountInt=0;
    [back_To_Home_Outlet setHidden:YES];
    [play_Audio_Outlet setHidden:YES];
    [lbl_finalPicker_Selected setHidden:YES];
    [cancel_OnSelected_File_Outlet setHidden:YES];
    [img_Outlet setHidden:YES];
    lbl_selected_File_Outlet.text=@"Capture audio";

}

-(void)viewWillLayoutSubviews{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (IBAction)back_Tapped:(id)sender {
    [audioPlayer stop];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.uniqueNameForLableAudio=lbl_finalPicker_Selected.text;
    timerCountInt=0;

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back_audio_view_btn:(id)sender {
    [audioPlayer stop];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.uniqueNameForLableAudio=lbl_finalPicker_Selected.text;
    timerCountInt=0;

    
    [self  dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancel_onSelected_File_Tapped:(id)sender {
    
    [audioPlayer stop];
//    [timer invalidate];
//    [finalDoneTimer invalidate];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    timerCountInt=0;
    app.recordedData=nil;
    app.uniqueNameForLableAudio=nil;
    lbl_finalPicker_Selected.text=nil;
    record_Timer_Outlet.text=nil;
    lbl_selected_File_Outlet.text=@"Capture audio";
    [play_Audio_Outlet setHidden:YES];
    [back_To_Home_Outlet setHidden:YES];
    [start_End_Recording_Outlet setHidden:NO];
    [lbl_finalPicker_Selected setHidden:YES];
    [cancel_OnSelected_File_Outlet setHidden:YES];
    [start_End_Recording_Outlet setBackgroundImage:[UIImage imageNamed:@"audio_start_btn.png"] forState:UIControlStateNormal];
    [img_Outlet setHidden:YES];
    //[self.view setNeedsDisplay];
    [self myViewWillAppear];

}

- (IBAction)record_audio_btn:(id)sender {
    

    [self stopRecording_Method];
}


-(void)stopRecording_Method{
    
   // [play_Audio_Outlet setEnabled:YES];// chang by sub

    // for recording and stop audio ------
    if (checkForPlay==YES) {
       // checkForPlay=NO;
        [audioPlayer stop];
        record_Timer_Outlet.text=@"00:00";
        [finalDoneTimer invalidate];
        timerCountInt=0;
        
    }else{
    if (check) {
        
        // stop recording !!!!!!!
        //[play_Audio_Outlet setEnabled:YES];
        [disable_EnableBack_Outlet setUserInteractionEnabled:YES];
        
        [start_End_Recording_Outlet setBackgroundImage:[UIImage imageNamed:@"audio_start_btn.png"] forState:UIControlStateNormal];
        check=NO;
        [back_To_Home_Outlet setHidden:NO];
        [play_Audio_Outlet setHidden:NO];
        [lbl_finalPicker_Selected setHidden:NO];
        [cancel_OnSelected_File_Outlet setHidden:NO];
        [img_Outlet setHidden:NO];
        [timer invalidate];
        lbl_finalPicker_Selected.text = [self generateUniqueName];
        lbl_selected_File_Outlet.text=@"Recorded audio";
        timerCountInt=0;
        [start_End_Recording_Outlet setHidden:YES];
        
        if (audioRecorder.recording)
        {
            [audioRecorder stop];
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            app.recordedData =  [[NSData alloc] initWithContentsOfFile:[audioRecorder.url path]];
            
            
        } else if (audioPlayer.playing) {
            [audioPlayer stop];
        }
        
      //  [play_Audio_Outlet setEnabled:YES];
        
    }else{
        
        //audio_start_btn.png

        // start recording !!!!!!!!!
        [disable_EnableBack_Outlet setUserInteractionEnabled:NO];
        [start_End_Recording_Outlet setBackgroundImage:[UIImage imageNamed:@"audio_stop_btn.png"] forState:UIControlStateNormal];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setTimeforLable) userInfo:nil repeats:YES];
        check=YES;
      // lbl_selected_File_Outlet.text=nil;
        
        if (!audioRecorder.recording)
        {
            [audioRecorder record];
        }
        
    }

    
    }
}


- (IBAction)play_audio_btn:(id)sender {
    
    //[play_Audio_Outlet setUserInteractionEnabled:NO];
    NSLog(@"Play clicked");
    
    if([audioPlayer isPlaying]){
        
        
        [audioPlayer stop];
        [play_Audio_Outlet setBackgroundImage:[UIImage imageNamed:@"audio_recording_play.png"] forState:UIControlStateNormal];
        [finalDoneTimer invalidate];
        finalTime=record_Timer_Outlet.text;
        timerCountInt=0;
        record_Timer_Outlet.text=@"00:00";
        
        
    }
    else{
        [play_Audio_Outlet setBackgroundImage:[UIImage imageNamed:@"audio_stop_btn.png"] forState:UIControlStateNormal];
        //start_End_Recording_Outlet.hidden=NO;
        [start_End_Recording_Outlet setBackgroundImage:[UIImage imageNamed:@"audio_stop_btn.png"] forState:UIControlStateNormal];
        checkForPlay=YES;
        final_Time_Recording=record_Timer_Outlet.text;
        record_Timer_Outlet.text=nil;
        finalDoneTimer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(check_FinalTime) userInfo:nil repeats:YES];
        
        if (!audioRecorder.recording)
        {
            
            NSError *error;
            
            audioPlayer = [[AVAudioPlayer alloc]
                           initWithContentsOfURL:audioRecorder.url
                           error:&error];
            
            audioPlayer.delegate = self;
            
            if (error)
                NSLog(@"Error: %@",
                      [error localizedDescription]);
            else
                [audioPlayer play];
        }
        
        
    }
}


-(void)check_FinalTime{
    
   // [play_Audio_Outlet setEnabled:NO];    // by subodh......+
    if ([final_Time_Recording isEqualToString:record_Timer_Outlet.text]) {
        [finalDoneTimer invalidate];
    }else{
    
    timerCountInt+=1;
    int seconds = timerCountInt % 60;
    int minutes = (timerCountInt - seconds) / 60;
    if (minutes<=9) {
        record_Timer_Outlet.text = [NSString stringWithFormat:@"0%d:%.2d", minutes, seconds];
        
    }else{
        
        record_Timer_Outlet.text = [NSString stringWithFormat:@"%d:%.2d", minutes, seconds];
    }

    }
    
}

-(void)setTimeforLable{
    
    
    if ([record_Timer_Outlet.text isEqualToString:@"10:00"]) {
        [self stopRecording_Method];
        [timer invalidate];
    
    }else{
    
        
    timerCountInt+=1;
    int seconds = timerCountInt % 60;
    int minutes = (timerCountInt - seconds) / 60;
    if (minutes<=9) {
        record_Timer_Outlet.text = [NSString stringWithFormat:@"0%d:%.2d", minutes, seconds];
       // timerCountInt=timerCountInt-1;
    }else{
        
        record_Timer_Outlet.text = [NSString stringWithFormat:@"%d:%.2d", minutes, seconds];
       // timerCountInt=timerCountInt-1;
    }
        
    }

}

- (IBAction)cut_Selected_FileTapped:(id)sender {
    
}


-(NSString *)generateUniqueName
{
    
  //  NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
  //  NSString *finalUnique= [NSString stringWithFormat:@"Audio_%.0f.Wav", time];
    
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyyMMdd_HHmmss"];
        NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
//        int randomValue = arc4random() % 1000;
//        NSString *unique = [NSString stringWithFormat:@"%@%d",dateString,randomValue];
        NSString *finalUnique = [NSString stringWithFormat:@"Audio_%@.wav",dateString];
   
        return finalUnique;
    
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    
//    [dateFormatter setDateFormat:@"yyMMddHHmmss"];
//    
//    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
//    
//    int randomValue = arc4random() % 1000;
//    
//    NSString *unique = [NSString stringWithFormat:@"%@%d",dateString,randomValue];
//    NSString *finalUnique = [NSString stringWithFormat:@"%@.avi",unique];
    
}

//// DELEGATE METHODS

-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [play_Audio_Outlet setUserInteractionEnabled:YES];

     [finalDoneTimer invalidate];
    finalTime=record_Timer_Outlet.text;
    timerCountInt=0;
    //[play_Audio_Outlet setEnabled:NO];
    [play_Audio_Outlet setBackgroundImage:[UIImage imageNamed:@"audio_recording_play.png"] forState:UIControlStateNormal];

}

-(void)audioPlayerDecodeErrorDidOccur:
(AVAudioPlayer *)player
                                error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}

-(void)audioRecorderDidFinishRecording:
(AVAudioRecorder *)recorder
                          successfully:(BOOL)flag
{
    NSLog(@"Stopped");
}

-(void)audioRecorderEncodeErrorDidOccur:
(AVAudioRecorder *)recorder
                                  error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}


- (IBAction)setting_Tapped:(id)sender {
    
    Setting_Screen *setting=[[Setting_Screen alloc]initWithNibName:@"Setting_Screen" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];

    
    
}
@end
