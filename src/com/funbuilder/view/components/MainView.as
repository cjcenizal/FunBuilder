package com.funbuilder.view.components {
	
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;
	
	import com.bit101.components.Component;
	import com.bit101.components.Panel;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	public class MainView extends Component {
		
		private var _view:View3D;
		private var _isDebugging:Boolean = false;
		private var _awayStats:AwayStats;
		private var _bg:Panel;
		private var _menuBar:MenuBarView;
		
		public function MainView( parent:DisplayObjectContainer = null, x:Number = 0, y:Number = 0 ) {
			super( parent, x, y );
		}
		
		override protected function init():void {
			super.init();
			_bg = new Panel( this );
			_menuBar = new MenuBarView( this );
			this.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		private function onAddedToStage( e:Event ):void {
			_bg.setSize( stage.stageWidth, 20 );
		}
		
		/**
		 * Add debugging UI.
		 */
		public function debug( doDebug:Boolean ):void {
			_isDebugging = doDebug;
			if ( !_isDebugging ) {
				if ( _awayStats ) {
					_awayStats.registerView( null );
					removeChild( _awayStats );
					_awayStats = null;
				}
			} else {
				if ( !_awayStats ) {
					_awayStats = new AwayStats( _view );
					addChild( _awayStats );
					_awayStats.y = stage.stageHeight - _awayStats.height;
				}
			}
		}
		
		public function set view3D( view:View3D ):void {
			trace("remove view");
			if ( _view ) {
				removeChild( _view );
				_view = null;
			}
			if ( view ) {
				trace("add view");
				_view = view;
				addChild( _view );
				_view.y = 20;
				if ( _awayStats ) {
					_awayStats.registerView( _view );
				}
			}
		}
	}
}
