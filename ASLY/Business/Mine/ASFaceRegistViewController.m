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


@property(nonatomic, strong) UIButton   * doneBtn ;

@property(nonatomic, strong) NSTimer   * timer ;



@end

@implementation ASFaceRegistViewController


-(NSTimer *)timer{
    if (!_timer) {
        __block NSInteger stepNum = 0 ;
        WEAKSELF
        _timer = [NSTimer jk_scheduledTimerWithTimeInterval:3. block:^{
            stepNum ++ ;
            
            [weakSelf updateGifAndhintText:stepNum % 4] ;
            
        } repeats:YES] ;
    }
    return _timer;
}

- (UIImageView *)gifIV{
    if (!_gifIV) {
        _gifIV = [UIImageView new] ;
        _gifIV.image = [self getImageWithName:@"as_faceAnimal_all"] ;
    }
    return _gifIV;
}


-(UILabel *)hintLbl{
    if (!_hintLbl) {
        _hintLbl = [UILabel new] ;
        _hintLbl.numberOfLines = 0 ;
        _hintLbl.textAlignment = NSTextAlignmentCenter ;
    }
    
    return _hintLbl;
}


-(UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        _doneBtn.titleLabel.font = kTEXT_FONT_(13) ;
        [_doneBtn addTarget:self action:@selector(doneBtnTapped) forControlEvents:UIControlEventTouchUpInside] ;
        _doneBtn.backgroundColor = kMainColor ;
        [_doneBtn setTitle:@"开始使用" forState:UIControlStateNormal] ;
        [_doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal] ;
        _doneBtn.layer.masksToBounds = YES ;
        _doneBtn.layer.cornerRadius = 5. ;
        
    
    }
    return _doneBtn ;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"人脸注册" ;
//    self.title = @"添加人脸数据" ;
    
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:vi];
    
    [vi  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(320) ;
        make.height.mas_equalTo(240) ;
        make.top.offset(KAllTopNavBarHeight + 30) ;
        make.centerX.equalTo(self.view) ;
    }] ;
    vi.backgroundColor= [UIColor whiteColor];

    [self.view layoutIfNeeded] ;
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 局部透明的rect
    CGRect rect =  CGRectMake(0, 0, 200, 200);
    rect.origin = CGPointMake(vi.jk_width/2. - rect.size.width/2., vi.jk_height/2. - rect.size.height/2.) ;
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height / 2.0] bezierPathByReversingPath]];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    shapeLayer.path= path.CGPath;

    [vi.layer setMask:shapeLayer];

    
    
    [vi addSubview:self.gifIV] ;
    
    
    [self.gifIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(vi) ;
    }] ;
    
    [self.view addSubview:self.hintLbl] ;
    
    [self.hintLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vi.mas_bottom).offset(40) ;
        make.centerX.equalTo(self.view) ;
    }] ;
    
    NSMutableAttributedString * muAttributeStr  = [[NSMutableAttributedString alloc] initWithString:@"如何注册人脸\n\n" attributes:@{NSFontAttributeName:kTEXT_FONT_(15),NSForegroundColorAttributeName:[UIColor blackColor]}] ;
    [muAttributeStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"首先，保持面部在相机取景框内" attributes:@{NSFontAttributeName:kTEXT_FONT_(13),NSForegroundColorAttributeName:[UIColor blackColor]}]] ;
    self.hintLbl.attributedText = muAttributeStr ;
    
    
    [self.view addSubview:self.doneBtn] ;
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-60) ;
        make.size.mas_equalTo(CGSizeMake(200, 40)) ;
        make.centerX.equalTo(self.view) ;
    }] ;
    
    // Do any additional setup after loading the view.
}


-(void)doneBtnTapped{
    if ([self.doneBtn.titleLabel.text isEqualToString:@"录入完成"]) {
        [[UIApplication sharedApplication].delegate.window jk_makeToast:@"注册成功" duration:2. position:JKToastPositionCenter] ;
        [self.navigationController popViewControllerAnimated:YES] ;
        return;
    }
    [self updateGifAndhintText:0] ;
    [self.doneBtn setTitle:@"录入完成" forState:UIControlStateNormal] ;
    [self timer] ;
}

-(UIImage *)getImageWithName:(NSString *)nameStr{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:nameStr ofType:@"gif"];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];

    return [UIImage sd_imageWithGIFData:imageData] ;
}



-(void)updateGifAndhintText:(NSInteger)stepNum{
    NSArray * hintArr = @[@"正面",@"左面",@"上面",@"右面"]  ;
    
    self.hintLbl.text = hintArr[stepNum] ;
    
    self.gifIV.image = [self getImageWithName:[NSString stringWithFormat:@"as_faceAnimal_%@",[self getGifStrWithHintStr:self.hintLbl.text]]] ;

    
    
}


-(NSString *)getGifStrWithHintStr:(NSString *)hintStr{
    if ([hintStr isEqualToString:@"正面"]) {
        return @"middle";
    }
    if ([hintStr isEqualToString:@"左面"]) {
        return @"left";
    }
    if ([hintStr isEqualToString:@"上面"]) {
        return @"up";
    }
    if ([hintStr isEqualToString:@"右面"]) {
        return @"right";
    }
    return @"all";
}


-(void)dealloc{
    
    if (_timer) {
        [_timer invalidate] ;
        _timer = nil ;
    }
    
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
