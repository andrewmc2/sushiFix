//
//  AddSushiViewController.m
//  Sushi2
//
//  Created by Andrew McCallum14 on 2013-05-31.
//  Copyright (c) 2013 Andrew McCallum. All rights reserved.
//

#import "AddSushiViewController.h"
#import "AddSushiCustomCell.h"

@interface AddSushiViewController ()

@end

@implementation AddSushiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSourceMethods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"cell";
    AddSushiCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (cell == nil){
//        cell = [[AddSushiCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//    }
    
    if (indexPath.section == 0) {
        cell.cellName.text = @"name";
        cell.cellTextField.placeholder = @"insert name here";
    }
    
    if (indexPath.section == 1) {
        cell.cellName.text = @"description";
        cell.cellTextField.placeholder = @"insert description here";
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark delegate method

- (IBAction)confirmEntry:(id)sender {

}

#pragma mark add picture 

- (IBAction)addPic:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Choose" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Picture", @"Select from Library", nil];
    [actionSheet showInView:self.view];
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
        } else
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    } else if (buttonIndex == 1) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.addedImage.image = self.selectedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneAddingSushi:(id)sender {
    NSString *sushiNameString = ((AddSushiCustomCell*)([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]])).cellTextField.text;
    NSString *sushiDescriptionString = ((AddSushiCustomCell*)([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]])).cellTextField.text;
    
    [self.addSushiDelegate addName:sushiNameString
                    addDescription:sushiDescriptionString
                          addImage:self.selectedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelAddSushi:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
