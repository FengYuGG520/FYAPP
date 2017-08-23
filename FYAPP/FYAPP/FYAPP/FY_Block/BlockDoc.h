/**
 *  为什么用 copy(ARC MRC) 和 strong(ARC)
 *  ARC: block 不引用外部变量, block 在全局区 (程序结束才会释放)
 *      block 引用外部变量, block 会在堆区
 *  MRC: block 不引用外部变量, block 在全局区 (程序结束才会释放)
 *      block 引用外部变量, block 会在栈区 (栈区是程序员不能管理的, 所以不能retain)
 *
 *  MARK: -> 循环引用问题
 *  __weak typeof(self) weakSelf = self;
 */
