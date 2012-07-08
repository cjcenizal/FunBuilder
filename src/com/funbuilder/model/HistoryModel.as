package com.funbuilder.model
{
	import com.funbuilder.model.vo.HistoryVO;
	
	import org.robotlegs.mvcs.Actor;
	
	public class HistoryModel extends Actor
	{
		
		private var _history:Array;
		private var _index:int = -1;
		
		public function HistoryModel()
		{
			super();
			_history = [];
		}
		
		public function add( history:HistoryVO ):void {
			// If we're adding an history into the middle of our history,
			// then we need to clear everything that follows.
			if ( _index < _history.length - 1 ) {
				_history.splice( _index );
			}
			_history.push( history );
			_index++;
		}
		
		public function undo( offset:int = 0 ):HistoryVO {
			_index += offset;
			// Move backwards through history.
			if ( _index >= 0 ) {
				var history:HistoryVO = _history[ _index ];
				_index--;
				return history;
			}
			return null;
		}
		
		public function redo():HistoryVO {
			// Move forwards through history.
			if ( _index < _history.length ) {
				_index++;
				return _history[ _index ];
			}
			return null;
		}
		
		public function getCurrent():HistoryVO {
			return _history[ _index ];
		}
		
		public function indexIsAtEnd():Boolean {
			return _index == _history.length - 1;
		}
	}
}