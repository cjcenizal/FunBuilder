package com.funbuilder.model
{
	import away3d.entities.Mesh;
	
	import flash.geom.Vector3D;
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ElevationModel extends Actor
	{
		
		private var _positiveIndicators:Object;
		private var _negativeIndicators:Object;
		private var _indicators:Array;
		
		public function ElevationModel()
		{
			super();
			_positiveIndicators = {};
			_negativeIndicators = {};
			_indicators = [];
		}
		
		public function add( mesh:Mesh, isPositive:Boolean ):void {
			var key:String = makeHash( mesh.position );
			if ( isPositive ) {
				_positiveIndicators[ key ] = mesh;
			} else {
				_negativeIndicators[ key ] = mesh;
			}
			_indicators.push( mesh );
		}
		
		private function makeHash( pos:Vector3D ):String {
			return pos.x.toString() + "," + pos.z.toString();
		}
		
		public function getAtPos( pos:Vector3D, isPositive:Boolean ):Mesh {
			var key:String = makeHash( pos );
			if ( isPositive ) {
				return _positiveIndicators[ key ];
			}
			return _negativeIndicators[ key ];
		}
		
		public function getAt( index:int ):Mesh {
			return _indicators[ index ];
		}
		
		public function get count():int {
			return _indicators.length;
		}
	}
}