//
//  AdminSettingsViewController.m
//  Explore
//
//  Created by Varun on 31/07/2015.
//  Copyright (c) 2015 Channi. All rights reserved.
//

#import "AdminSettingsViewController.h"

@interface AdminSettingsViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
    __weak IBOutlet UITextView *txtViewLoginText;
    __weak IBOutlet UIImageView *imgViewAppBack;
    __weak IBOutlet UIButton *btnSave;
    __weak IBOutlet UIImageView *imgViewBack;
    
    BOOL imageChanged;
    UIImage *newImageBack;
}

@end

@implementation AdminSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSettingView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup View

- (void)setupSettingView {
    
    [self setTitle:@"Settings"];
    
    [txtViewLoginText setText:[EXUserDefs objectForKey:@"LoginText"]];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[EXUserDefs objectForKey:@"BackImage"]];
    [imgViewBack setImage:image];
    [imgViewAppBack setImage:image];
    
    [txtViewLoginText.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [txtViewLoginText.layer setBorderWidth:1.0f];
    [txtViewLoginText.layer setCornerRadius:2.0f];
    
    [imgViewAppBack.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [imgViewAppBack.layer setBorderWidth:1.0f];
    [imgViewAppBack.layer setCornerRadius:2.0f];
    
    [btnSave.layer setCornerRadius:4.f];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Show Image Picker

- (void)showImagePicker {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setDelegate:self];
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - Image Picker Delegate

- (UIImage*) blur:(UIImage*)theImage
{
    // ***********If you need re-orienting (e.g. trying to blur a photo taken from the device camera front facing camera in portrait mode)
    // theImage = [self reOrientIfNeeded:theImage];
    
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    // setting up Gaussian Blur (we could use one of many filters offered by Core Image)
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:10.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];//create a UIImage for this function to "return" so that ARC can manage the memory of the blur... ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
    
    // *************** if you need scaling
    // return [[self class] scaleIfNeeded:cgImage];
}

- (void)writeFileInDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
    NSData *imageData = UIImagePNGRepresentation(newImageBack);
    if ([imageData writeToFile:savedImagePath atomically:NO]) {
        
        [EXUserDefs setObject:txtViewLoginText.text forKey:@"LoginText"];
        [EXUserDefs synchronize];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Problem in saving image right now"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *imagePicked = [info objectForKey:UIImagePickerControllerOriginalImage];
    newImageBack = [self blur:imagePicked];
    
    [imgViewBack setImage:newImageBack];
    [imgViewAppBack setImage:imagePicked];
    
    imageChanged = YES;
    
    [picker dismissViewControllerAnimated:YES completion: ^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent
                                                    animated:NO];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion: ^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent
                                                    animated:NO];
    }];
}

#pragma mark - IBAction Save

- (IBAction)buttonSaveAction:(id)sender {
    
    if (![txtViewLoginText.text length]) {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"You must provide some text to be displayed on Login Screen"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil, nil] show];
    }
    else {
        
        if (imageChanged) {
            
            [self writeFileInDirectory];
        }
        else {
            [EXUserDefs setObject:txtViewLoginText.text forKey:@"LoginText"];
            [EXUserDefs synchronize];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

#pragma mark - Touch Methods

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UIView *viewTouched = [[touches anyObject] view];
    if (![viewTouched isKindOfClass:[UITextView class]])
        [txtViewLoginText resignFirstResponder];
    
    if ([viewTouched isKindOfClass:[UIImageView class]] && [viewTouched tag])
        [self showImagePicker];
}

@end
