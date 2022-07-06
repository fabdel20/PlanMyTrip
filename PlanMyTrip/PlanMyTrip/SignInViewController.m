//
//  SignInViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/5/22.
//

#import "SignInViewController.h"
#import "Parse/Parse.h"
@interface SignInViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameOutput;
@property (strong, nonatomic) IBOutlet UITextField *passwordOutput;
- (IBAction)logInButton:(id)sender;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
                [self performSegueWithIdentifier:@"logInSegue" sender:nil];
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
@end
