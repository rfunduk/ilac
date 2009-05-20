package com.thenduks.ilac.skins {
  import mx.skins.ProgrammaticSkin;
  import flash.geom.Matrix;

  public class HSliderBrightnessSkin extends ProgrammaticSkin {

    override public function get height():Number {
      return 20;
    }

    override protected function updateDisplayList( w:Number, h:Number ):void {
      super.updateDisplayList( w, h );

      var fillColors:String = getStyle( 'fillColors' );
      fillColors = fillColors.slice( 1, fillColors.length );
      var colorArray:Array = fillColors.split( ',' );
      colorArray = [ parseInt( colorArray[0], 10 ), parseInt( colorArray[1], 10 ) ];

      //create 2 circle that will act like round corners
      this.graphics.beginFill( colorArray[0], 1 );
      this.graphics.drawCircle( 0, 0, 5 );
      this.graphics.endFill();
      this.graphics.beginFill( colorArray[1], 1 );
      this.graphics.drawCircle( w, 0, 5 );
      this.graphics.endFill();

      this.graphics.beginGradientFill(
        'linear', colorArray,
        [ 1, 1 ], [ 0, 255 ],
        horizontalGradientMatrix( 0, 0, w, 10 )
      )
      this.graphics.drawRect( 0, -5, w, 10 );
      this.graphics.endFill();
    }
  }
}
