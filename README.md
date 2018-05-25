# YBArchiveUtilDemo
归档解档的工具

> 工具类实现归档解档

###自己的model类可继承`YBAutoArchive`，也可不继承基类，只需在自己的model类的.m文件的实现里添加宏`YB_IMPLEMENTATION_CODE_WITH_CODER`。

+ 可全局配置保存的文件路径名，调用`setPlistPathName :`方法；
+ 也可以设置单独归档的文件名，调用`saveObject:withFilePathName:`或者`saveObjects:forFlag:withFilePathName`方法；
+ 调用`saveObject:withFilePathName:`和`saveObjects:forFlag:withFilePathName`方法的区别是归档单个或者多个model；
+ 移除时调用`removeObjectWithFilePathName:`方法。



方法如下：

	/**
	 指定默认保存数据的文件名，全局只用设置一次
	
	 @param pathName 文件名
	 */
	+ (void)setPlistPathName:(NSString*)pathName;
	
	/**
	 保存单个数据
	
	 @param obj 实现了归档的对象
	 @param filePathName 文件名，如果传值nil，则会保存在默认的defaultPathName里
	 @return 保存状态
	 */
	+ (BOOL)saveObject:(id)obj withFilePathName:(NSString *)filePathName;
	
	/**
	 取出单个数据
	
	 @param filePathName 文件名，如果传值nil，则会在默认的defaultPathName里取
	 @return 对象
	 */
	+ (id)getObjectWithFilePathName:(NSString *)filePathName;
	
	/**
	 移除文件名下的对象
	
	 @param filePathName 文件名，如果传值nil，则return
	 @return 执行结果
	 */
	+ (BOOL)removeObjectWithFilePathName:(NSString *)filePathName;
	
	/**
	 保存多个数据
	
	 @param objs 多个数据数组
	 @param flag flag description
	 @param filePathName 文件名，如果传值nil，则会保存在默认的defaultPathName里
	 @return 保存状态
	 */
	+ (BOOL)saveObjects:(NSArray *)objs forFlag:(NSString*)flag withFilePathName:(NSString *)filePathName;
	
	/**
	 取多个数据
	
	 @param flag flag description
	 @param filePathName 文件名，如果传值nil，则会在默认的defaultPathName里取
	 @return 多个数据的数组
	 */
	+ (NSArray *)getObjectsForFlag:(NSString*)flag withFilePathName:(NSString *)filePathName;


####可修改`extern BOOL YBDebugAssertionsShouldBreak;`代码里的`YBDebugAssertionsShouldBreak `的值，这个值的作用是当遇到自定义的断言`YBDASSERT`时，是否需要断点定位到代码行。
