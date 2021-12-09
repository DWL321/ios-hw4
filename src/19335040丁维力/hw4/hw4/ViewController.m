//
//  ViewController.m
//  hw4
//
//  Created by student14 on 2021/11/25.
//  Copyright © 2021 SDCS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "../Pods/Masonry/Masonry/Masonry.h"
#import "Cell.h"

@interface ViewController ()
@property (strong, nonatomic)UILabel *title_lable;
@property (strong, nonatomic)UICollectionView *collectionView;
@property (strong,nonatomic) UIButton *load_button;
@property (strong,nonatomic) UIButton *clean_button;
@property (strong,nonatomic) UIButton *delete_button;
@property (strong,nonatomic) NSMutableArray *picData;
@property (strong,nonatomic) NSMutableArray *url;
@property int isempty;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isempty=0;
    [self CreateTitle];
    _url = [[NSMutableArray alloc] initWithCapacity:0];
    [_url removeAllObjects];
    [_url addObject:@"https://hbimg.huabanimg.com/039fe67f0b83b99605374db04fcd4410d10ef135182f2-TJ5VQC_fw658"];
    [_url addObject:@"https://hbimg.huabanimg.com/ad5ef2f1ea4c71ef333c8bcd936102077e6d8ddfe471-lJHmP7_fw658"];
    [_url addObject:@"https://hbimg.huabanimg.com/66ba2e842fbb485b6a155bfb742e73110e745c68612b-4YubTV_fw658"];
    [_url addObject:@"https://hbimg.huabanimg.com/050ad49cece305f1ecfcac4cb3cf301ce7b894dd1d5ea-UN9FgQ_fw658"];
    [_url addObject:@"https://hbimg.huabanimg.com/6a94d8532a265d11b183fdeab7782907d71e90e4ad0c-Q3mC3J_fw658"];
    _picData = [[NSMutableArray alloc] initWithCapacity:0];
    [_picData removeAllObjects];
    for(int i=0;i<5;i++){
        [_picData addObject:[[NSData alloc]init]];
    }
    [self CreateCol];
    [self CreateBtn];
    self.navigationController.delegate = self;
}

-(void)CreateTitle{
    //创建Lable
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    _title_lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, screenBounds.size.width, 30)];
    //设置内容
    _title_lable.text=@"Pictures";
    //设置居中
    _title_lable.textAlignment=NSTextAlignmentCenter;
    //设置字体颜色
    _title_lable.textColor=[UIColor blackColor];
    //设置背景颜色
    _title_lable.backgroundColor=[UIColor whiteColor];
    //设置字体大小
    _title_lable.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
    
    [self.view addSubview:_title_lable];
}

-(void)CreateCol{
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小
    layout.itemSize = CGSizeMake(500, 180);
    //创建collectionView 通过一个布局策略layout来创建
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    //注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"cellId"];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.view addSubview:self.collectionView];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake(350, screenBounds.size.height-180));
    }];
}

//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
//返回每个item
- (Cell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = (Cell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.image.image=[UIImage imageWithData:_picData[indexPath.section]];
    return cell;
}


//每个cell的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 5, 0);//分别为上、左、下、右
}

-(void)CreateBtn{
    //创建button
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    _load_button = [[UIButton alloc] initWithFrame:CGRectMake(screenBounds.size.width/16, screenBounds.size.height-50, screenBounds.size.width/4, 30)];
    _clean_button = [[UIButton alloc] initWithFrame:CGRectMake(3*screenBounds.size.width/8, screenBounds.size.height-50, screenBounds.size.width/4, 30)];
    _delete_button = [[UIButton alloc] initWithFrame:CGRectMake(11*screenBounds.size.width/16, screenBounds.size.height-50, screenBounds.size.width/4, 30)];
    //设置按钮圆角
    [_load_button.layer setCornerRadius:10.0];
    [_clean_button.layer setCornerRadius:10.0];
    [_delete_button.layer setCornerRadius:10.0];
    //设置按钮的背景颜色
    _load_button.backgroundColor = [UIColor greenColor];
    _clean_button.backgroundColor = [UIColor greenColor];
    _delete_button.backgroundColor = [UIColor greenColor];
    //设置文字
    [_load_button setTitle:@"加载" forState:UIControlStateNormal];
    [_clean_button setTitle:@"清空" forState:UIControlStateNormal];
    [_delete_button setTitle:@"删除缓存" forState:UIControlStateNormal];
    //设置文字颜色
    [_load_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_clean_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_delete_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //设置字体大小
    _load_button.titleLabel.font = [UIFont systemFontOfSize:20];
    _clean_button.titleLabel.font = [UIFont systemFontOfSize:20];
    _delete_button.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_load_button];
    [self.view addSubview:_clean_button];
    [self.view addSubview:_delete_button];
    [_load_button addTarget:self action:@selector(Loading) forControlEvents:UIControlEventTouchUpInside];
    [_clean_button addTarget:self action:@selector(clean) forControlEvents:UIControlEventTouchUpInside];
    [_delete_button addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];

}

-(void)Loading{
    NSString *pic=[[NSBundle mainBundle] pathForResource:@"loading" ofType:@"png"];
    if(_isempty<5){
        NSOperationQueue *queue = [[NSOperationQueue alloc]init];
        for(NSInteger i=0;i<5;i++){
            NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(downloadImg:) object:_url[i]];
            [queue addOperation:operation];
        }
    }
    while (_isempty<5) {
        for(int i=0;i<5;i++){
            [_picData replaceObjectAtIndex:i withObject:[NSData dataWithContentsOfFile:pic]];
            [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:i]]];
        }
    }
    if(_isempty>=5){
        [self clean];
        NSString *cachesPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSMutableArray *pic= [[NSMutableArray alloc] initWithCapacity:0];
        [pic removeAllObjects];
        for(int i=0;i<5;i++){
            [pic addObject:[cachesPath stringByAppendingPathComponent:[_url[i] lastPathComponent]]];
            [_picData replaceObjectAtIndex:i withObject:[NSData dataWithContentsOfFile:pic[i]]];
        }
    }
    for(int i=0;i<5;i++){
        [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:i]]];
    }
}

-(void)clean{
    [_picData removeAllObjects];
    for(int i=0;i<5;i++){
        [_picData addObject:[[NSData alloc]init]];
    }
    [_collectionView reloadData];
}

-(void)delete{
    _isempty=0;
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    for(int i = 0; i < 5; i ++){
        NSString *imageFilePath = [cachePath stringByAppendingPathComponent:[_url[i] lastPathComponent]];
        [fileManager removeItemAtPath:imageFilePath error:nil];
    }
    _isempty=true;
}

-(void)downloadImg:(NSString*)the_url{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    //写入文件
    if (!cachePath) {
        NSLog(@"目录未找到");
    }else {
        NSData *data;
        NSString *filePaht = [cachePath stringByAppendingPathComponent:[the_url lastPathComponent]];
        data=[NSData dataWithContentsOfURL:[NSURL URLWithString:the_url]];
        [data writeToFile:filePaht atomically:YES];
        _isempty++;
    }
}

@end
