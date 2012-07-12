package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SelectedBlocksModel extends Actor
	{
		
		private var _blocks:Array;
		private var _isMoved:Boolean = false;
		
		public function SelectedBlocksModel()
		{
			super();
			_blocks = [];
		}
		
		public function select( block:Mesh ):void {
			_blocks.push( block );
			_isMoved = false;
		}
		
		public function deselect( block:Mesh ):void {
			var picked:Mesh = null;
			var index:int = -1;
			for ( var i:int = 0; i < _blocks.length; i++ ) {
				if ( _blocks[ i ] == block ) {
					_blocks.splice( i, 1 );
					picked = block;
					index = i;
				}
			}
		}
		
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