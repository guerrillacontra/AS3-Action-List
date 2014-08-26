package com.actionlists
{
	
	/**
	 * A module of behaviour that can perform a task within one or more bit-wise "lanes".
	 *
	 * Lanes are represented via a bitmask for both the lanes this action drives on
	 * and the lanes it can block.
	 * 
	 * 
	 * Copyright 2014 Extrovert Studios LLP
	 * @author James http://www.earthshatteringcode.com/
	 */
	public class Action
	{
	
		internal var _next:Action;
		internal var _previous:Action;
		
		/**
		 * Written to by an action list.
		 */
		internal var _parent:ActionList;
		
		/**
		 * A bit-mask representing the lanes
		 * this action "drives" on.
		 */
		public final function get laneMask():uint
		{
			return _laneMask;
		}
		
		/**
		 * A bit-mask representing the lanes
		 * this action can block when "isBlocking"
		 * is true.
		 */
		public final function get lanesToBlockMask():uint
		{
			return _lanesToBlockMask;
		}
		
		/**
		 * Does this action block other actions within the
		 * "lanesToBlockMask" ?
		 */
		public final function get isBlocking():Boolean
		{
			return _isBlocking;
		}
		
		
		public final function set isBlocking(value:Boolean):void
		{
			_isBlocking = value;
		}
		
		/**
		 * Has this action been started?
		 */
		public final function get hasStarted():Boolean
		{
			return _hasStarted;
		}
		
		/**
		 * The action list that is currently processing
		 * this and potentially other actions.
		 */
		public final function get parent():ActionList
		{
			return _parent;
		}
		
		public function Action(laneMask:uint, lanesToBlockMask:uint):void
		{
			_lanesToBlockMask = lanesToBlockMask;
			_laneMask = laneMask;
			_isBlocking = true;
		}
		
		/**
		 * Start the action.
		 * @return true if the action is finished
		 */
		public final function start():Boolean
		{
			_hasStarted = true;
			return onStarted();
		}
		
		/**
		 * Update the action.
		 * @return true if the action is finished
		 */
		public final function update():Boolean
		{
			return onUpdated();
		}
		
		/**
		 * Stop the action
		 */
		public final function stop():void
		{
			onStopped();
			_hasStarted = false;
			_parent = null;
		}
		
		
		//PROTECTED FUNCTIONS TO OVERRIDE IN INSTANCES
		
		/**
		 * Start the action within a derived instance.
		 * @return true if finished
		 */
		protected function onStarted():Boolean
		{
			return false;
		}
		
		/**
		 * Stop the action within a derived instance.
		 */
		protected function onStopped():void
		{
		
		}
		
		/**
		 * Update the action within a derived instance.
		 * @return true if finished
		 */
		protected function onUpdated():Boolean
		{
			return false;
		}
		
		private var _hasStarted:Boolean;
		private var _isBlocking:Boolean;
		private var _lanesToBlockMask:uint;
		private var _laneMask:uint;
	
	}

}