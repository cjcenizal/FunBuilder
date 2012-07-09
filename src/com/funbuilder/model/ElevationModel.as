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
		
		public function ElevationModel()
		{
			super();
			_positiveIndicators = {};
			_negativeIndicators = {};
		}
		
		public function add( mesh:Mesh, isPositive:Boolean ):void {
			var obj:Object = ( isPositive ) ? _positiveIndicators : _negativeIndicators;
			obj[ makeHash( mesh.position ) ] = mesh;
		}
		
		private function makeHash( pos:Vector3D ):String {
			return pos.x.toString() + "," + pos.y.toString();
		}
	}
}