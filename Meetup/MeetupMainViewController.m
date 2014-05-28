//
//  ViewController.m
//  Meetup
//
//  Created by Dennis Dixon on 5/27/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "MeetupMainViewController.h"
#import "EventDetailViewController.h"

#define defaultMeetupURL @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=3f76761132c39691b755436a18573"

@interface MeetupMainViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSDictionary *meetupDictionary;
@property (strong, nonatomic) NSArray *resultsArray;
@property (weak, nonatomic) IBOutlet UITableView *meetupTableView;
@property (strong, nonatomic) NSDictionary *currentVenueSetDictionary;
@property (weak, nonatomic) IBOutlet UITextField *meetupSearchTextView;

@end

@implementation MeetupMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *currenttURL = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=3f76761132c39691b755436a18573"];

    NSError *error = [[NSError alloc] init];
    self.meetupDictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:defaultURL] options:NSJSONReadingAllowFragments error:&error];

    NSLog(@"meetupDictionary has %@",self.meetupDictionary);
    self.resultsArray = [self.meetupDictionary objectForKey:@"results"];

}

- (void)loadMeetupResultsWithURLString:(NSString *)meetupBaseURLString andTopicString:(NSString *)topicString
{

}


- (IBAction)onMeetupSearchButtonPressed:(id)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell"];
    self.currentVenueSetDictionary = [self.resultsArray objectAtIndex:indexPath.row];
    NSDictionary *curEventDictionary = [self.currentVenueSetDictionary objectForKey:@"venue"];

    cell.textLabel.text = [curEventDictionary objectForKey:@"name"];
    cell.detailTextLabel.text = [curEventDictionary objectForKey:@"address_1"];

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndexPath = [self.meetupTableView indexPathForSelectedRow];
    EventDetailViewController *eventDetailVC = segue.destinationViewController;
    eventDetailVC.eventDictionary = [self.resultsArray objectAtIndex:selectedIndexPath.row];
}


@end
