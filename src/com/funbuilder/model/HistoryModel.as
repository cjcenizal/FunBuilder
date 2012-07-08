package com.funbuilder.model
{
	import com.funbuilder.model.vo.HistoryVO;
	
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
		
		public function add( history:HistoryVO, flashSave:Boolean = false ):void {
			// If we're adding an history into the middle of our history,
			// then we need to clear everything that follows.
			if ( _index < _history.length - 1 ) {
				_history.splice( _index );
			}
			_history.push( history );
			if ( flashSave ) {
				_canFlashSave = false;
			} else {
				_canFlashSave = true;
				_index++;
			}
		}
		
		public function undo():HistoryVO {
			// Move backwards through history.
			if ( _index > 0 ) {
				if ( _index > 0 ) _index--;
				var history:HistoryVO = _history[ _index ];
				return history;
			}
			return null;
		}
		
		public function redo():HistoryVO {
			// Move forwards through history.
			if ( _index < _history.length - 1 ) {
				_index++;
				return _history[ _index ];
			}
			return null;
		}
		
		public function getCurrent():HistoryVO {
			return _history[ _index ];
		}
		
		public function canFlashSave():Boolean {
			return _canFlashSave;
		}
	}
}