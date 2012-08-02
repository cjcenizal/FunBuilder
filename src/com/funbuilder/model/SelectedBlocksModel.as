package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SelectedBlocksModel extends Actor
	{
		
		private var _blocks:Array;
		private var _isMoved:Boolean = false;
		private var _centroid:Vector3D;
		private var _max:Number;
		
		private var _timeUntilMovement:int = 0;
		
		public function SelectedBlocksModel()
		{
			super();
			_blocks = [];
		}
		
		public function select( block:Mesh ):void {
			_blocks.push( block );
			_isMoved = false;
			update();
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
			update();
		}
		
		public function update():void {
			calculateCentroid();
			calculateMax();
		}
		
		private function calculateCentroid():void {
			var len:Number = _blocks.length;
			_centroid = new Vector3D();
			for ( var i:int = 0; i < len; i++ ) {
				_centroid.incrementBy( getPositionAt( i ) );
			}
			_centroid.scaleBy( 1 / len );
		}
		
		private function calculateMax():void {
			var len:Number = _blocks.length;
			var pos:Vector3D;
			_max = 0;
			for ( var i:int = 0; i < len; i++ ) {
				pos = getPositionAt( i );
				_max = Math.max( _max, Math.abs( pos.x ) - Math.abs( _centroid.x ) );
				_max = Math.max( _max, Math.abs( pos.y ) - Math.abs( _centroid.y ) );
				_max = Math.max( _max, Math.abs( pos.z ) - Math.abs( _centroid.z ) );
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
		
		public function get centroid():Vector3D {
			return _centroid;
		}
		
		public function get max():Number {
			return _max;
		}
		
		public function resetTimeUntilMovement():void {
			_timeUntilMovement = 10;
		}
		
		public function get timeUntilMovement():int {
			if ( _timeUntilMovement > 0 ) _timeUntilMovement--;
			return _timeUntilMovement; 
		}
		
	}
}