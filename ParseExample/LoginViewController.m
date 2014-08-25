//
//  LoginViewController.m
//  ParseExample
//
//  Created by Nick Barrowclough on 8/9/13.
//  Copyright (c) 2013 Nicholas Barrowclough. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/*- (BOOL)prefersStatusBarHidden
{
    return YES;
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.tabBarController.tabBar.hidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self setHidesBottomBarWhenPushed:YES];
    
    _orLabel.hidden = NO;
    
    
    [PFUser logOut];
    NSLog(@"User has been logged out");
    
    //_view.backgroundColor = [UIColor colorWithRed:0.251 green:0.259 blue:0.267 alpha:1]; /*#404244*/
    
    _loginButton.backgroundColor = [UIColor colorWithRed:0.286 green:0.573 blue:0.749 alpha:1]; /*#4992bf*/
    //self.loginButton.layer.cornerRadius = 4.0f;
    
    _alreadyButton.backgroundColor = [UIColor colorWithRed:0.286 green:0.573 blue:0.749 alpha:1]; /*#4992bf*/
    //self.alreadyButton.layer.cornerRadius = 4.0f;
    
    _registerButton.backgroundColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1]; /*#63a599*/
    //self.registerButton.layer.cornerRadius = 4.0f;
    
    _registerUser.backgroundColor = [UIColor colorWithRed:0.388 green:0.647 blue:0.6 alpha:1]; /*#63a599*/
    //self.registerUser.layer.cornerRadius = 4.0f;
    
    _cancelButton.backgroundColor = [UIColor colorWithRed:0.635 green:0.18 blue:0.31 alpha:1]; /*#a22e4f*/
    //self.cancelButton.layer.cornerRadius = 4.0f;
    
    _cancelRegister.backgroundColor = [UIColor colorWithRed:0.635 green:0.18 blue:0.31 alpha:1]; /*#a22e4f*/
    //self.cancelRegister.layer.cornerRadius = 4.0f;
    
    _forgotButton.backgroundColor = [UIColor colorWithRed:0.953 green:0.714 blue:0.298 alpha:1]; /*#f3b64c mustard*/
    //self.forgotButton.layer.cornerRadius = 4.0f;
    
    self.profilePic.layer.cornerRadius = self.profilePic.frame.size.width / 2;
    self.profilePic.clipsToBounds = YES;
    
    self.profilePic.layer.borderWidth = 4.0f;
    self.profilePic.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _usernameField.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:18.0f];
    _emailField.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:18.0f];
    _passwordField.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:18.0f];
    _reEnterPasswordField.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:18.0f];
    _loginUsernameField.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:18.0f];
    _loginPasswordField.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:18.0f];
    
    //self.profilePic.layer.cornerRadius = 10.0f;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self setHidesBottomBarWhenPushed:YES];
    /*PFUser *user = [PFUser currentUser];
    if (user.username != nil) {
        [self performSegueWithIdentifier:@"login" sender:self];
    }*/
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forget:(id)sender {
    [self getEmail];
}

- (void)getEmail {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email Address" message:@"Enter the email for your account:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        UITextField *emailTextField = [alertView textFieldAtIndex:0];
        [self sendEmail:emailTextField.text];
        
    }
}

- (void)sendEmail:(NSString *)email{
    
    [PFUser requestPasswordResetForEmailInBackground:email];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password reset" message:@"An email has been sent to your resistered account" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (IBAction)cancelButton:(id)sender {
    
    //[self.loginOverlayView removeFromSuperview];
    //[_loginOverlayView setHidden : YES];
    
    _orLabel.hidden = NO;
    
    [UIView animateWithDuration:0.377
                     animations:^{_loginOverlayView.alpha = 0.0;}
                     completion:^(BOOL finished){ [_loginOverlayView removeFromSuperview]; _loginOverlayView = nil; }];
}

- (IBAction)cancelRegister:(id)sender {
    
    //[self.loginOverlayView removeFromSuperview];
    //[_loginOverlayView setHidden : YES];
    _orLabel.hidden = NO;
    
    [UIView animateWithDuration:0.377
                     animations:^{_registerOverlayView.alpha = 0.0;}
                     completion:^(BOOL finished){ [_registerOverlayView removeFromSuperview]; _registerOverlayView = nil; }];
}

- (IBAction)registerUser:(id)sender {
    [_usernameField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_reEnterPasswordField resignFirstResponder];
    [self checkFieldsComplete];
}

- (IBAction)registerAction:(id)sender {
    [UIView animateWithDuration:0.377 animations:^{
        _registerOverlayView.frame = self.view.frame;
        _orLabel.hidden = YES;
    }];
}

- (void) checkFieldsComplete {
    if ([_usernameField.text isEqualToString:@""] || [_emailField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""] || [_reEnterPasswordField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You need to complete all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self checkPasswordsMatch];
    }
}

- (void) checkPasswordsMatch {
    if (![_passwordField.text isEqualToString:_reEnterPasswordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Passwords don't match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self registerNewUser];
    }
}

- (void) registerNewUser {
    NSLog(@"registering....");
    PFUser *newUser = [PFUser user];
    newUser.username = _usernameField.text;
    newUser.email = _emailField.text;
    newUser.password = _passwordField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Registration success!");
            _loginPasswordField.text = nil;
            _loginUsernameField.text = nil;
            _usernameField.text = nil;
            _passwordField.text = nil;
            _reEnterPasswordField.text = nil;
            _emailField.text = nil;
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        else {
            NSLog(@"There was an error in registration");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry the username or email you've entered are already registered. Please choose another one." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)registeredButton:(id)sender {
    [UIView animateWithDuration:0.377 animations:^{
        _loginOverlayView.frame = self.view.frame;
        _orLabel.hidden = YES;
    }];
}

- (IBAction)loginButton:(id)sender {
    [PFUser logInWithUsernameInBackground:_loginUsernameField.text password:_loginPasswordField.text block:^(PFUser *user, NSError *error) {
        if (!error) {
            NSLog(@"Login user!");
            _loginPasswordField.text = nil;
            _loginUsernameField.text = nil;
            _usernameField.text = nil;
            _passwordField.text = nil;
            _reEnterPasswordField.text = nil;
            _emailField.text = nil;
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Sorry we had a problem logging you in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 80; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end
