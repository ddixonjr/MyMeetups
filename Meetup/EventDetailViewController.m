//
//  VenueDetailViewController.m
//  Meetup
//
//  Created by Dennis Dixon on 5/27/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "EventDetailViewController.h"
#import "EventWebDetailsViewController.h"


@interface EventDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rsvpLabel;
@property (weak, nonatomic) IBOutlet UILabel *hostingGroupLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *webDetailsButton;

@end

@implementation EventDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDictionary *groupDictionary = [self.eventDictionary objectForKey:@"group"];

    self.title = [self.eventDictionary objectForKey:@"name"];
    self.rsvpLabel.text = [NSString stringWithFormat:@"%@",[self.eventDictionary objectForKey:@"yes_rsvp_count"]];
    self.descriptionLabel.text = [self.eventDictionary objectForKey:@"description"];
    self.hostingGroupLabel.text = [groupDictionary objectForKey:@"name"];

    self.webDetailsButton.hidden = ([self.eventDictionary objectForKey:@"event_url"] != nil) ? NO : YES;

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    EventWebDetailsViewController *eventWebDetailsVC = segue.destinationViewController;
    eventWebDetailsVC.eventWebDetailsURLString = [self.eventDictionary objectForKey:@"event_url"];
}

@end
