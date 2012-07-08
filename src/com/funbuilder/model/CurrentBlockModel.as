package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CurrentBlockModel extends Actor
	{
		
		private var _block:Mesh;
		
		public function CurrentBlockModel()
		{
			super();
		}
		
		public function setBlock( block:Mesh ):void {
			_block = block;
		}
		
		public function clearBlock():void {
			_block = null;
		}
		
		public function hasBlock():Boolean {
			return _block;
		}
		
		public function setPosition( x:Number, y:Number, z:Number ):void {
			_block.x = x;
			_block.y = y;
			_block.z = z;
		}
	}
}