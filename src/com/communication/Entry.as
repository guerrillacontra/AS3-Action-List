package com.communication {
	
	/**
	 * Used to store an entry on a Blackboard.
	 * 
	 * Acts as a "handle" to a specific resource
	 * allocated by a "key".
	 * 
	 * Copyright 2014 Extrovert Studios LLP
	 * @author James http://www.earthshatteringcode.com/
	 */
	public final class Entry
	{
		public function get isSafe():Boolean
		{
			return _value != null && _value != undefined;
		}
		
		public function get key():*
		{
			return _key;
		}
		
		public function Entry(key:*):void
		{
			_key = key;
		}
		
		public function write(data:*):void
		{
			_value = data;
		}
		
		public function read():*
		{
			return _value;
		}
		
		private var _value:* = null;
		private var _key:*;
	
	}

}