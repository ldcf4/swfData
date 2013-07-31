package
{
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import config.ConfigALL;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	/***
	 *
	 *@author ludingchang 时间：2013-7-29 下午1:40:53
	 */
	[SWF(frameRate="30",width="1024",height="1024")]
	public class Shoot extends Sprite
	{
		private var world:b2World;
		private var dbDraw:b2DebugDraw;
		private var loader:Loader;
		private var _ui:Sprite;
		private var ps:Vector.<Point>;

		private var ball:b2Body;
		
		public function Shoot()
		{
			loader=new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadeCom);
			loader.load(new URLRequest("ui/ui.swf"));
		}
		
		protected function onLoadeCom(event:Event):void
		{
			init();
			ui=loader.contentLoaderInfo.content as Sprite;
			var i:int,len:int=_ui.numChildren;
			var sp:Sprite;
			for(i=0;i<len;i++)
			{
				sp=_ui.getChildAt(i) as Sprite;
				ps=PrintGraphicData.initData(sp);
				createShapeByUI(sp.x,sp.y,ps);
			}
			
			initEvenListener();
		}
		private function initEvenListener():void
		{
			addEventListener(Event.ENTER_FRAME,eachFrame);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		private function init():void
		{
			world=new b2World(ConfigALL.grivaty,true);
			world.SetWarmStarting(true);
			ConfigALL.world=world;
			var debug:Sprite=new Sprite;
			addChild(debug);
			
			dbDraw=new b2DebugDraw;
			dbDraw.SetSprite(debug);
			dbDraw.SetDrawScale(30);
			dbDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_centerOfMassBit);
			world.SetDebugDraw(dbDraw);
			
//			crateSaveBox();
//			createWall(world_W/2,world_H/2,world_W/4,10);
			ball=createBall();
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var p:b2Vec2=ball.GetPosition();
			var p2:b2Vec2=new b2Vec2(stage.mouseX/30,stage.mouseY/30);
			p2.Subtract(p);
			p2.Normalize();
			p2.Multiply(ConfigALL.Impulse);
			ball.ApplyImpulse(p2,ball.GetWorldCenter());
			trace("ball fly");
		}
		protected function eachFrame(event:Event):void
		{
			world.Step(1/30,10,10);
			world.DrawDebugData();
		}
		
		/**
		 * 
		 * @param $x 中点X位置
		 * @param $y 中点Y位置
		 * @param $w 矩形宽
		 * @param $h 矩形高
		 * 
		 */		
		private function createWall($x:Number,$y:Number,$w:Number,$h:Number):void
		{
			var bdf:b2BodyDef=new b2BodyDef;
			bdf.position=new b2Vec2($x/30,$y/30);
			var body:b2Body=world.CreateBody(bdf);
			var shape:b2PolygonShape=new b2PolygonShape;
			shape.SetAsBox($w/2/30,$h/2/30);
			var fixD:b2FixtureDef=new b2FixtureDef;
			fixD.shape=shape;
			fixD.restitution=.5;
			body.CreateFixture(fixD);
		}
		
		private function createBall():b2Body
		{
			var bdf:b2BodyDef=new b2BodyDef;
			bdf.type=b2Body.b2_dynamicBody;
			bdf.position.Set(100/30,500/30);
			bdf.fixedRotation=false;
			bdf.allowSleep=false;
			var body:b2Body=world.CreateBody(bdf);
			var shape:b2CircleShape=new b2CircleShape(15/30);
			var fixd:b2FixtureDef=new b2FixtureDef;
			fixd.shape=shape;
			fixd.restitution=ConfigALL.ball_R;
			fixd.density=3;
			body.CreateFixture(fixd);
			return body;
		}
		private function createShapeByUI($x:Number,$y:Number,ps:Vector.<Point>):void
		{
			var bdf:b2BodyDef=new b2BodyDef;
			bdf.position.Set($x/30,$y/30);
			var body:b2Body=world.CreateBody(bdf);
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