//
//  ViewController.m
//  MySafari
//
//  Created by Jazz Santiago on 3/11/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) CGFloat lastContentOffsetY;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (nonatomic) UIColor *defaultButtonColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndicator.hidesWhenStopped = YES;
    self.webView.scrollView.delegate = self;
    self.urlTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.urlTextField.placeholder = @"Please enter URL";
    self.defaultButtonColor = self.backButton.tintColor;
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

- (IBAction)onPlusButtonPressed:(UIButton *)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Coming soon!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSString *urlString = textField.text;
    if (urlString.length > 7) {
        if (![@"http://" isEqualToString:[urlString substringToIndex:7]]) {
            urlString = [@"http://" stringByAppendingString:urlString];
        }
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

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self.activityIndicator stopAnimating];
    NSString *message = [NSString stringWithFormat:@"Can't load %@",self.urlTextField.text];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
    [alertView show];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    self.urlTextField.text = webView.request.URL.absoluteString;
    self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (webView.canGoBack) {
        self.backButton.tintColor = self.defaultButtonColor;
    } else {
        self.backButton.tintColor = [UIColor lightGrayColor];
    }
    if (webView.canGoForward) {
        self.forwardButton.tintColor = self.defaultButtonColor;
    } else {
        self.forwardButton.tintColor = [UIColor lightGrayColor];
    }
}

#pragma mark -UIScrollViewDelegate protocols
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.lastContentOffsetY = scrollView.contentOffset.y;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.lastContentOffsetY < scrollView.contentOffset.y) {
        self.urlTextField.hidden = NO;
    } else if (self.lastContentOffsetY < scrollView.contentOffset.y) {
        self.urlTextField.hidden = YES;
    }
}




@end
