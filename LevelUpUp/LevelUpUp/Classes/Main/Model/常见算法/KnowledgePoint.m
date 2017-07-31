//
//  KnowledgePoint.m
//  来画图啊
//
//  Created by ydcy-mini on 2017/4/27.
//  Copyright © 2017年 ydcy-mini. All rights reserved.
//

/* 
 1.通用编程技能，例如：一道小算法，数据结构的实现方式，网络，多线程。
 2.开发语言，例如：语言特性，重新实现语言提供的功能，是否深入研究过这门语言的某部分。
 3.开发平台，例如：该平台的内部消息，内存，线程等机制。
 4.工具，例如：调试技巧，是否熟练使用，代码管理工具，项目管理工具，效率工具。
 5.行业视角，例如：用什么，知道什么。
 6.其他能力，例如：网络上解决问题的能力，是否有持续学习的意识。
 有经验的，1-6都会问到，刚毕业的，只要重点面1和6

 
 1，@property中有哪些属性关键字？
 答：strong、weak、assign、copy、atomic、noatomic、readonly、readwrite、retain、等

 2，weak属性需要在dealloc中置nil么？
 答：Arc会自动在dealloc中置为nil。

 3， @synthesize和@dynamic分别有什么作用？
 答：前者自动生成getter、setter。后者是用户自己实现。

 4，ARC下，不显式指定任何属性关键字时，默认的关键字都有哪些？ 
 答：Strong 、atomic、readwrite。

 5，用@property声明的NSString（或NSArray，NSDictionary）经常使用copy关键字，为什么？如果改用strong关键字，可能造成什么问题？
 答：（1）使用copy的目的是为了让本对象的属性不受外界影响,使用copy无论给我传入是一个可变对象还是不可对象,我本身持有的就是一个不可变的副本。
    （2）如果我们使用是strong,那么这个属性就有可能指向一个可变对象,如果这个可变对象在外部被修改了,那么会影响该属性.

 6，@synthesize合成实例变量的规则是什么？假如property名为foo，存在一个名为_foo的实例变量，那么还会自动合成新变量么？
 答：1）如果指定了成员变量的名称,会生成一个指定的名称的成员变量,
    2）如果这个成员已经存在了就不再生成了.
    3）如果是 @synthesize foo; 还会生成一个名称为foo的成员变量，也就是说：如果没有指定成员变量的名称会自动生成一个属性同名的成员变量。
    4）如果是 @synthesize foo = _foo; 就不会生成成员变量了.
    假如property名为foo，存在一个名为_foo的实例变量，那么还会自动合成新变量么？ 不会。
 
 
 
 7，objc中向一个nil对象发送消息将会发生什么？

 8，objc中向一个对象发送消息[obj foo]和objc_msgSend()函数之间有什么关系？

 9，什么时候会报unrecognized selector的异常？

 10，一个objc对象如何进行内存布局？（考虑有父类的情况）

 11，一个objc对象的isa的指针指向什么？有什么作用？
 答：对象的isa指向类，类的isa指向元类（meta class），元类isa指向元类的根类。isa帮助一个对象找到它的方法。
 isa：是一个Class 类型的指针. 每个实例对象有个isa的指针,他指向对象的类，而Class里也有个isa的指针, 指向meteClass(元类)。元类保存了类方法的列表。当类方法被调用时，先会从本身查找类方法的实现，如果没有，元类会向他父类查找该方法。同时注意的是：元类（meteClass）也是类，它也是对象。元类也有isa指针,它的isa指针最终指向的是一个根元类(root meteClass).根元类的isa指针指向本身，这样形成了一个封闭的内循环。

 */



#import "KnowledgePoint.h"

@implementation KnowledgePoint


- (void)test{

    my_struct str = (my_struct)(malloc(sizeof(my_struct)));

    str->a = 1;
    str->b = 2;

    self.arg1 = @"arg1";
    self.arg2 = @"arg2";
    self.arg3 = str;

    [self performSelector:@selector(call:) withObject:self];
}

-(void)call:(KnowledgePoint *)po
{
//    NSTimer *t = [NSTimer scheduledTimerWithTimeInterval:<#(NSTimeInterval)#> repeats:<#(BOOL)#> block:<#^(NSTimer * _Nonnull timer)block#>]
    NSLog(@"%d %d",po.arg3->a,po.arg3->b);
}
@end
