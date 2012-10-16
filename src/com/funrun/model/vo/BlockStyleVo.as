package com.funrun.model.vo
{
	import away3d.entities.Mesh;

	public class BlockStyleVo
	{
		
		public var id:String;
		private var _files:Object;
		private var _meshes:Object;
		private var _keys:Array;
		
		public function BlockStyleVo( id:String, files:Object )
		{
			this.id = id;
			_files = files;
			_meshes = {};
			_keys = [];
			for ( var key:String in _files ) {
				_meshes[ key ] = null;
				_keys.push( key );
			}
		}
		
		public function addMesh( id:String, mesh:Mesh ):void {
			if ( _meshes[ id ] ) {
				_meshes[ id ] = mesh;
			}
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
	}
}