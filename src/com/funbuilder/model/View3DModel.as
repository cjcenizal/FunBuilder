package com.funbuilder.model {
	
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.Scene3D;
	import away3d.containers.View3D;
	import away3d.controllers.HoverController;
	import away3d.entities.Mesh;
	
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	import org.robotlegs.mvcs.Actor;
	
	public class View3dModel extends Actor {
		
		private var _view:View3D;
		private var _scene:Scene3D;
		private var _camera:Camera3D;
		private var _cameraOffsetY:Number = 0;
		public var cameraController:HoverController;
		public var groundPlane:Mesh;
		
		// Camera control.
		public var lastPanAngle:Number;
		public var lastTiltAngle:Number;
		public var lastMouseX:Number;
		public var lastMouseY:Number;
		
		public function View3dModel() {
			super();
		}
		
		public function setView( view:View3D ):void {
			_view = view;
			_view.rightClickMenuEnabled = false;
			_scene = _view.scene;
			_camera = _view.camera;
		}
		
		public function render():void {
			_view.render();
		}
		
		/**
		 * Adding 3D objects to the scene.
		 */
		public function addToScene( object:ObjectContainer3D ):void {
			if ( !_scene.contains( object ) ) {
				_scene.addChild( object );
			}
		}
		
		/**
		 * Removing 3D objects from the scene.
		 */
		public function removeFromScene( object:ObjectContainer3D ):void {
			if ( _scene.contains( object ) ) {
				_scene.removeChild( object );
			}
		}
		
		public function project( position:Vector3D ):Point {
			var pos:Vector3D = _view.project( position );
			return new Point( pos.x, pos.y );
		}
		
		public function lookAt( target:Vector3D ):void {
			_camera.lookAt( target );
		}
		
		public function getCameraPosition():Vector3D {
			return _camera.position.clone();
		}
	
		public function getMouseUnprojection():Vector3D {
			var x:Number = ( ( view.mouseX * 1.0 / view.stage.stageWidth ) - .5 ) * 2;
			var y:Number = ( ( view.mouseY * 1.0 / view.stage.stageHeight ) - .5 ) * 2;
			return _view.unproject( x, y );
		}
		
		public function get view():View3D {
			return _view;
		}
		
		public function set cameraOffsetY( val:Number ):void {
			_cameraOffsetY = val;
		}
		
		public function get camera():Camera3D {
			return _camera;
		}
	}
}
