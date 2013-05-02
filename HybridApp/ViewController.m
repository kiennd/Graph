//
//  ViewController.m
//  HybridApp
//
//  Created by techmaster on 1/18/13.
//  Copyright (c) 2013 TechMaster. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property (strong) AVPlayer* player;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *pathname = [[NSBundle mainBundle]  pathForResource:@"File" ofType:@"html" inDirectory:@"/"];
	NSString *htmlString = [NSString stringWithContentsOfFile:pathname encoding:NSUTF8StringEncoding error:nil];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    
    
    [self.webView loadHTMLString:htmlString baseURL:baseURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBack:(id)sender {
    //Before logic....
    [self.webView goBack];
    //After logic ....
}
- (IBAction)objCCallJS:(id)sender {
    [self.webView stringByEvaluatingJavaScriptFromString:@"show()"];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = request.URL;
    NSLog(@"scheme: %@", url.scheme);
    if ([url.scheme isEqualToString:@"techmaster"]) {
        NSLog(@"host: %@", url.host);
        NSLog(@"query: %@", url.query);
        
        if ([url.host isEqualToString:@"music.play"]) {
            NSArray *pairParameter = [url.query componentsSeparatedByString:@"="];
            if ([pairParameter[0] isEqualToString:@"file"]) {
                NSString *pathname = [[NSBundle mainBundle]  pathForResource:pairParameter[1] ofType:@""];
                
                NSLog(@"%@",pathname);
                NSURL* urlmp3 = [NSURL fileURLWithPath:pathname];
                _player =  [[AVPlayer alloc] initWithURL:urlmp3];
                [_player play];
            
            }
            
        }
        return NO;
    } else {
        return YES;
    }

}


//Cái này lấy trên mạng, cần kiểm tra cẩn thận

@end
