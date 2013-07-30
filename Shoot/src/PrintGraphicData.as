package
{
	import flash.display.Graphics;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.display.IGraphicsData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/***
	 *
	 *@author ludingchang 时间：2013-7-29 下午5:58:22
	 */
	public class PrintGraphicData
	{
		public static function initData(sp:Sprite):Vector.<Point>
		{
			var g:Graphics=sp.graphics;
			var data:GraphicsPath;
			var v:Vector.<IGraphicsData>=g.readGraphicsData(true);
			var i:int,len:int=v.length;
			for(i=0;i<len;i++)
			{
				if(v[i] is GraphicsPath)
					return getGraphicsData(v[i] as GraphicsPath);
			}
			return null;
		}
		private static function getGraphicsData(data:GraphicsPath):Vector.<Point>
		{
			var x0:Number,y0:Number,y1:Number,x1:Number,x2:Number,y2:Number;
			var lax:Number,lay:Number;
			var points:Vector.<Point>=new Vector.<Point>;
			var bezierX:Function;
			var bezierY:Function;
			while(data.commands.length>0)
			{
				switch(data.commands.shift())
				{
					case GraphicsPathCommand.CUBIC_CURVE_TO:
						x0=data.data.shift();
						y0=data.data.shift();
						x1=data.data.shift();
						y1=data.data.shift();
						x2=data.data.shift();
						y2=data.data.shift();
						bezierX=Bezier.getBezier3(lax,x0,x1,x2);
						bezierY=Bezier.getBezier3(lay,y0,y1,y2);
						bezierPoint(bezierX,bezierY,points);
						points.push(new Point(x2,y2));
						lax=x2;
						lay=y2;
						break;
					case GraphicsPathCommand.CURVE_TO:
						x0=data.data.shift();
						y0=data.data.shift();
						x1=data.data.shift();
						y1=data.data.shift();
						bezierX=Bezier.getBezier2(lax,x0,x1);
						bezierY=Bezier.getBezier2(lay,y0,y1);
						bezierPoint(bezierX,bezierY,points);
						points.push(new Point(x1,y1));
						lax=x1;
						lay=y1;
						break;
					case GraphicsPathCommand.LINE_TO:
						x0=data.data.shift();
						y0=data.data.shift();
						points.push(new Point(x0,y0));
						lax=x0;
						lay=y0;
						break;
					case GraphicsPathCommand.MOVE_TO:
						x0=data.data.shift();
						y0=data.data.shift();
						points.push(new Point(x0,y0));
						lax=x0;
						lay=y0;
						break;
					case GraphicsPathCommand.NO_OP:
						break;
					case GraphicsPathCommand.WIDE_LINE_TO:
						x0=data.data.shift();
						y0=data.data.shift();
						x1=data.data.shift();
						y1=data.data.shift();
						points.push(new Point(x1,y1));
						lax=x1;
						lay=y1;
						break;
					case GraphicsPathCommand.WIDE_MOVE_TO:
						x0=data.data.shift();
						y0=data.data.shift();
						x1=data.data.shift();
						y1=data.data.shift();
						points.push(new Point(x1,y1));
						lax=x1;
						lay=y1;
						break;
				}
			}
			return points;
		}
		private static const steps:Number=.3;
		private static function bezierPoint(bezierX:Function,bezierY:Function,points:Vector.<Point>):void
		{
			for(var i:Number=steps;i<1;i+=steps)
			{
				var xx:Number=bezierX(i);
				var yy:Number=bezierY(i);
				points.push(new Point(xx,yy));
			}
		}
	}
}