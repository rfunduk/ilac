package com.thenduks.ilac.skins {
  import mx.controls.sliderClasses.SliderThumb;

  public class SliderThumbSkin extends SliderThumb {
    //public function SliderThumbSkin() {}

    override protected function updateDisplayList( unscaledWidth:Number, unscaledHeight:Number ):void {
      super.updateDisplayList( unscaledWidth, unscaledHeight );
      this.graphics.clear();
      this.graphics.lineStyle( 1, 0x555555, 1.0 );
      this.graphics.beginFill( 0xAAAAAA, 1.0 );
      this.graphics.drawCircle( 6, -4, 8 );
      this.graphics.endFill();
    }
  }
}
