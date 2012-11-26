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
		
		- 1) Build cool obstacles
			- Alternating converging and diverging
			- Form points into lines on obstacles
		- Derive block type and assign numerical ID (i.e. in a 3x3 cube of blocks, which type of block is it); we'll need models for each type of block in the styles
		
			- Turn off indicators for when a block is at ground level
			- Fix stacking of blocks on the ground plane
		
		
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
