//
//  EventWebDetailsViewController.m
//  Meetup
//
//  Created by Dennis Dixon on 5/27/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "EventWebDetailsViewController.h"

@interface EventWebDetailsViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *eventWebDetailsWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

@end

@implementation EventWebDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *eventWebDetailsURL = [NSURL URLWithString:self.eventWebDetailsURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:eventWebDetailsURL];
    [self.eventWebDetailsWebView loadRequest:request];
    self.eventWebDetailsWebView.delegate = self;
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"in webViewDidStartLoad");
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicatorView startAnimating];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"in webViewDidFinishLoad");
    self.activityIndicatorView.hidden = YES;
    [self.activityIndicatorView stopAnimating];
}
- (IBAction)onGoForwardButtonPressed:(id)sender
{
    if ([self.eventWebDetailsWebView canGoForward])
        [self.eventWebDetailsWebView goForward];
}
- (IBAction)onGoBackButtonPressed:(id)sender
{
    if ([self.eventWebDetailsWebView canGoBack])
        [self.eventWebDetailsWebView goBack];


}

@end
