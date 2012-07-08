package com.funbuilder.model {
	
	import com.funrun.model.vo.BlockVO;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BlocksModel extends Actor {
		
		private var _blocks:Object;
		private var _blocksArr:Array;
		
		public function BlocksModel() {
			super();
			_blocks = {};
			_blocksArr = [];
		}
		
		public function addBlock( block:BlockVO ):void {
			_blocks[ block.id ] = block;
			_blocksArr.push( block );
		}
		
		public function getBlock( id:String ):BlockVO {
			return _blocks[ id ];
		}
		
		public function getBlockAt( index:int ):BlockVO {
			return _blocks[ index ];
		}
	}
}
