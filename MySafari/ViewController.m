//
//  ViewController.m
//  MySafari
//
//  Created by Jazz Santiago on 3/11/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onBackButtonPressed:(id)sender
{

    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}
- (IBAction)onForwardButtonPressed:(id)sender
{
    [self.webView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(id)sender
{
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender
{
    [self.webView reload];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSURL *url = [NSURL URLWithString:textField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    return YES;
}

#pragma mark UIWebViewDelegate Protocols
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}
@end
