package com.funbuilder.model {
	
	import com.funrun.model.vo.BlockVO;
	
	import flash.display.Bitmap;
	
	import org.robotlegs.mvcs.Actor;
	
	public class BlocksModel extends Actor {
		
		private var _blocks:Object;
		private var _blocksArr:Array;
		private var _bitmaps:Object;
		
		public function BlocksModel() {
			super();
			_blocks = {};
			_blocksArr = [];
			_bitmaps = {};
		}
		
		public function addBlock( block:BlockVO ):void {
			_blocks[ block.id ] = block;
			_blocksArr.push( block );
		}
		
		public function addBitmap( bitmap:Bitmap, id:String ):void {
			_bitmaps[ id ] = bitmap;
		}
		
		public function getWithId( id:String ):BlockVO {
			return _blocks[ id ];
		}
		
		public function getBitmap( id:String ):Bitmap {
			return _bitmaps[ id ];
		}
		
		public function getBlockIndex( id:String ):int {
			for ( var i:int = 0; i < _blocksArr.length; i++ ) {
				if ( getAt( i ).id == id ) {
					return i;
				}
			}
			return -1;
		}
		
		public function getAt( index:int ):BlockVO {
			return _blocksArr[ index ];
		}
		
		public function get numBlocks():int {
			return _blocksArr.length;
		}
	}
}
