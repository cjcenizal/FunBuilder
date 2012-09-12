package com.funbuilder.model
{
	import com.funbuilder.model.vo.HistoryVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public class HistoryModel extends Actor
	{
		
		private var _history:Array;
		private var _index:int = 0;
		private var _canFlashSave:Boolean = true;
		
		public function HistoryModel()
		{
			super();
			_history = [];
		}
		
		public function clear():void {
			_history = [];
		}
		
		public function add( history:HistoryVo ):void {
			// If we're adding a snapshot into our history,
			// then we need to clear everything that follows.
			_history.splice( _index );
			_history.push( history );
			//if ( !flashSave ) {
				_index++;
			//}
			debug("add");
		}
		
		public function undo( newHistory:HistoryVo = null ):HistoryVo {
			// Move backwards through history.
			if ( _index > 0 ) {
				if ( _index > 0 ) _index--;
				var history:HistoryVo = _history[ _index ];
				if ( newHistory ) {
					_history.push( newHistory );
				}
				debug("undo");
				return history;
			}
			return null;
		}
		
		public function redo():HistoryVo {
			// Move forwards through history.
			if ( _index < _history.length - 1 ) {
				_index++;
				debug("redo");
				return _history[ _index ];
			}
			return null;
		}
		
		public function doesNotMatchCurrent( snapshot:String ):Boolean {
			return !_history[ _index ] || !indexIsAtLatest() || getAt( _index ).snapshot != snapshot;
		}
		
		public function getAt( index:int ):HistoryVo {
			return _history[ index ];
		}
		
		public function indexIsAtLatest():Boolean {
			return _index == _history.length;
		}
		
		private function debug( action:String ):void {
			/*
			trace(action + " -------");
			for ( var i:int = 0; i < _history.length; i++ ) {
				if ( i == _index ) {
					trace(i + " is current");
				} else {
					trace(i);
				}
				trace("   " + getAt( i ).snapshot );
			}*/
		}
	}
}