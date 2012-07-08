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
		
		public function add( action:HistoryVO ):void {
			// If we're adding an action into the middle of our history,
			// then we need to clear everything that follows.
			if ( _index < _history.length - 1 ) {
				_history.splice( _index );
			}
			_history.push( action );
			_index++;
		}
		
		public function undo():HistoryVO {
			// Move backwards through history.
			if ( _index > 0 ) {
				var action:HistoryVO = _history[ _index ];
				_index--;
				return action;
			}
			return null;
		}
		
		public function redo():HistoryVO {
			// Move forwards through history.
			if ( _index < _history.length ) {
				var action:HistoryVO = _history[ _index ];
				_index++;
				return action;
			}
			return null;
		}
	}
}