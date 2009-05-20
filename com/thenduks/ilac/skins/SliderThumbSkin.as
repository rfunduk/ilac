package com.thenduks.ilac.skins {
  import mx.controls.sliderClasses.SliderThumb;

  public class SliderThumbSkin extends SliderThumb {
    //public function SliderThumbSkin() {}

    override protected function updateDisplayList( unscaledWidth:Number, unscaledHeight:Number ):void {
      //super.updateDisplayList( unscaledWidth, unscaledHeight );
      this.graphics.beginFill( 0x555555, 0.75 );
      this.graphics.drawCircle( 6, -4, 4 );
      this.graphics.endFill();
    }
  }
}
