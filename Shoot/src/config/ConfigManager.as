package config
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;

	/***
	 *
	 *@author ludingchang 时间：2013-7-31 下午5:44:36
	 */
	public class ConfigManager
	{
		public static function parseConfig(sp:MovieClip):void
		{
			for(var i:int=sp.numChildren-1;i>=0;i--)
			{
				var mc:MovieClip=sp as MovieClip
				var child:MovieClip=sp.getChildAt(i) as MovieClip;
				if(child.hasOwnProperty("type"))
				{
					switch(child.type)
					{
						case TypeConfig.TypeFengche:
							parseFengche(child);
							break;
						case TypeConfig.TypeStartpoint:
							ConfigALL.start_point=createShapeByUI(child,b2Body.b2_staticBody,true);
							break;
						case TypeConfig.TypeEndpoint:
							ConfigALL.end_point=createShapeByUI(child,b2Body.b2_staticBody,true);
							break;
					}
				}
				else
					parseStaticObj(child);
			}
		}
		private static function parseStaticObj(sp:MovieClip):void
		{
			createShapeByUI(sp,b2Body.b2_staticBody);
		}
		private static function parseFengche(sp:MovieClip):void
		{
			var fenche:b2Body=createShapeByUI(sp,b2Body.b2_dynamicBody);
			fenche.SetSleepingAllowed(false);
			var jont:b2RevoluteJointDef=new b2RevoluteJointDef;
			jont.Initialize(ConfigALL.world.GetGroundBody(),fenche,fenche.GetWorldCenter());
			jont.enableLimit=sp.enableAngle;
			jont.enableMotor=sp.enableMator;
			jont.maxMotorTorque=sp.maxMatorForce;
			jont.motorSpeed=sp.matorSpeed;
			jont.upperAngle=sp.maxAngle;
			jont.lowerAngle=sp.minAngle;
			jont.collideConnected=true;
			trace("jont.enableLimit="+ sp.enableAngle +
				"\njont.enableMotor="+sp.enableMator +
				"\njont.maxMotorTorque="+sp.maxMatorForce +
				"\njont.motorSpeed="+sp.matorSpeed+
				"\njont.upperAngle="+sp.maxAngle+
				"\njont.lowerAngle="+sp.minAngle);
			var j:b2RevoluteJoint=ConfigALL.world.CreateJoint(jont) as b2RevoluteJoint;
			trace("jont is active "+j.IsActive())
		}
		private  static function createShapeByUI($ui:MovieClip,$type:int,$isSensor:Boolean=false):b2Body
		{
			var bdf:b2BodyDef=new b2BodyDef;
			bdf.position.Set($ui.x/30,$ui.y/30);
			bdf.type=$type
			var body:b2Body=ConfigALL.world.CreateBody(bdf);
			var ps:Vector.<Point>=PrintGraphicData.initData($ui);
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
			fixd.userData=$ui;
			fixd.restitution=ConfigALL.wall_R;
			fixd.density=.3;
			fixd.isSensor=$isSensor;
			body.CreateFixture(fixd);
			return body;
		}
	}
}