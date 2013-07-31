package config
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Sprite;
	import flash.geom.Point;

	/***
	 *
	 *@author ludingchang 时间：2013-7-31 下午5:44:36
	 */
	public class ConfigManager
	{
		public static function parseConfig(sp:Sprite):void
		{
			while(sp.numChildren>0)
			{
				var child:Sprite=sp.getChildAt(0) as Sprite;
				if(child.hasOwnProperty("type"))
					parseStaticObj(ConfigALL.world,sp);
				switch(child.)
			}
		}
		private static function parseStaticObj(sp:Sprite):void
		{
			
		}
		public static function parseFengche(sp:Sprite):void
		{
			
		}
		private function createShapeByUI($x:Number,$y:Number,ps:Vector.<Point>):void
		{
			var bdf:b2BodyDef=new b2BodyDef;
			bdf.position.Set($x/30,$y/30);
			var body:b2Body=ConfigALL.world.CreateBody(bdf);
			var i:int,len:int=ps.length;
			var vs:Vector.<b2Vec2>=new Vector.<b2Vec2>(len-1);
			for(i=0;i<len-1;i++)
			{
				vs[i]=new b2Vec2(ps[i].x/30,ps[i].y/30);
			}
			var shape:b2PolygonShape=new b2PolygonShape;
			shape.SetAsVector(vs,len-1);
			var fixd:b2FixtureDef=new b2FixtureDef;
			fixd.shape=shape;
			fixd.restitution=ConfigALL.wall_R;
			body.CreateFixture(fixd);
		}
	}
}