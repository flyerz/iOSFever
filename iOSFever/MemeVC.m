//
//  MemeVC.m
//  iOSFever
//
//  Created by Andras Szivak on 2015. 04. 08..
//  Copyright (c) 2015. flyerz. All rights reserved.
//

#import "MemeVC.h"
#import "ImageFlip.h"
#import "MemeData.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AssetsLibrary/AssetsLibrary.h"

@interface MemeVC () <UIAlertViewDelegate>
//IBOutlets
@property (weak, nonatomic) IBOutlet UILabel *memeTitle;
@property (weak, nonatomic) IBOutlet UIImageView *memeImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

//data
@property (nonatomic, strong) NSArray* dataSource;
@property (nonatomic, strong) MemeData* currentMeme;
@end

@implementation MemeVC

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"MEMORY WARNING MemeVC");
    if ([self.view window] == nil)
    {
        self.dataSource = nil;
        self.view = nil;
    }
}

#pragma mark - Helper methods
-(void)loadImages {
    [self startBackgroundWork];
    [ImageFlip getMemesWithCompletition:^(BOOL success, ImgflipResponse *response, NSString *errorMesasge) {
        if (success) {
            if (response.data && [response.data isKindOfClass:[NSDictionary class]]) {
                NSArray* memeArray = [response.data jsonValueForKey:@"memes"];
                NSMutableArray* temp = [NSMutableArray new];
                for (NSDictionary* d in memeArray) {
                    [temp addObject:[[MemeData alloc] initWithJson:d]];
                }
                self.dataSource = [NSArray arrayWithArray:temp];
                [self nextMeme];
            }
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Alert!" message:errorMesasge delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        }
        [self stopBackgroundWork];
    }];
}

//disable userinteractions
-(void)startBackgroundWork
{
    [self.activityIndicator startAnimating];
    self.view.alpha = 0.7;
    self.view.userInteractionEnabled = NO;
    
}

//enable userinteractions
-(void)stopBackgroundWork
{
    [self.activityIndicator stopAnimating];
    self.view.alpha = 1;
    self.view.userInteractionEnabled = YES;
}

-(void)nextMeme {
   self.currentMeme = [self.dataSource objectAtIndex:arc4random() % self.dataSource.count];
}


-(void)updateUIWithMeme:(MemeData*)newMeme
{
    self.memeTitle.text = newMeme.name;
    [self.activityIndicator startAnimating];
    [self.memeImage sd_setImageWithURL:[NSURL URLWithString:newMeme.url] placeholderImage:nil options:SDWebImageDelayPlaceholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.activityIndicator stopAnimating];
        self.memeImage.image = image;
    }];
}

#pragma mark - Image save callback
- (void) image: (UIImage *)image didFinishSavingWithError: (NSError *)error contextInfo: (void *) contextInfo{
    [self stopBackgroundWork];
    [[[UIAlertView alloc] initWithTitle:@"Info" message:@"Image saved to Camera Roll" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

#pragma mark - setters
-(void)setCurrentMeme:(MemeData *)currentMeme
{
    _currentMeme = currentMeme;
    //if currentMeme changed, update the ui
    if (currentMeme) {
        [self updateUIWithMeme:_currentMeme];
    }
}

#pragma mark - UI Event handlers
- (IBAction)nextButtonClicked:(id)sender {
    [self nextMeme];
}

- (IBAction)saveButtonClicked:(id)sender {
    __weak MemeVC* weakSelf = self;
    
    if ([ALAssetsLibrary authorizationStatus] != ALAuthorizationStatusAuthorized) {
        [[[UIAlertView alloc] initWithTitle:@"Alert!" message:@"If you want to save, please enable this application in Settings->Privacy->Photos" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    } else {
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.currentMeme.url] options:SDWebImageContinueInBackground progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (error) {
                [[[UIAlertView alloc] initWithTitle:@"Alert!" message:@"Can't save image" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            } else {
                [self startBackgroundWork];
                UIImageWriteToSavedPhotosAlbum(image, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            }
        }];
    }
    
}

#pragma mark - UIAlertViewDelegate
-(void)alertViewCancel:(UIAlertView *)alertView
{
    [alertView removeFromSuperview];
}

@end
