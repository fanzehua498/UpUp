//
//  testView.m
//  LevelUpUp
//
//  Created by 范泽华 on 2017/9/17.
//  Copyright © 2017年 fanzehua. All rights reserved.
//

#import "testView.h"

@interface testView ()
@property(nonatomic,strong) UILabel *label;
@end

@implementation testView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 20);
        [self addObserver:self forKeyPath:@"imageArr" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}


-(void)setImageArr:(NSArray *)imageArr
{
    _imageArr = imageArr;
}


- (void)drawRect:(CGRect)rect
{
//    for (int views = 0; views<self.subviews.count; views ++) {
//        UILabel *view =  self.subviews[views];
//        [view removeFromSuperview];
//    }
//    
//    NSInteger rowrow = self.imageArr.count / 3;
//    NSInteger yuxiade = self.imageArr.count % 3;
//    
//    if (yuxiade != 0 && self.imageArr.count != 9) {
//        rowrow += 1;
//    }
//    
//    if (rowrow == 1) {
//        for (int i = 0; i < self.imageArr.count; i++) {
//            
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*100, 20, 100, 20)];
//            label.text = @"label";
//            [self addSubview:label];
//        }
//    }else{
//        for (int i = 0; i < rowrow - 1; i++) {
//            for (int j = 0; j < 3; j++) {
//                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(j*100, i*20, 100, 20)];
//                label.text = @"label";
//                [self addSubview:label];
//                
//            }
//            
//        }
//        for (int k = 0; k < yuxiade; k ++) {
//            UILabel *labelLastRow = [[UILabel alloc] initWithFrame:CGRectMake(k * 80, rowrow * 20, 80, 20)];
//            labelLastRow.text = @"LastRow";
//            [self addSubview:labelLastRow];
//        }
//        
//    }

}
-(void)layoutSubviews
{
    
    [super layoutSubviews];
    NSInteger rowrow = self.imageArr.count / 3;
    NSInteger yuxiade = self.imageArr.count % 3;
    
    if (yuxiade != 0 ) {
        rowrow += 1;
    }
    
    
    if (self.imageArr.count <= 3) {
        for (int i = 0; i < self.imageArr.count; i++) {
            
            self.label = [[UILabel alloc] initWithFrame:CGRectMake(i*100, 0, 100, 20)];
            self.label.text = @"label";
            self.label.backgroundColor = [UIColor grayColor];
            [self addSubview:self.label];
        }
        
    }else{
        if (yuxiade == 0) {
            for (int i = 0; i < rowrow ; i++) {
                for (int j = 0; j < 3; j++) {
                    self.label = [[UILabel alloc] initWithFrame:CGRectMake(j*100, i*20, 100, 20)];
                    self.label.text =[NSString stringWithFormat:@"row:%d-lie%d",i,j];
                    self.label.backgroundColor = [UIColor blueColor];
                    [self addSubview:self.label];
                    
                }
                
            }

        }else if(rowrow > 1){
            
            for (int i = 0; i < rowrow - 1; i++) {
                for (int j = 0; j < 3; j++) {
                   self.label = [[UILabel alloc] initWithFrame:CGRectMake(j*100, i*20, 100, 20)];
                    self.label.text =[NSString stringWithFormat:@"row:%d-lie%d",i,j];
                    [self addSubview:self.label];
                    self.label.backgroundColor = [UIColor yellowColor];
                    
                }
                
            }
            
            for (int k = 0; k < yuxiade; k ++) {
                self.label = [[UILabel alloc] initWithFrame:CGRectMake(k * 100, (rowrow-1) * 20, 100, 20)];
                self.label.text = [NSString stringWithFormat:@"last:%d-lie%d",rowrow,k];
                self.label.backgroundColor = [UIColor redColor];
                [self addSubview:self.label];
            }

            
        }
        
        
    }
    
    NSLog(@"subfotter:%ld",self.subviews.count);
}
- (void)update{
//    self.backgroundColor = [UIColor redColor];
    
//    NSInteger lie = self.imageArr.count;
//    NSInteger row = 1;
    NSLog(@"subupdate:%ld",self.subviews.count);
    

    for (UILabel *label in self.subviews) {
        [label removeFromSuperview];
    }
    [self setNeedsLayout];

    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString: @"imageArr"]) {
        NSLog(@"%@",change);
        NSArray *arr = change[NSKeyValueChangeNewKey];
        NSLog(@"%@",arr);
        NSInteger he;
        if (arr.count % 3 != 0) {
            he = arr.count/3 + 1;
        }else{
            he = arr.count / 3;
        }
       
        CGRect frame = self.frame;
        frame.size.height = 20 * he;
        self.frame = frame;
    }
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"imageArr"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
