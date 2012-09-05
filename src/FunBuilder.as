package {

	import com.bit101.components.Style;
	import com.funbuilder.MainContext;
	import com.funbuilder.view.components.MainView;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.external.ExternalInterface;

	public class FunBuilder extends Sprite {
		
		/*
		
		TO-DO:
			- Make colored blocks that represent each type of block we need
			- Store floor as part of obstacle.
			- This might cause performance problems. Can meshes be merged and still be interactive?
			- Represent with matching colored bounding boxes
			- Add points block
			- Build cool obstacles
		
		
		// UX:
		// Fix history in general (and add history to deselect all blocks command)
		
		// Rotate selection.
		
		// Changing block types (depends on OBJ fix).
		
		// New/open/exit should all prompt a save if unsaved
		
		
		// On save, auto-check and remove colliding blocks.
		
		
		// "Thank you! Just for playing, you get 50 credits for free!"
		// Refer to Sonic racing game
		// Photonic
		
		
		
		
		
		*/
		
		private var _mainContext:MainContext;
		private var _mainView:MainView;

		public function FunBuilder() {
			super();
			Style.setStyle( Style.DARK );
			addEventListener( Event.ADDED_TO_STAGE, init );
		}

		private function init( e:Event = null ):void {
			removeEventListener( Event.ADDED_TO_STAGE, init );
			setupStage();
			_mainContext = new MainContext( this, false );
			_mainContext.startup();
		}

		public function createChildren():void {
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
