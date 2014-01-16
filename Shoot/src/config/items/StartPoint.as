package config.items
{
	import config.TypeConfig;

	/***
	 *起点（出生点）
	 *@author ludingchang 时间：2013-11-4 下午2:44:28
	 */
	public class StartPoint
	{
		[Inspectable(defaultValue="2",name="1.类型")]
		public var type:int=TypeConfig.TypeStartpoint;
		[Inspectable(defaultValue="修改此项",name="2.id")]
		public var id:String;
	}
}