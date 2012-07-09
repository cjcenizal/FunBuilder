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
		
		private var _blocks:Object;
		private var _id:int = 0;
		private var _namespaces:Dictionary;
		
		public function SegmentModel()
		{
			super();
			_blocks = {};
			_namespaces = new Dictionary(); 
		}
		
		public function clear():void {
			_id = 0;
			_blocks = {};
			_namespaces = new Dictionary(); 
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
			trace("store block at: " + id);
			_blocks[ id ] = block;
			trace(getWithKey(id));
			_namespaces[ block ] = namespace;
			return id;
		}
		
		public function remove( block:Mesh ):void {
			for ( var key:String in _blocks ) {
				if ( _blocks[ key ] == block ) {
					delete _blocks[ key ];
					break;
				}
			}
			delete _namespaces[ block ]; 
		}
		
		public function getObject():Object {
			return _blocks;
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
	}
}