package com.funbuilder.model
{
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	
	import com.adobe.serialization.json.JSON;
	import com.funbuilder.model.constants.SegmentConstants;
	
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * CurrentSegmentModel contains the current segment
	 * the user is editing.
	 */
	public class SegmentModel extends Actor
	{
		
		private var _blocks:Dictionary;
		private var _blocksArr:Array;
		private var _indicators:Dictionary;
		private var _nextKey:int = 0;
		private var _elevationMap:Dictionary;
		private var _elevationKeys:Object;
		
		private var _indicatorGeometry:CubeGeometry = new CubeGeometry( 110, 110, 110 );
		
		public function SegmentModel()
		{
			super();
			_blocks = new Dictionary();
			_blocksArr = new Array();
			_indicators = new Dictionary(); 
			_elevationMap = new Dictionary();
			_elevationKeys = {};
		}
		
		public function clear():void {
			_nextKey = 0;
			_blocks = new Dictionary();
			_indicators = new Dictionary();
			_elevationMap = new Dictionary();
			_elevationKeys = {};
		}
		
		public function add( block:Mesh, indicator:Mesh, key:String ):String {
			// Assign new id if needed.
			if ( !key || int( key ) < _nextKey ) {
				key = _nextKey.toString();
				_nextKey++;
			}
			// If incoming IDs are higher than existing ones,
			// we need to get with the program.
			if ( key && int( key ) >= _nextKey ) {
				_nextKey = int( key ) + 1;
			}
			_blocks[ key ] = block;
			_blocksArr.push( block );
			_indicators[ block ] = indicator;
			addElevation( block.position );
			
			return key;
		}
		
		public function remove( block:Mesh ):void {
			var len:int = _blocksArr.length;
			for ( var i:int = 0; i < len; i++ ) {
				if ( _blocksArr[ i ] == block ) {
					_blocksArr.splice( i, 1 );
					break;
				}
			}
			for ( var key:String in _blocks ) {
				if ( _blocks[ key ] == block ) {
					delete _blocks[ key ];
				}
			}
			delete _indicators[ block ];
			removeElevation( block.position );
		}
		
		public function moveElevationPosition( from:Vector3D, to:Vector3D ):void {
			removeElevation( from );
			addElevation( to );
		}
		
		private function removeElevation( pos:Vector3D ):void {
			var key:Vector3D = getElevationKey( pos );
			var arr:Array = _elevationMap[ key ];
			for ( var i:int = 0; i < arr.length; i++ ) {
				if ( pos.equals( arr[ i ] ) ) {
					arr.splice( i, 1 );
					return;
				}
			}
		}
		
		private function addElevation( pos:Vector3D ):void {
			var key:Vector3D = getElevationKey( pos );
			if ( !_elevationMap[ key ] ) {
				_elevationMap[ key ] = [];
			}
			_elevationMap[ key ].push( pos );
		}
		
		private function getElevationKey( pos:Vector3D ):Vector3D {
			var key:String = pos.x + "," + pos.z;
			if ( !_elevationKeys[ key ] ) {
				_elevationKeys[ key ] = pos.clone();
			}
			return _elevationKeys[ key ];
		}
		
		public function getKeys():Array {
			var keys:Array = [];
			for ( var key:String in _blocks ) {
				keys.push( key );
			}
			return keys;
		}
		
		public function getWithKey( key:String ):Mesh {
			return _blocks[ key ];
		}
		
		public function getAt( index:int ):Mesh {
			return _blocksArr[ index ];
		}
		
		public function getKeyFor( block:Mesh ):String {
			for ( var key:String in _blocks ) {
				if ( _blocks[ key ] == block ) {
					return key;
				}
			}
			return null;
		}
		
		public function getIndicatorFor( block:Mesh ):Mesh {
			return _indicators[ block ];
		}
		
		public function enableIndicatorFor( block:Mesh, enabled:Boolean = true, isColliding:Boolean = false ):void {
			var indicator:Mesh = getIndicatorFor( block );
			( indicator.material as ColorMaterial ).alpha = ( enabled ) ? .5 : 0;
			( indicator.material as ColorMaterial ).color = ( isColliding ) ? 0xff0000 : 0xffff00;
		}
		
		public function getJson():String {
			var list:Array = [];
			var mesh:Mesh;
			var name:String;
			var item:Object;
			for ( var key:String in _blocks ) {
				mesh = getWithKey( key );
				name = mesh.name;
				item = {};
				item.id = name;
				item.x = mesh.x / SegmentConstants.BLOCK_SIZE;
				item.y = mesh.y / SegmentConstants.BLOCK_SIZE;
				item.z = mesh.z / SegmentConstants.BLOCK_SIZE;
				list.push( item );
			}
			return com.adobe.serialization.json.JSON.encode( list );
		}
		
		public function getElevationMap():Dictionary {
			return _elevationMap;
		}
		
		public function getNewIndicatorMesh():Mesh {
			return new Mesh( _indicatorGeometry, new ColorMaterial( 0xFFFF00, 0 ) );
		}
		
		public function getMaxElevationAt( pos:Vector3D ):Number {
			var key:Vector3D = getElevationKey( pos );
			var arr:Array = _elevationMap[ key ];
			var pos:Vector3D;
			var y:Number = 0;
			if ( arr ) {
				for ( var i:int = 0; i < arr.length; i++ ) {
					pos = arr[ i ];
					y = Math.max( y, pos.y );
				}
				y += SegmentConstants.BLOCK_SIZE;
			}
			return y;
		}
		
		public function get numBlocks():int {
			return _blocksArr.length;
		}
	}
}