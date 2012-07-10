package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SelectedBlockModel extends Actor
	{
		
		private var _block:Mesh;
		private var _isMoved:Boolean = false;
		
		public function SelectedBlockModel()
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
		
		public function willMoveTo( position:Vector3D ):Boolean {
			return ( !_block.position.equals( position ) );
		}
		
		public function setPosition( position:Vector3D ):void {
			_block.x = position.x;
			_block.y = position.y;
			_block.z = position.z;
			_isMoved = true;
		}
		
		public function isBlock( block:Mesh ):Boolean {
			return block == _block;
		}
		
		public function get isMoved():Boolean {
			return _isMoved;
		}
		
		public function getPositionClone():Vector3D {
			return new Vector3D( _block.x, _block.y, _block.z );
		}
		
		public function getBlock():Mesh {
			return _block;
		}
	}
}