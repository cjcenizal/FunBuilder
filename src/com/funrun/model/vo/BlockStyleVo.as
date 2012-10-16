package com.funrun.model.vo
{
	import away3d.entities.Mesh;
	
	import flash.display.Bitmap;

	public class BlockStyleVo
	{
		
		public var id:String;
		private var _files:Object;
		private var _meshes:Object;
		private var _meshesArr:Array;
		private var _keys:Array;
		private var _bitmaps:Object;
		
		public function BlockStyleVo( id:String, files:Object )
		{
			this.id = id;
			_files = files;
			_meshes = {};
			_meshesArr = [];
			_keys = [];
			_bitmaps = {};
			for ( var key:String in _files ) {
				_meshes[ key ] = null;
				_keys.push( key );
			}
		}
		
		public function hasMesh( id:String ):Boolean {
			return ( _meshes[ id ] );
		}
		
		public function addMesh( id:String, mesh:Mesh ):void {
			_meshes[ id ] = mesh;
			_meshesArr.push( mesh );
		}
		
		public function getMesh( id:String ):Mesh {
			return _meshes[ id ];
		}
		
		public function getFilename( id:String ):String {
			return _files[ id ];
		}
		
		public function getKeys():Array {
			return _keys.concat();
		}
		
		public function getMeshAt( index:int ):Mesh {
			return _meshesArr[ index ];
		}
		
		public function addBitmap( bitmap:Bitmap, id:String ):void {
			_bitmaps[ id ] = bitmap;
		}
		
		public function getBitmap( id:String ):Bitmap {
			return _bitmaps[ id ];
		}
		
		public function get length():int {
			return _meshesArr.length;
		}
	}
}