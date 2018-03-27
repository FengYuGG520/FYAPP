#pragma mark - iOS 适配
// 适配主要是在两个方面进行的

// MARK: - 1. 系统版本
// 由于不同的 iOS 系统提供的 API 不一样, 所以需要进行适配

// MARK: - 2. 屏幕适配
/**
 * iPhone 5           640x1136
 * iPhone 5S          640x1136
 * iPhone 5C          640x1136
 * iPhone SE          640x1136
 
 * iPhone 6           750x1334
 * iPhone 6S          750x1334
 * iPhone 7           750x1334
 
 * iPhone 6 Plus      1242x2208
 * iPhone 6S Plus     1242x2208
 * iPhone 7 Plus      1242x2208
 */

#pragma mark - OBJ的几个方法注意
/**
 *  + (void)load {}
 *      只要导入这类的头文件, 就会调用的方法
 *  + (void)initialize {}
 *      只要这个类加载的时候就会调用
 */

#pragma mark - MRC文件不采用ARC机制进行编译
/**
 *   若程序使用的是 ARC 机制开发的,但是其中的某些类使用的是 MRC
 *   在 MRC 的文件夹进行标记. Build Phases -fno-objc-arc 表示不使用ARC进行编译
 */

#pragma mark - 给Xcord文件上锁
/**
 *   终端:  cd /Applications/Xcode.app
 *   sudo chown -hR root:wheel Contents
 */

#pragma mark - 解决 macos Sierra 系统「安全性与隐私」设置中没有任何来源选项问题
/**
 *   终端:  sudo spctl --master-disable
 */

#pragma mark - 4个对象方法
/**
 *   A.判断一个类是否有某个对象方法有两种判断方式
 *       1. 声明一个对象并调用respondsToSelector这个方法
 *           b=[p respondsToSelector:@selector(sayHi)];
 *       2. 直接用类调用instancesRespondToSelector方法
 *           b=[Person instancesRespondToSelector:@selector(sayHi)];
 *
 *   B.判断一个对象是不是某个类的对象, 或者是不是某个类的子类对象
 *       b=[st isKindOfClass:[Person class]];
 *
 *   C.判断一个对象是不是某个类的对象,只能判断是不是本类的,不能判断是不是子类
 *       b=[st isMemberOfClass:[Person class]];
 *
 *   D.判断某个类是不是一个类的子类
 *       b=[Student isSubclassOfClass:[Person class]];
 */

#pragma mark - 归档解档
/**
 *  归档: 把一个对象转换成二进制文件 (这个类必须遵守 NSCoding 协议)
 *      归档之前, 必须在这个对象所在的类里面实现 encodeWithCoder 方法
 *
 *  - (void)encodeWithCoder:(NSCoder *)aCoder {
 *      [aCoder encodeObject:_name forKey:@"name"];
 *      [aCoder encodeInteger:_age forKey:@"age"];
 *  }
 *
 *  解档: 把二进制文件解成对象
 *      解档之前, 同样必须实现 initWithCoder 方法
 *
 *  - (instancetype)initWithCoder:(NSCoder *)aDecoder {
 *      if (self = [super init]) {
 *          _name = [aDecoder decodeObjectForKey:@"name"];
 *          _age = (int)[aDecoder decodeIntegerForKey:@"age"];
 *      }
 *      return self;
 *  }
 */

#pragma mark - 占位符和运算符
/**
 *   通用             %zd
 *   int             %d
 *   short           %hd
 *   long            %ld
 *   unsigned int    %u
 *   unsigned short  %hu
 *   unsigned long   %lu
 *   signed int      %d	(默认有符号位的修饰符)
 *   float           %f	(默认输出小数点后6位，7位有效数)
 *   double          %lf	(默认输出小数点后6位，16位有效数)
 *   char            %c
 *   unichar         %C	(OC中一个中文占两个字符,用这个格式控制符来输出中文字符)
 *   %md             m是一个整数，表示该数值占多少位
 *   %0md            不足的地方用0补齐
 *   %.nf            n是一个数字，代表要输出小数点后面多少位
 *   %.nlf           n是一个数字，代表要输出小数点后面多少位
 *   %p              输出地址
 *   %s              C字符串
 *   %lf             CGFloat
 *
 *   优先级 =>> 运算符
 *   1   []	()	.	->
 *   2   +(正号)	-(负号)	++	--	*(指针变量)	&(变量名)
 *       !	~	sizeof
 *   3	/	*	%
 *   4	+	-
 *   5	<<	>>
 *   6	>	>=	<	<=
 *   7	==	!=
 *   8	&
 *   9	^
 *   10	|
 *   11	&&
 *   12	||
 *   13	?:
 *   14  =	/=	*=	%=	+=	-=	<<=	>>=
 *       &=	^=	|=
 *   15	,
 */
