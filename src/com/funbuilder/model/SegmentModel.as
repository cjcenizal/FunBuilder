package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import com.adobe.serialization.json.JSON;
	
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
		private var _id:int = 0;
		private var _namespaces:Dictionary;
		private var _elevationMap:Dictionary;
		private var _elevationKeys:Object;
		
		public function SegmentModel()
		{
			super();
			_blocks = new Dictionary();
			_namespaces = new Dictionary(); 
			_elevationMap = new Dictionary();
			_elevationKeys = {};
		}
		
		public function clear():void {
			_id = 0;
			_blocks = new Dictionary();
			_namespaces = new Dictionary();
			_elevationMap = new Dictionary();
			_elevationKeys = {};
		}
		
		public function add( block:Mesh, namespace:String, id:String ):String {
			// Assign new id if needed.
			if ( !id || int( id ) < _id ) {
				id = _id.toString();
				_id++;
			}
			// If incoming IDs are higher than existing ones,
			// we need to get with the program.
			if ( id && int( id ) > _id ) {
				_id = int( id ) + 1;
			}
			_blocks[ id ] = block;
			_namespaces[ block ] = namespace;
			addElevation( block.position );
			return id;
		}
		
		public function move( from:Vector3D, to:Vector3D ):void {
			removeElevation( from );
			addElevation( to );
		}
		
		private function removeElevation( pos:Vector3D ):void {
			var key:Vector3D = getKey( pos );
			_elevationMap[ key ] --;
		}
		
		private function addElevation( pos:Vector3D ):void {
			var key:Vector3D = getKey( pos );
			if ( !_elevationMap[ key ] ) {
				_elevationMap[ key ] = 1;
			} else {
				_elevationMap[ key ] ++;
			}
		}
		
		private function getKey( pos:Vector3D ):Vector3D {
			var key:String = pos.x + "," + pos.z;
			if ( !_elevationKeys[ key ] ) {
				_elevationKeys[ key ] = pos.clone();
			}
			return _elevationKeys[ key ];
		}
		
		public function remove( block:Mesh ):void {
			for ( var key:String in _blocks ) {
				if ( _blocks[ key ] == block ) {
					delete _blocks[ key ];
				}
			}
			delete _namespaces[ block ]; 
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
		
		public function getKeyFor( block:Mesh ):String {
			for ( var key:String in _blocks ) {
				if ( _blocks[ key ] == block ) {
					return key;
				}
			}
			return null;
		}
		
		public function getIdFor( block:Mesh ):String {
			return _namespaces[ block ];
		}
		
		public function getJson():String {
			var list:Array = [];
			var mesh:Mesh;
			var name:String;
			var item:Object;
			for ( var key:String in _blocks ) {
				mesh = getWithKey( key );
				name = _namespaces[ mesh ];
				item = {};
				item.id = name;
				item.key = key;
				item.x = mesh.x / 100;
				item.y = mesh.y / 100;
				item.z = mesh.z / 100;
				list.push( item );
			}
			return com.adobe.serialization.json.JSON.encode( list );
		}
		
		public function getElevationMap():Dictionary {
			return _elevationMap;
		}
	}
}