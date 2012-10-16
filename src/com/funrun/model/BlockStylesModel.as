package com.funrun.model
{
	import com.funrun.model.vo.BlockStyleVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BlockStylesModel extends Actor
	{
		
		private var _styles:Object;
		
		public function BlockStylesModel()
		{
			super();
			_styles = {};
		}
		
		public function add( style:BlockStyleVo ):void {
			_styles[ style.id ] = _styles;
		}
		
		public function getStyle( id:String ):BlockStyleVo {
			return _styles[ id ];
		}
	}
}