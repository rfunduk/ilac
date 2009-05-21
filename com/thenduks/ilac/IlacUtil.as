package com.thenduks.ilac {
  public class IlacUtil {
    public static function stringAsArray( string:String ):Array {
      var arr:Array = string.slice( 1, string.length ).split( ',' );
      return [ parseInt( arr[0] ),
               parseInt( arr[1] ) ];
    }
  }
}
