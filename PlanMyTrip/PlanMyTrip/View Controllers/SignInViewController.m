//
//  SignInViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/5/22.
//

#import "SignInViewController.h"
#import "HomeViewController.h"
#import "Parse/Parse.h"
@import Foundation;

@interface SignInViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameOutput;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UITextField *passwordOutput;
- (IBAction)logInButton:(id)sender;
@property (strong, nonatomic) NSMutableDictionary *savedItins;
@property (strong, nonatomic) PFUser *localUser;
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)forgotPassword:(id)sender {
    UIAlertController *alertBox = [UIAlertController alertControllerWithTitle:@"Reset password" message:@"Please enter your email:" preferredStyle:(UIAlertControllerStyleAlert)];
    [alertBox addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Email";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertBox addAction:cancelAction];
    [alertBox addAction:[UIAlertAction actionWithTitle:@"Reset" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action){
        NSArray *textFields = alertBox.textFields;
        UITextField *text = textFields[0];
        [self resetPassword:text.text];
        [self pause];
    }]];
    
    [self presentViewController:alertBox animated:YES completion:nil];
}

- (void) resetPassword: (NSString *)email {
    NSString *emailLowerCase = [email lowercaseString];
    emailLowerCase = [emailLowerCase stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [PFUser requestPasswordResetForEmailInBackground:emailLowerCase block:^(BOOL succeeded, NSError * _Nullable error) {
        if(error == nil) {
            [self alertWithTitle:@"Success" message:@"Success! Check your email for further instructions. Please allow up to 5 minutes to receive your email."];
        } else {
            [self alertWithTitle:@"Error!" message:@"Could not complete request. Check that you put in correct email"];
        }
        [self unpause];
    }];
}

-(void) pause {
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.activityIndicator.center = self.view.center;
    self.activityIndicator.hidesWhenStopped = true;
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleMedium];
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.view setUserInteractionEnabled:NO];
}

-(void) unpause{
    [self.activityIndicator stopAnimating];
    [self.view setUserInteractionEnabled:YES];
}


//Method to create an alert on the login screen.
- (void) alertWithTitle: (NSString *)title message:(NSString *)text {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:^{
    }];
}

- (IBAction)logInButton:(id)sender {
    NSString *username = self.usernameOutput.text;
    NSString *password = self.passwordOutput.text;
        
    if([username isEqual:@""] || [password isEqual:@""]){
        [self showAlert];
    }else{
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError * error) {
            if(error != nil){
                [self showAlert];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.savedItins = user.savedItineraries;
                    self.localUser = user;
                    [self performSegueWithIdentifier:@"logInSegue" sender:nil];
                });
            }
        }];
        
    }
}


-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Field(s)" message:@"Enter a username and password" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:tryAgain];
    [self presentViewController:alert animated:YES completion:^{}];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HomeViewController *newView = [segue destinationViewController];
    newView.savedItineraries = self.savedItins;
    newView.userLocal = self.localUser;
}

@end
