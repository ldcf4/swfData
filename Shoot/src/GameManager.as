package
{
	import flash.display.Stage;
	import flash.text.TextField;

	/***
	 *
	 *@author ludingchang 时间：2013-11-4 下午3:19:03
	 */
	public class GameManager
	{
		private static var _inst:GameManager;
		public static function get Instence():GameManager
		{
			return _inst||=new GameManager;
		}
		private var _txt:TextField;
		public function init($stage:Stage):void
		{
			_txt=new TextField;
			$stage.addChild(_txt);
			_txt.x=$stage.stageWidth/2;
			_txt.y=$stage.stageHeight/2;
			_txt.mouseEnabled=false;
			_txt.selectable=false;
			_txt.visible=false;
		}
		/**游戏胜利*/
		public function showWin():void
		{
			_txt.text="游戏胜利";
			_txt.visible=true;
		}
	}
}