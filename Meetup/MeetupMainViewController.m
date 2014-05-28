//
//  ViewController.m
//  Meetup
//
//  Created by Dennis Dixon on 5/27/14.
//  Copyright (c) 2014 Appivot LLC. All rights reserved.
//

#import "MeetupMainViewController.h"
#import "EventDetailViewController.h"

#define kDefaultMeetupBaseURL @"https://api.meetup.com/2/open_events.json?zip=60604&time=,1w&key=3f76761132c39691b755436a18573&text=mobile"

@interface MeetupMainViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSDictionary *meetupDictionary;
@property (strong, nonatomic) NSArray *resultsArray;
@property (weak, nonatomic) IBOutlet UITableView *meetupTableView;
@property (strong, nonatomic) NSDictionary *currentVenueSetDictionary;
@property (weak, nonatomic) IBOutlet UITextField *meetupSearchTextField;

@end

@implementation MeetupMainViewController


#pragma mark - UIViewController Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadMeetupResultsWithURLString:kDefaultMeetupBaseURL andTopicSearchString:nil];
}



#pragma mark - IBAction Methods

- (IBAction)onMeetupSearchButtonPressed:(id)sender
{
    if ([self.meetupSearchTextField.text length] > 0)
    {
        NSString *topicSearchParameterString = [NSString stringWithFormat:@"&text=%@",self.meetupSearchTextField.text];
        [self loadMeetupResultsWithURLString:kDefaultMeetupBaseURL andTopicSearchString:topicSearchParameterString];
        [self.meetupTableView reloadData];
    }
}



#pragma mark - UITableView Delegate Methods

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


#pragma mark - Storyboard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndexPath = [self.meetupTableView indexPathForSelectedRow];
    EventDetailViewController *eventDetailVC = segue.destinationViewController;
    eventDetailVC.eventDictionary = [self.resultsArray objectAtIndex:selectedIndexPath.row];
}

#pragma mark - Helper Methods

- (void)loadMeetupResultsWithURLString:(NSString *)meetupBaseURLString andTopicSearchString:(NSString *)topicSearchString
{
    NSString *currentURLString = (topicSearchString != nil) ?  [meetupBaseURLString stringByAppendingString:topicSearchString] : meetupBaseURLString;
    NSLog(@"currentURLString is %@",currentURLString);
    NSURL *currentURL = [NSURL URLWithString:currentURLString];

    NSError *error = [[NSError alloc] init];
    self.meetupDictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:currentURL] options:NSJSONReadingAllowFragments error:&error];

//    NSLog(@"meetupDictionary has %@",self.meetupDictionary);
    self.resultsArray = [self.meetupDictionary objectForKey:@"results"];
}


@end
