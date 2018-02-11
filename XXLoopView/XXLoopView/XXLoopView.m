//
//  XXLoopView.m
//  XXCycleScroll
//
//  Created by mac on 2018/2/11.
//  Copyright © 2018年 zhangguoqing@vip.163.com. All rights reserved.
//

#import "XXLoopView.h"
@interface XXLoopViewCell()
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation XXLoopViewCell

-(UIImageView *)imageView{
    if(_imageView){
        return _imageView;
    }
    _imageView = [UIImageView new];
    [self.contentView addSubview:_imageView];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //宽度约束
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    //高度约束
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    //水平居中约束
    NSLayoutConstraint * constraintCenterX =  [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    //竖直居中
    NSLayoutConstraint * constraintCenterY =  [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraints:@[constraintWidth,constraintHeight,constraintCenterX,constraintCenterY]];
    return _imageView;
}
-(void)configureImageWithName:(NSString *)imageName Type:(XXImageResourceType)type{
    if(type == XXImageResourceTypeURL)
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]];
            UIImage *image = [UIImage imageWithData:imageData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
            });
        });
    else{
        self.imageView.image = [UIImage imageNamed:imageName];
    }
}
@end
@interface XXLoopView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, getter=isScrolled) BOOL scroll;


@end
@implementation XXLoopView
- (instancetype)initWithFrame:(CGRect)frame ResourceType:(XXImageResourceType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
    }
    return self;
}
-(UICollectionView *)collectionView{
    if(_collectionView){
        return _collectionView;
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = self.bounds.size;
    
    
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.bounces = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[XXLoopViewCell class] forCellWithReuseIdentifier:NSStringFromClass([XXLoopViewCell class])];
    [self addSubview:_collectionView];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    //宽度约束
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    //高度约束
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    //水平居中约束
    NSLayoutConstraint * constraintCenterX =  [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    //竖直居中
    NSLayoutConstraint * constraintCenterY =  [NSLayoutConstraint constraintWithItem:_collectionView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraints:@[constraintWidth,constraintHeight,constraintCenterX,constraintCenterY]];
    // 初始化Cell的位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    return _collectionView;
}
-(UIPageControl *)pageControl{
    if(_pageControl){
        return _pageControl;
    }
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.enabled = NO;
    [self addSubview:_pageControl];
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    //宽度约束
    NSLayoutConstraint *constraintWidth = [NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:0.5f constant:0];
    //高度约束
    NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.5f constant:0];
    //水平居中约束
    NSLayoutConstraint * constraintCenterX =  [NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    //竖直居中
    NSLayoutConstraint * constraintCenterY =  [NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.5 constant:0];
    [self addConstraints:@[constraintWidth,constraintHeight,constraintCenterX,constraintCenterY]];
    return _pageControl;
}
// collectionView DataSource and Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageNames.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XXLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XXLoopViewCell class]) forIndexPath:indexPath];
//    cell.imageName = self.imageNames[indexPath.row];
    [cell configureImageWithName:self.imageNames[indexPath.row] Type:self.type];
    return cell;
}
// 开始手动的时候停止timer
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
// 停止手动的时候开始timer
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if(self.isScrolled)
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    self.scroll = NO;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    self.currentPage %= self.imageNames.count;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentPage inSection:1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndex:)]){
        [self.delegate didSelectItemAtIndex:indexPath.row];
    }
}

- (void)startTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loop:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)loop:(NSTimer *)timer{
    [UIView animateWithDuration:1 animations:^{
        
        if(self.currentPage == self.imageNames.count){
            self.scroll = YES;
        }
        self.pageControl.currentPage = self.currentPage % self.imageNames.count;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentPage % self.imageNames.count inSection:(self.currentPage == self.imageNames.count) + 1] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.currentPage = self.currentPage % self.imageNames.count + 1;
    }];
}
-(void)setImageNames:(NSArray<NSString *> *)imageNames{
    _imageNames = imageNames;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = imageNames.count;
    [self startTimer];
}
-(void)dealloc{
    [self stopTimer];
}
@end
