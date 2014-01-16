package config.items
{
	import config.TypeConfig;

	/***
	 *胜利点
	 *@author ludingchang 时间：2013-11-4 下午2:51:10
	 */
	public class EndPoint
	{
		[Inspectable(defaultValue="3",name="1.类型")]
		public var type:int=TypeConfig.TypeEndpoint;
		[Inspectable(defaultValue="修改此项",name="2.id")]
		public var id:String;
	}
}