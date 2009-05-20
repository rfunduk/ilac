package com.thenduks.ilac.skins {
  import mx.core.UIComponent;

  public class HSliderBrightnessSkin extends UIComponent {

    override public function get height():Number {
      return 20;
    }

    //public function get color():Number {
    //}
    //public function set color( c:Number ):void {
    //  color = c;
    //}

    override protected function updateDisplayList( w:Number, h:Number ):void {
      super.updateDisplayList( unscaledWidth, unscaledHeight );

      //create 2 circle that will act like round corners
      this.graphics.beginFill( 0xBBBBBB,1 );
      this.graphics.drawCircle( 0, 0, 5 );
      this.graphics.drawCircle( unscaledWidth, 0, 5 );
      this.graphics.endFill();

      //create the line that represents the track
      this.graphics.moveTo( 0, 0 );
      this.graphics.lineStyle( 10, 0xBBBBBB );
      this.graphics.lineTo( unscaledWidth, 0 );
    }
  }
}
