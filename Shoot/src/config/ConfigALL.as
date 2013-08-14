package config
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;

	/***
	 *全局配置
	 *@author ludingchang 时间：2013-7-31 下午5:59:20
	 */
	public class ConfigALL
	{
		public static var world:b2World;
		
		public static const grivaty:b2Vec2=new b2Vec2(0,10);
		public static const world_W:Number=750;
		public static const world_H:Number=550;
		public static const Impulse:Number=100;
		/**墙反弹力*/
		public static const wall_R:Number=.9;
		/**球反弹力*/
		public static const ball_R:Number=.9;
	}
}