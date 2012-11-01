package com.funrun.services.parsers {
	
	import com.funrun.model.vo.BlockStyleVo;
	
	public class BlockStyleParser {
		
		private const BLOCKS:String = "blocks";
		
		public function BlockStyleParser() {
		}
		
		public function parse( data:Object ):BlockStyleVo {
			var id:String = new IdParser( data ).id;
			var meshes:Object = data[ BLOCKS ] || {};
			return new BlockStyleVo( id, meshes );
		}
	}
}