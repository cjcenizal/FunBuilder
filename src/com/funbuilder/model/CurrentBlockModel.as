package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class CurrentBlockModel extends Actor
	{
		
		private var _block:Mesh;
		private var _isMoved:Boolean = false;
		
		public function CurrentBlockModel()
		{
			super();
		}
		
		public function setBlock( block:Mesh ):void {
			_block = block;
			_isMoved = false;
		}
		
		public function clearBlock():void {
			_block = null;
		}
		
		public function hasBlock():Boolean {
			return _block;
		}
		
		public function willMove( position:Vector3D ):Boolean {
			return ( _block.x != position.x
				|| _block.y != position.y
				|| _block.z != position.z );
		}
		
		public function setPosition( position:Vector3D ):void {
			_block.x = position.x;
			_block.y = position.y;
			_block.z = position.z;
			_isMoved = true;
		}
		
		public function get isMoved():Boolean {
			return _isMoved;
		}
	}
}