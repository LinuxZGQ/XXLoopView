//
//  XXLoopView.h
//  XXCycleScroll
//
//  Created by mac on 2018/2/11.
//  Copyright © 2018年 zhangguoqing@vip.163.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XXImageResourceType) {
    XXImageResourceTypeLocal,
    XXImageResourceTypeURL
};
@protocol XXLoopViewDelegate <NSObject>
@optional
- (void)didSelectItemAtIndex:(NSUInteger)index;
@end
@interface XXLoopViewCell: UICollectionViewCell
//@property (nonatomic, strong) NSString *imageName;
- (void)configureImageWithName:(NSString *)imageName Type:(XXImageResourceType)type;

@end



@interface XXLoopView : UIView
@property (nonatomic, weak) id<XXLoopViewDelegate> delegate;
@property (nonatomic, strong) NSArray<NSString*> *imageNames;
@property (nonatomic, assign) XXImageResourceType type;
- (instancetype)initWithFrame:(CGRect)frame ResourceType:(XXImageResourceType)type;
@end
