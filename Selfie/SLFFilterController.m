//
//  LPSFilterController.m
//  LibraryPhotoDisplayer
//
//  Created by Jonathan Fox on 5/1/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "SLFFilterController.h"

@interface SLFFilterController ()

@property (nonatomic) NSString * currentFilter;

@end

@implementation SLFFilterController
{
    UIScrollView * scrollView;
    NSArray * filterNames;
    NSMutableArray * filterButtons;
    
    float wh;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"InitWithNibName");
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       // self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.1];
       // self.view.backgroundColor = [UIColor redColor];



        
        filterButtons = [@[] mutableCopy];
        filterNames = @[
                        @"CIColorInvert",
                        @"CIColorMonochrome",
                        @"CIColorPosterize",
                        @"CIFalseColor",
                        @"CIMaximumComponent",
                        @"CIMinimumComponent",
                        @"CIPhotoEffectChrome",
                        @"CIPhotoEffectFade",
                        @"CIPhotoEffectInstant",
                        @"CIPhotoEffectMono",
                        @"CIPhotoEffectNoir",
                        @"CIPhotoEffectProcess",
                        @"CIPhotoEffectTonal",
                        @"CIPhotoEffectTransfer",
                        @"CISepiaTone",
                        @"CIVignette"
                        ];
        
        scrollView = [[UIScrollView alloc]init];
        scrollView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.1];
       // scrollView.backgroundColor = [UIColor yellowColor];

        [self.view addSubview:scrollView];
  
        
        // Use this to log the attributes of a filter
//        CIFilter *myFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
//        NSDictionary *myFilterAttributes = [myFilter attributes];
//        
//        NSLog(@"%@", myFilterAttributes);
    
    }
    return self;
}


// make the filter buttons

- (void)viewWillLayoutSubviews
{
    wh = self.view.frame.size.height - 20;
    
    for (NSString * filterName in filterNames)
    {
        int i = (int)[filterNames indexOfObject:filterName];
        int x = (wh + 10) * i + 10;
        
        UIButton * filterButton = [[UIButton alloc]initWithFrame:CGRectMake(x, 10, wh, wh)];
        filterButton.tag = i;
        filterButton.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.1];
        //filterButton.backgroundColor = [UIColor blueColor];
        filterButton.titleLabel.font = [UIFont systemFontOfSize:8];
        [filterButton setTitle:filterName forState:UIControlStateNormal];

        
        [filterButton addTarget:self action:@selector(switchFilter:) forControlEvents:UIControlEventTouchUpInside];
        
        [filterButtons addObject:filterButton];
        
        [scrollView addSubview:filterButton];
        
    }
    scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, 100);
    scrollView.contentSize = CGSizeMake((wh + 10) * [filterNames count] + 10, 100);
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)filterImage:(UIImage *)image filterName:(NSString *)filterName
{
    CIImage * ciImage = [CIImage imageWithCGImage:image.CGImage];
    //    CIImage *image = [CIImage imageWithContentsOfURL:myURL];               // 2

    CIFilter * filter = [CIFilter filterWithName:filterName];
    //    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];           // 3

    
    [filter setValue:ciImage forKeyPath:kCIInputImageKey];
    //    [filter setValue:image forKey:kCIInputImageKey];
    //    [filter setValue:@0.8f forKey:kCIInputIntensityKey];
    
    CIContext * ciContext = [CIContext contextWithOptions:nil];
    //    CIContext *context = [CIContext contextWithOptions:nil];               // 1

    
    CIImage * ciResult = [filter valueForKeyPath:kCIOutputImageKey];
    //    CIImage *result = [filter valueForKey:kCIOutputImageKey];


    //    CGRect extent = [result extent];
//    CGImageRef cgImage = [context createCGImage:result fromRect:extent];  // 4 all these in below
//    return uiImage;
    
    return [UIImage imageWithCGImage:[ciContext createCGImage:ciResult fromRect:[ciResult extent]]];
}


-(void)setImageToFilter:(UIImage *)imageToFilter
{
    _imageToFilter = imageToFilter;
    
    for (UIButton *filterButton in filterButtons)
    {
        
        [filterButton setImage:nil forState:UIControlStateNormal];

        NSString * filterName = [filterNames objectAtIndex:filterButton.tag];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,(unsigned long)NULL), ^{
            
            UIImage * smallImage = [self shrinkImage:imageToFilter maxWH:wh];
            UIImage * image = [self filterImage:smallImage filterName:filterName];
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                
                [filterButton setImage:image forState:UIControlStateNormal];
                filterButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
            });
        });
    }
}

-(void)switchFilter:(UIButton *)filterButton
{
    self.currentFilter = [filterNames objectAtIndex:filterButton.tag];
    
    //UIImage * image = [self filterImage:self.imageToFilter filterName:self.currentFilter];
    //[self.delegate updateCurrentImageWithFilteredImage:image];
    //[UIImage imageWithCGImage:[self filterImage:[self shrinkImage:self.imageFilter maxWH:SCREEN_WIDTH * 2] filterName:self.currentFilter];
    NSLog(@"%@", self.currentFilter);


    // Shrink the image to make it smaller, so it doesn't take long to process
    UIImage * shrinkedImage = [self shrinkImage:self.imageToFilter maxWH:SCREEN_WIDTH];
   
    // Now we need to apply filter to our shrinked image
    UIImage * filteredImage = [self filterImage:shrinkedImage filterName:self.currentFilter];
    
    // Now put our filtered image in our root VC :)
    [self.delegate updateCurrentImageWithFilteredImage:filteredImage];
     
}

-(UIImage *)shrinkImage:(UIImage *)image maxWH:(int)widthHeight
{
    CGSize size = CGSizeMake(widthHeight, widthHeight / image.size.width * image.size.height);
    
    if(image.size.height < image.size.width)
    {
        size = CGSizeMake(widthHeight / image.size.height * image.size.width, widthHeight);
    }
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect: CGRectMake(0, 0, size.width, size.height)];
    
    UIImage * destImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return destImage;
}

-(BOOL)prefersStatusBarHidden {return YES;}

@end
