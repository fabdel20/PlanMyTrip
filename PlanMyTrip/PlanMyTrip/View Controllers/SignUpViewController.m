//
//  SignUpViewController.m
//  PlanMyTrip
//
//  Created by Farida Abdelmoneum on 7/5/22.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"
@interface SignUpViewController ()
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UIDatePicker *BirthDate;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)signUpButton:(id)sender;

@end

@implementation SignUpViewController

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

- (IBAction)signUpButton:(id)sender {
    if([self.email.text isEqual:@""] || [self.password.text isEqual:@""] || [self.firstName.text isEqual:@""]|| [self.lastName.text isEqual:@""]){
            [self showAlert];
        }else{
            PFUser *newUser = [PFUser user];
            
            newUser.username = self.email.text;
            newUser.password = self.password.text;
            newUser.firstName = self.firstName.text;
            newUser.lastName = self.lastName.text;
            newUser.birthDay = self.BirthDate.date; 
            
            [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
                if(error != nil){
                }else{
                    [self performSegueWithIdentifier:@"signUpSegue" sender:nil];
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
