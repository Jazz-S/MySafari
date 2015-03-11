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
    self.activityIndicator.hidesWhenStopped = YES;
    
}

- (IBAction)onBackButtonPressed:(id)sender
{

    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
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
    
    NSString *urlString = textField.text;
    if (![@"http://" isEqualToString:[urlString substringToIndex:7]]) {
        urlString = [@"http://" stringByAppendingString:urlString];
    }
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    [textField resignFirstResponder];
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
