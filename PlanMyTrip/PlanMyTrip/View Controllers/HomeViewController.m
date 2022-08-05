//
//  HomeViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/6/22.
//

#import "HomeViewController.h"
#import "TripTypeViewController.h"
#import "Parse/Parse.h"

@interface HomeViewController ()
- (IBAction)planNewTrip:(id)sender;
@property (strong, nonatomic) NSArray *data;
@end

@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.savedItineraries != nil){
        for(id elem in self.savedItineraries){
            [self.data arrayByAddingObject:elem];
        }
        self.tableView.dataSource = self;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TripTableViewCell"];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TripTypeViewController *newView = [segue destinationViewController];
    newView.itinCount = self.itinCount;
    newView.savedItineraries = self.savedItineraries;
    newView.userLocal = self.userLocal;
}

- (IBAction)planNewTrip:(id)sender {
    [self performSegueWithIdentifier:@"homeToTripType" sender:sender];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripTableViewCell"];
    NSDictionary *trip = self.data[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}




@end
