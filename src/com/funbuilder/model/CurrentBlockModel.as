package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CurrentBlockModel extends Actor
	{
		
		private var _block:Mesh;
		private var _hasBeenMoved:Boolean = false;
		
		public function CurrentBlockModel()
		{
			super();
		}
		
		public function setBlock( block:Mesh ):void {
			_block = block;
			_hasBeenMoved = false;
		}
		
		public function clearBlock():void {
			_block = null;
		}
		
		public function hasBlock():Boolean {
			return _block;
		}
		
		public function setPosition( x:Number, y:Number, z:Number ):Boolean {
			if ( _block.x != x
				|| _block.y != y
				|| _block.z != z ) {
				_block.x = x;
				_block.y = y;
				_block.z = z;
				_hasBeenMoved = true;
				return true;
			}
			return false;
		}
		
		public function get hasBeenMoved():Boolean {
			return _hasBeenMoved;
		}
	}
}