package sx.widgets;

import hunit.TestCase;
import sx.widgets.Slider;
import sx.properties.Orientation;


/**
 * sx.widgets.Slider
 *
 */
@group('slider')
class SliderTest extends TestCase
{

    @test
    public function value_changed_thumbPositionAdjusted () : Void
    {
        var slider = new Slider();
        slider.orientation     = Horizontal;
        slider.min             = 0;
        slider.max             = 100;
        slider.width.dip       = 110;
        slider.thumb.width.dip = 10;
        slider.initialize();

        slider.value = 30;

        assert.equal(30., slider.thumb.left.dip);
    }


    @test
    public function max_changed_thumbPositionAdjusted () : Void
    {
        var slider = new Slider();
        slider.orientation     = Horizontal;
        slider.min             = 0;
        slider.max             = 90;
        slider.width.dip       = 110;
        slider.thumb.width.dip = 10;
        slider.value           = 30;
        slider.initialize();

        slider.max = 100;

        assert.equal(30., slider.thumb.left.dip);
    }


    @test
    public function min_changed_thumbPositionAdjusted () : Void
    {
        var slider = new Slider();
        slider.orientation     = Horizontal;
        slider.min             = 10;
        slider.max             = 100;
        slider.width.dip       = 110;
        slider.thumb.width.dip = 10;
        slider.value           = 30;
        slider.initialize();

        slider.min = 0;

        assert.equal(30., slider.thumb.left.dip);
    }


    @test
    public function value_setLessThanMin_valueConstrainedToMin () : Void
    {
        var slider = new Slider();
        slider.min = 0;

        slider.value = -100;

        assert.equal(0., slider.value);
    }


    @test
    public function value_setGreaterThanMax_valueConstrainedToMax () : Void
    {
        var slider = new Slider();
        slider.max = 100;

        slider.value = 200;

        assert.equal(100., slider.value);
    }

    @test
    public function value_setInTheMiddleBetweenMinAndMax_movesThumbToTheMiddleOfSlider () : Void
    {
        var slider = new Slider();
        slider.min = 0;
        slider.max = 100;
        slider.width.dip = 100;
        slider.thumb.width.dip = 10;
        slider.initialize();

        slider.value = 50;

        assert.equal(45., slider.thumb.left.dip);
    }

}//class SliderTest