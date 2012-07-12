package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SelectedBlocksModel extends Actor
	{
		
		private var _blocks:Array;
		private var _focalBlock:Mesh;
		private var _isMoved:Boolean = false;
		
		public function SelectedBlocksModel()
		{
			super();
			_blocks = [];
		}
		
		public function select( block:Mesh ):void {
			_blocks.push( block );
			_focalBlock = block;
			_isMoved = false;
		}
		
		public function deselect( block:Mesh ):Mesh {
			if ( _focalBlock == block ) {
				_focalBlock = null;
			}
			var picked:Mesh = null;
			var index:int = -1;
			for ( var i:int = 0; i < _blocks.length; i++ ) {
				if ( _blocks[ i ] == block ) {
					_blocks.splice( i, 1 );
					picked = block;
					index = i;
				}
			}
			if ( _blocks.length == 0 ) {
				_focalBlock = null;
			} else if ( index - 1 < 0 ) {
				_focalBlock = _blocks[ index ];
			} else {
				_focalBlock = _blocks[ index - 1 ];
			}
			return _focalBlock;
		}
		
		public function hasAnySelected():Boolean {
			return _blocks.length > 0;
		}
		
//		public function willMoveTo( position:Vector3D ):Boolean {
	//		return ( _focalBlock && !_focalBlock.position.equals( position ) );
		//}
		
		public function setIsMoved( isMoved:Boolean ):void {
			_isMoved = isMoved;
		}
		
		public function contains( block:Mesh ):Boolean {
			for ( var i:int = 0; i < _blocks.length; i++ ) {
				if ( _blocks[ i ] == block ) {
					return true;
				}
			}
			return false;
		}
		
//		public function getDiff( position:Vector3D ):Vector3D {
	//		return new Vector3D( position.x - _focalBlock.x, position.y - _focalBlock.y, position.z - _focalBlock.z );
		//}
		
		public function getFocalPosition():Vector3D {
			if ( _focalBlock ) {
				return _focalBlock.position;
			}
			return null;
		}
		
		public function getPositionAt( index:int ):Vector3D {
			return getBlockAt( index ).position;
		}
		
		public function getBlockAt( index:int ):Mesh {
			return ( _blocks[ index ] as Mesh );
		}
		
		public function get isMoved():Boolean {
			return _isMoved;
		}
		
		public function get numBlocks():int {
			return _blocks.length;
		}
		
	}
}