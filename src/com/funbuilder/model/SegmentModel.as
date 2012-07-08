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
		private var _namespaces:Dictionary;
		
		public function SegmentModel()
		{
			super();
			_blocks = {};
			_namespaces = new Dictionary(); 
		}
		
		public function clear():void {
			_blocks = {};
			_namespaces = new Dictionary(); 
		}
		
		public function add( block:Mesh, namespace:String ):void {
			var hash:String = makeHash( block.position );
			_blocks[ hash ] = block;
			_namespaces[ block ] = namespace;
		}
		
		public function remove( block:Mesh ):void {
			var hash:String = makeHash( block.position );
			delete _blocks[ hash ];
			delete _namespaces[ block ]; 
		}
		
		public function getObject():Object {
			return _blocks;
		}
		
		public function getAtPos( pos:Vector3D ):Mesh {
			return _blocks[ makeHash( pos ) ];
		}
		
		public function getWithKey( key:String ):Mesh {
			return _blocks[ key ];
		}
		
		private function makeHash( pos:Vector3D ):String {
			return pos.x.toString() + "," + pos.y.toString() + "," + pos.z.toString();
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
				item.x = mesh.x / 100;
				item.y = mesh.y / 100;
				item.z = mesh.z / 100;
				list.push( item );
			}
			return com.adobe.serialization.json.JSON.encode( list );
		}
	}
}