package
{
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.b2ContactListener;
	
	import config.TypeConfig;
	
	import flash.display.MovieClip;
	
	/***
	 *碰撞回调
	 *@author ludingchang 时间：2013-11-4 下午3:09:23
	 */
	public class ConactListener extends b2ContactListener
	{
		public function ConactListener()
		{
			super();
		}
		/**碰撞发生时*/
		public override function BeginContact(contact:b2Contact):void
		{
			var itemA:Object=contact.GetFixtureA().GetUserData();
			var itemB:Object=contact.GetFixtureB().GetUserData();
			if((itemA.type==TypeConfig.TypeBall&&itemB.type==TypeConfig.TypeEndpoint)
			||(itemA.type==TypeConfig.TypeEndpoint&&itemB.type==TypeConfig.TypeBall))
				GameManager.Instence.showWin();
		}
	}
}