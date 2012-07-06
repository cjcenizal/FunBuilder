package {

	import com.funbuilder.MainContext;
	import com.funbuilder.view.components.MainView;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;

	public class FunBuilder extends Sprite {
		
		private var _mainContext:MainContext;
		private var _mainView:MainView;

		public function FunBuilder() {
			super();
			addEventListener( Event.ADDED_TO_STAGE, init );
		}

		private function init( e:Event = null ):void {
			removeEventListener( Event.ADDED_TO_STAGE, init );
			setupStage();
			_mainContext = new MainContext( this, false );
			_mainContext.startup();
		}

		public function createChildren():void {
			trace(createChildren);
			_mainView = new MainView( this );
		}

		private function setupStage():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.BEST;
			stage.nativeWindow.width = 2100;
			stage.nativeWindow.height = 1300;
		}
	}
}
