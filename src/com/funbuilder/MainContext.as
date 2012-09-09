package com.funbuilder
{
	import com.funbuilder.controller.commands.AddBlockCommand;
	import com.funbuilder.controller.commands.AddHistoryCommand;
	import com.funbuilder.controller.commands.AddObjectToSceneCommand;
	import com.funbuilder.controller.commands.BrushBlockCommand;
	import com.funbuilder.controller.commands.ChangeBlockTypeCommand;
	import com.funbuilder.controller.commands.ClearHistoryCommand;
	import com.funbuilder.controller.commands.ClearSegmentCommand;
	import com.funbuilder.controller.commands.ClickBlockCommand;
	import com.funbuilder.controller.commands.DeleteBlockCommand;
	import com.funbuilder.controller.commands.DeselectAllBlocksCommand;
	import com.funbuilder.controller.commands.DeselectBlockCommand;
	import com.funbuilder.controller.commands.DeselectBrushCommand;
	import com.funbuilder.controller.commands.FillFloorCommand;
	import com.funbuilder.controller.commands.GrabHandleCommand;
	import com.funbuilder.controller.commands.InitAppCommand;
	import com.funbuilder.controller.commands.InvalidateHudCommand;
	import com.funbuilder.controller.commands.InvalidateSavedFileCommand;
	import com.funbuilder.controller.commands.KeyDownCommand;
	import com.funbuilder.controller.commands.KeyUpCommand;
	import com.funbuilder.controller.commands.LoadSegmentCommand;
	import com.funbuilder.controller.commands.MouseDownCommand;
	import com.funbuilder.controller.commands.MouseMoveCommand;
	import com.funbuilder.controller.commands.MouseOutBlockCommand;
	import com.funbuilder.controller.commands.MouseOverBlockCommand;
	import com.funbuilder.controller.commands.MouseUpCommand;
	import com.funbuilder.controller.commands.MoveBlocksCommand;
	import com.funbuilder.controller.commands.NewFileCommand;
	import com.funbuilder.controller.commands.OpenFileCommand;
	import com.funbuilder.controller.commands.RedoEditCommand;
	import com.funbuilder.controller.commands.RemoveBlockCommand;
	import com.funbuilder.controller.commands.RemoveObjectFromSceneCommand;
	import com.funbuilder.controller.commands.RightMouseDownCommand;
	import com.funbuilder.controller.commands.RightMouseUpCommand;
	import com.funbuilder.controller.commands.SaveFileCommand;
	import com.funbuilder.controller.commands.ScrollWheelCommand;
	import com.funbuilder.controller.commands.SelectBlockCommand;
	import com.funbuilder.controller.commands.SelectBrushCommand;
	import com.funbuilder.controller.commands.StageClickCommand;
	import com.funbuilder.controller.commands.UndoEditCommand;
	import com.funbuilder.controller.commands.UpdateBrushCommand;
	import com.funbuilder.controller.commands.UpdateCollisionsCommand;
	import com.funbuilder.controller.commands.UpdateElevationCommand;
	import com.funbuilder.controller.commands.UpdateGrabbedBlocksCommand;
	import com.funbuilder.controller.commands.UpdateHandlesCommand;
	import com.funbuilder.controller.signals.AddBlockRequest;
	import com.funbuilder.controller.signals.AddHistoryRequest;
	import com.funbuilder.controller.signals.AddItemToLibraryRequest;
	import com.funbuilder.controller.signals.AddObjectToSceneRequest;
	import com.funbuilder.controller.signals.AddView3DRequest;
	import com.funbuilder.controller.signals.BrushBlockRequest;
	import com.funbuilder.controller.signals.ChangeBlockTypeRequest;
	import com.funbuilder.controller.signals.ClearHistoryRequest;
	import com.funbuilder.controller.signals.ClearSegmentRequest;
	import com.funbuilder.controller.signals.ClickBlockRequest;
	import com.funbuilder.controller.signals.DeleteBlockRequest;
	import com.funbuilder.controller.signals.DeselectAllBlocksRequest;
	import com.funbuilder.controller.signals.DeselectBlockRequest;
	import com.funbuilder.controller.signals.DeselectBrushRequest;
	import com.funbuilder.controller.signals.DrawHandlesRequest;
	import com.funbuilder.controller.signals.FillFloorRequest;
	import com.funbuilder.controller.signals.GrabHandleRequest;
	import com.funbuilder.controller.signals.HideHandlesRequest;
	import com.funbuilder.controller.signals.InvalidateHudRequest;
	import com.funbuilder.controller.signals.InvalidateSavedFileRequest;
	import com.funbuilder.controller.signals.KeyDownRequest;
	import com.funbuilder.controller.signals.KeyUpRequest;
	import com.funbuilder.controller.signals.LoadSegmentRequest;
	import com.funbuilder.controller.signals.MouseDownRequest;
	import com.funbuilder.controller.signals.MouseMoveRequest;
	import com.funbuilder.controller.signals.MouseOutBlockRequest;
	import com.funbuilder.controller.signals.MouseOverBlockRequest;
	import com.funbuilder.controller.signals.MouseUpRequest;
	import com.funbuilder.controller.signals.MoveBlocksRequest;
	import com.funbuilder.controller.signals.NewFileRequest;
	import com.funbuilder.controller.signals.OpenFileRequest;
	import com.funbuilder.controller.signals.RedoEditRequest;
	import com.funbuilder.controller.signals.RemoveBlockRequest;
	import com.funbuilder.controller.signals.RemoveObjectFromSceneRequest;
	import com.funbuilder.controller.signals.RightMouseDownRequest;
	import com.funbuilder.controller.signals.RightMouseUpRequest;
	import com.funbuilder.controller.signals.SaveFileRequest;
	import com.funbuilder.controller.signals.ScrollWheelRequest;
	import com.funbuilder.controller.signals.SelectBlockRequest;
	import com.funbuilder.controller.signals.SelectBrushRequest;
	import com.funbuilder.controller.signals.ShowFileNameRequest;
	import com.funbuilder.controller.signals.ShowSelectionIndicatorRequest;
	import com.funbuilder.controller.signals.StageClickRequest;
	import com.funbuilder.controller.signals.ToggleLibraryRequest;
	import com.funbuilder.controller.signals.UndoEditRequest;
	import com.funbuilder.controller.signals.UpdateBrushRequest;
	import com.funbuilder.controller.signals.UpdateCollisionsRequest;
	import com.funbuilder.controller.signals.UpdateElevationRequest;
	import com.funbuilder.controller.signals.UpdateGrabbedBlocksRequest;
	import com.funbuilder.controller.signals.UpdateHandlesRequest;
	import com.funbuilder.model.BlocksModel;
	import com.funbuilder.model.BrushModel;
	import com.funbuilder.model.CameraTargetModel;
	import com.funbuilder.model.ElevationModel;
	import com.funbuilder.model.FileModel;
	import com.funbuilder.model.HandlesModel;
	import com.funbuilder.model.HistoryModel;
	import com.funbuilder.model.HudModel;
	import com.funbuilder.model.KeyboardModel;
	import com.funbuilder.model.LightsModel;
	import com.funbuilder.model.MouseModel;
	import com.funbuilder.model.SegmentModel;
	import com.funbuilder.model.SelectedBlocksModel;
	import com.funbuilder.model.TimeModel;
	import com.funbuilder.model.View3dModel;
	import com.funbuilder.view.components.LibraryView;
	import com.funbuilder.view.components.MainView;
	import com.funbuilder.view.components.MenuBarView;
	import com.funbuilder.view.mediators.AppMediator;
	import com.funbuilder.view.mediators.LibraryMediator;
	import com.funbuilder.view.mediators.MainMediator;
	import com.funbuilder.view.mediators.MenuBarMediator;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import org.robotlegs.mvcs.SignalContext;
	
	public class MainContext extends SignalContext {
		
		public function MainContext( contextView:DisplayObjectContainer, autoStartup:Boolean ) {
			super( contextView, autoStartup );
		}
		
		override public function startup():void {
			
			// Map models.
			injector.mapSingleton( BlocksModel );
			injector.mapSingleton( BrushModel );
			injector.mapSingleton( CameraTargetModel );
			injector.mapSingleton( ElevationModel );
			injector.mapSingleton( FileModel );
			injector.mapSingleton( HandlesModel );
			injector.mapSingleton( HistoryModel );
			injector.mapSingleton( HudModel );
			injector.mapSingleton( KeyboardModel );
			injector.mapSingleton( LightsModel );
			injector.mapSingleton( MouseModel );
			injector.mapSingleton( TimeModel );
			injector.mapSingleton( SegmentModel );
			injector.mapSingleton( SelectedBlocksModel );
			injector.mapSingleton( View3dModel );
			
			// Map services.
			//injector.mapSingleton( MatchmakingService );
			
			// Map signals.
			injector.mapSingleton( AddItemToLibraryRequest );
			injector.mapSingleton( AddView3DRequest );
			injector.mapSingleton( DrawHandlesRequest );
			injector.mapSingleton( HideHandlesRequest );
			injector.mapSingleton( ShowFileNameRequest );
			injector.mapSingleton( ToggleLibraryRequest );
			injector.mapSingleton( ShowSelectionIndicatorRequest );
			signalCommandMap.mapSignalClass( AddBlockRequest,						AddBlockCommand );
			signalCommandMap.mapSignalClass( BrushBlockRequest,			BrushBlockCommand );
			signalCommandMap.mapSignalClass( AddHistoryRequest,						AddHistoryCommand );
			signalCommandMap.mapSignalClass( AddObjectToSceneRequest,				AddObjectToSceneCommand );
			signalCommandMap.mapSignalClass( ChangeBlockTypeRequest,				ChangeBlockTypeCommand );
			signalCommandMap.mapSignalClass( ClearHistoryRequest,					ClearHistoryCommand );
			signalCommandMap.mapSignalClass( ClearSegmentRequest,					ClearSegmentCommand );
			signalCommandMap.mapSignalClass( ClickBlockRequest,						ClickBlockCommand );
			signalCommandMap.mapSignalClass( DeleteBlockRequest,					DeleteBlockCommand );
			signalCommandMap.mapSignalClass( DeselectAllBlocksRequest,				DeselectAllBlocksCommand );
			signalCommandMap.mapSignalClass( DeselectBlockRequest,					DeselectBlockCommand );
			signalCommandMap.mapSignalClass( DeselectBrushRequest,					DeselectBrushCommand );
			signalCommandMap.mapSignalClass( FillFloorRequest,						FillFloorCommand );
			signalCommandMap.mapSignalClass( GrabHandleRequest,						GrabHandleCommand );
			signalCommandMap.mapSignalClass( InvalidateHudRequest,					InvalidateHudCommand );
			signalCommandMap.mapSignalClass( InvalidateSavedFileRequest,			InvalidateSavedFileCommand );
			signalCommandMap.mapSignalClass( KeyDownRequest,						KeyDownCommand );
			signalCommandMap.mapSignalClass( KeyUpRequest,							KeyUpCommand );
			signalCommandMap.mapSignalClass( LoadSegmentRequest,					LoadSegmentCommand );
			signalCommandMap.mapSignalClass( MouseDownRequest,						MouseDownCommand );
			signalCommandMap.mapSignalClass( MouseOutBlockRequest,					MouseOutBlockCommand );
			signalCommandMap.mapSignalClass( MouseOverBlockRequest,					MouseOverBlockCommand );
			signalCommandMap.mapSignalClass( MouseMoveRequest,						MouseMoveCommand );
			signalCommandMap.mapSignalClass( MouseUpRequest,						MouseUpCommand );
			signalCommandMap.mapSignalClass( RightMouseDownRequest,					RightMouseDownCommand );
			signalCommandMap.mapSignalClass( RightMouseUpRequest,					RightMouseUpCommand );
			signalCommandMap.mapSignalClass( MoveBlocksRequest,						MoveBlocksCommand );
			signalCommandMap.mapSignalClass( NewFileRequest,						NewFileCommand );
			signalCommandMap.mapSignalClass( OpenFileRequest,						OpenFileCommand );
			signalCommandMap.mapSignalClass( RedoEditRequest,						RedoEditCommand );
			signalCommandMap.mapSignalClass( RemoveBlockRequest,					RemoveBlockCommand );
			signalCommandMap.mapSignalClass( RemoveObjectFromSceneRequest,			RemoveObjectFromSceneCommand );
			signalCommandMap.mapSignalClass( SaveFileRequest,						SaveFileCommand );
			signalCommandMap.mapSignalClass( ScrollWheelRequest,					ScrollWheelCommand );
			signalCommandMap.mapSignalClass( SelectBlockRequest,					SelectBlockCommand );
			signalCommandMap.mapSignalClass( SelectBrushRequest,					SelectBrushCommand );
			signalCommandMap.mapSignalClass( StageClickRequest,						StageClickCommand );
			signalCommandMap.mapSignalClass( UndoEditRequest,						UndoEditCommand );
			signalCommandMap.mapSignalClass( UpdateBrushRequest,					UpdateBrushCommand );
			signalCommandMap.mapSignalClass( UpdateCollisionsRequest,				UpdateCollisionsCommand );
			signalCommandMap.mapSignalClass( UpdateElevationRequest,				UpdateElevationCommand );
			signalCommandMap.mapSignalClass( UpdateGrabbedBlocksRequest,			UpdateGrabbedBlocksCommand );
			signalCommandMap.mapSignalClass( UpdateHandlesRequest,					UpdateHandlesCommand );
			
			// Map views to mediators.
			mediatorMap.mapView( LibraryView, 					LibraryMediator );
			mediatorMap.mapView( MainView, 						MainMediator );
			mediatorMap.mapView( MenuBarView,					MenuBarMediator );
			
			// Do this last, since it causes our entire view system to be built.
			mediatorMap.mapView( FunBuilder, 					AppMediator );
			
			// Kick everything off one frame later.
			this.contextView.addEventListener( Event.ENTER_FRAME, onEnterFrame );
			
			super.startup();
		}
		
		private function onEnterFrame( e:Event ):void {
			this.contextView.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
			commandMap.execute( InitAppCommand );
		}
	}
}
