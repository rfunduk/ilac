// ColorMatrix Class v2.1
//
// released under MIT License (X11)
// http://www.opensource.org/licenses/mit-license.php
//
// Author: Mario Klingemann
// http://www.quasimondo.com

/*
Copyright (c) 2008 Mario Klingemann

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package com.thenduks.ilac {
  import flash.filters.ColorMatrixFilter;

  public class ColorMatrix {
    // RGB to Luminance conversion constants as found on
    // Charles A. Poynton's colorspace-faq:
    // http://www.faqs.org/faqs/graphics/colorspace-faq/
    private static const LUMA_R:Number = 0.212671;
    private static const LUMA_G:Number = 0.71516;
    private static const LUMA_B:Number = 0.072169;

    private static const ONETHIRD:Number = 1 / 3;

    private static const IDENTITY:Array = [
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 1, 0
    ];

    private static const RAD:Number = Math.PI / 180;

    public var matrix:Array;

    /*
      Function: ColorMatrix

      Constructor

      Parameters:
        mat - if omitted matrix gets initialized with an
              identity matrix. Alternatively it can be
              initialized with another ColorMatrix or
              an array (there is currently no check
              if the array is valid. A correct array
              contains 20 elements.)
    */
    public function ColorMatrix( mat:Object = null ) {
      if( mat is ColorMatrix ) {
        matrix = mat.matrix.concat();
      }
      else if( mat is Array ) {
        matrix = mat.concat();
      }
      else {
        reset();
      }
    }

    /*
      Function: reset

      Resets the matrix to the neutral identity matrix. Applying this
      matrix to an image will not make any changes to it.

      Parameters: none
      Returns: void
    */
    public function reset():void {
      matrix = IDENTITY.concat();
    }

    public function clone():ColorMatrix {
      return new ColorMatrix( matrix );
    }

    /*
      Function: adjustSaturation

      Changes the saturation

      Parameters:
        s - typical values come in the range 0.0 ... 2.0 where
              0.0 means 0% Saturation
              0.5 means 50% Saturation
              1.0 is 100% Saturation (aka no change)
              2.0 is 200% Saturation

            Other values outside of this range are possible
              1.0 will invert the hue but keep the luminance

      Returns: void
    */
    public function adjustSaturation( s:Number ):void {
      var sInv:Number;
      var irlum:Number;
      var iglum:Number;
      var iblum:Number;

      sInv =  ( 1 - s );
      irlum = ( sInv * LUMA_R );
      iglum = ( sInv * LUMA_G );
      iblum = ( sInv * LUMA_B );

      concat(
        [ (irlum + s), iglum, iblum, 0, 0,
          irlum, (iglum + s), iblum, 0, 0,
          irlum, iglum, (iblum + s), 0, 0,
          0, 0, 0, 1, 0 ]
      );
    }

    public function adjustBrightness( r:Number, g:Number=NaN, b:Number = NaN ):void {
      if( isNaN( g ) ) { g = r; }
      if( isNaN( b ) ) { b = r; }

      concat(
        [ 1, 0, 0, 0, r,
          0, 1, 0, 0, g,
          0, 0, 1, 0, b,
          0, 0, 0, 1, 0 ]
      );
    }

    public function colorize( rgb:int, amount:Number = 1 ):void {
      var r:Number;
      var g:Number;
      var b:Number;
      var inv_amount:Number;

      r = (((rgb >> 16) & 0xFF) / 0xFF);
      g = (((rgb >> 8) & 0xFF) / 0xFF);
      b = ((rgb & 0xFF) / 0xFF);
      inv_amount = (1 - amount);

      concat(
        [ (inv_amount + ((amount * r) * LUMA_R)),
          ((amount * r) * LUMA_G),
          ((amount * r) * LUMA_B),
          0, 0,

          ((amount * g) * LUMA_R),
          (inv_amount + ((amount * g) * LUMA_G)),
          ((amount * g) * LUMA_B),
          0, 0,

          ((amount * b) * LUMA_R),
          ((amount * b) * LUMA_G),
          (inv_amount + ((amount * b) * LUMA_B)),
          0, 0,

          0, 0, 0, 1, 0 ]
      );
    }

    public function get filter():ColorMatrixFilter {
      return new ColorMatrixFilter( matrix );
    }

    public function concat( mat:Array ):void {
      var temp:Array = [];
      var i:int = 0;
      var x:int, y:int;
      for( y = 0; y < 4; y++ ) {
        for( x = 0; x < 5; x++ ) {
          temp[ int( i + x) ] =
            Number(mat[i]) * Number(matrix[x]) +
            Number(mat[int(i+1)]) * Number(matrix[int(x +  5)]) +
            Number(mat[int(i+2)]) * Number(matrix[int(x + 10)]) +
            Number(mat[int(i+3)]) * Number(matrix[int(x + 15)]) +
            (x == 4 ? Number(mat[int(i+4)]) : 0);
        }
        i += 5;
      }

      matrix = temp;
    }
  }
}
