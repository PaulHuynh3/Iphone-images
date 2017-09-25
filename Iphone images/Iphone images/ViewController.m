//
//  ViewController.m
//  Iphone images
//
//  Created by Paul on 2017-09-25.
//  Copyright © 2017 Paul. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"http://imgur.com/zdwdenZ.png"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    // this block of code is ran on another thread not main thread
    NSURLSessionDownloadTask  *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse * response, NSError * error) {
        
        if (error){
            NSLog(@"error: %@",error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        //putting information back on main thread.
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.imageView.image = image;
        }];
        
    }];
    
    //keep the downloadtask outside of the block
    [downloadTask resume];
 

}


@end
