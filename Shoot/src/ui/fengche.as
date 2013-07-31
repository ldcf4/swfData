package ui
{
	/***
	 *
	 *@author ludingchang 时间：2013-7-31 下午5:01:01
	 */
	public class fengche
	{
		[Inspectable(defaultValue="1",name="1.类型")]
		public var type:int;
		[Inspectable(defaultValue="false",name="2.限制角度")]
		public var enableAngle:Boolean;
		[Inspectable(defaultValue="0",name="4.角度最大值")]
		public var maxAngle:Number;
		[Inspectable(defaultValue="0",name="3.角度最小值")]
		public var minAngle:Number;
		[Inspectable(defaultValue="false",name="5.马达")]
		public var enableMator:Boolean;
		[Inspectable(defaultValue="0",name="7.马达速度")]
		public var matorSpeed:Number;
		[Inspectable(defaultValue="0",name="6.马达最大扭距")]
		public var maxMatorForce:Number;
	}
}