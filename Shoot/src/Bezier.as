package
{
	/***
	 *贝赛尔曲线
	 *@author ludingchang 时间：2013-7-30 下午1:28:46
	 */
	public class Bezier
	{
		/**一次贝塞尔曲线*/
		public static function getBezier1(p0:Number,p1:Number):Function
		{
			var f:Function=function(t:Number):Number
			{
				return p0+(p1-p0)*t;
			}
			return f; 
		}
		/**二次方贝赛尔曲线*/
		public static function getBezier2(p0:Number,p1:Number,p2:Number):Function
		{
			var f:Function=function(t:Number):Number
			{
				return (1-t)*(1-t)*p0+2*t*(1-t)*p1+t*t*p2;
			}
			return f;
		}
		/**3次方方贝塞尔曲线*/
		public static function getBezier3(p0:Number,p1:Number,p2:Number,p3:Number):Function
		{
			var f:Function=function(t:Number):Number
			{
				return p0*(1-t)*(1-t)*(1-t)+3*p1*t*(1-t)*(1-t)+3*p2*t*t*(1-t)+p3*t*t*t;
			}
			return f;
		}
		/**n次方贝赛尔曲线*/
		public static function getBezierN(ps:Vector.<Number>):Function
		{
			var n:int=ps.length-1;
			var f:Function=function(t:Number):Number
			{
				var temp:Number=0;
				for(var i:int=0;i<=n;i++)
				{
					temp+=getCnn(n,i)*ps[i]*Math.pow(t,i)*Math.pow((1-t),(n-i));
				}
				return temp;
			}
			return f;
		}
		/**二项式系数*/
		private static function getCnn(upN:int,downN:int):int
		{
			return getN1(upN)/(getN1(downN)*getN1(upN-downN));
		}
		/**阶乘 n!*/
		private static function getN1(n:int):int
		{
			var temp:int=1;
			while(n>=1)
			{
				temp*=(n--);
			}
			return temp;
		}
	}
}