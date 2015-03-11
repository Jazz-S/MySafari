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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSURL *url = [NSURL URLWithString:textField.text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    return YES;
}


@end
