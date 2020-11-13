//
//  ASFaceRegistViewController.m
//  ASLY
//
//  Created by 张志超 on 2020/11/13.
//  Copyright © 2020 AS. All rights reserved.
//

#import "ASFaceRegistViewController.h"
@interface ASFaceRegistViewController ()

@property(nonatomic, strong) UIImageView   * gifIV  ;

@property(nonatomic, strong) UILabel   * hintLbl  ;


@end

@implementation ASFaceRegistViewController


- (UIImageView *)gifIV{
    if (!_gifIV) {
        _gifIV = [UIImageView new] ;
        _gifIV.image = [self getImageWithName:@"as_faceAnimal_all"] ;
        _gifIV.layer.masksToBounds = YES ;
        _gifIV.layer.cornerRadius = 50. ;
    }
    return _gifIV;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人脸注册" ;
//    self.title = @"添加人脸数据" ;
    
    [self.view addSubview:self.gifIV] ;
    
    
    [self.gifIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100) ;
        make.top.offset(KAllTopNavBarHeight + 30) ;
        make.centerX.equalTo(self.view) ;
    }] ;
    
    
    // Do any additional setup after loading the view.
}


-(UIImage *)getImageWithName:(NSString *)nameStr{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:nameStr ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];

    return [UIImage sd_imageWithGIFData:imageData] ;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
