//
//  ViewController.m
//  WorldTrotter
//
//  Created by Ye Tian on 24/10/2016.
//  Copyright © 2016 Ye Tian. All rights reserved.
//

#import "ConversionViewController.h"

@interface ConversionViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *celsiusLabel;
@property (weak, nonatomic) IBOutlet UITextField *fahrenheitField;
@property (nonatomic) double fahrenheitValue;
@property (nonatomic) double celsiusValue;

@end

@implementation ConversionViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"ConversionViewController loaded its view");
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)fahrenheitFieldEditingChanged:(UITextField *)sender {
  NSNumber *num = [self.numberFormatter numberFromString:sender.text];
  if (num) {
    self.fahrenheitValue = sender.text.doubleValue;
  } else {
    self.celsiusLabel.text = @"???";
  }
}

- (IBAction)dismissKeyBoard:(id)sender {
  [self.fahrenheitField resignFirstResponder];
}

- (void)setFahrenheitValue:(double)fahrenheitValue {
  _fahrenheitValue = fahrenheitValue;
  [self updateCelsiusLabel];
}

- (void)setCelsiusValue:(double)celsiusValue {
  self.fahrenheitValue = celsiusValue * 9.0 / 5.0 + 32;
}

- (double)celsiusValue {
  return (self.fahrenheitValue - 32) * 5.0 / 9.0;
}

- (void)updateCelsiusLabel {
  self.celsiusLabel.text = [self.numberFormatter stringFromNumber:@(self.celsiusValue)];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  NSRange letterRange = [string rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
  if (letterRange.location != NSNotFound) return NO;
  
  NSLocale *currentLocale = [NSLocale currentLocale];
  NSString *decimalSeparator = [currentLocale objectForKey:NSLocaleDecimalSeparator];
  NSRange existingSepRange = [textField.text rangeOfString:decimalSeparator];
  NSRange newSepRange = [string rangeOfString:decimalSeparator];
  if (existingSepRange.location != NSNotFound && newSepRange.location != NSNotFound) return NO;
  
  return YES;
}

- (NSNumberFormatter *)numberFormatter {
  static NSNumberFormatter *formatter = nil;
  if (formatter == nil) {
    formatter = [NSNumberFormatter new];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 1;
  }
  return formatter;
}

@end
