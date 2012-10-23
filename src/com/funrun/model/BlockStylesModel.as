package com.funrun.model
{
	import away3d.entities.Mesh;
	
	import com.funrun.model.vo.BlockStyleVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BlockStylesModel extends Actor
	{
		
		public var currentStyle:String;
		
		private var _styles:Object;
		
		public function BlockStylesModel()
		{
			super();
			_styles = {};
		}
		
		public function add( style:BlockStyleVo ):void {
			_styles[ style.id ] = style;
		}
		
		public function getStyle( id:String ):BlockStyleVo {
			return _styles[ id ];
		}
		
		public function getMeshCloneForBlock( id:String ):Mesh {
			return getStyle( currentStyle ).getMesh( id ).clone() as Mesh;
		}
	}
}