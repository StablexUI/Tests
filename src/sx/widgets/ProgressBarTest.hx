package sx.widgets;

import sx.TestCase;
import sx.widgets.ProgressBar;
import sx.properties.Orientation;

using sx.tools.PropertiesTools;


/**
 * sx.widgets.Progress
 *
 */
@group('progress')
class ProgressBarTest extends TestCase
{

    @test
    public function value_changed_barSizeAdjusted () : Void
    {
        var progress = new ProgressBar();
        progress.orientation = Horizontal;
        progress.min         = 0;
        progress.max         = 100;
        progress.width.dip   = 100;
        progress.padding     = 10;
        progress.initialize();

        progress.value = 30;

        var expected = (progress.width.dip - progress.padding.sumDip(Horizontal)) * progress.value / (progress.max - progress.min);
        var actual   = progress.bar.width.dip;
        var diff     = Math.round(Math.abs(actual - expected));
        assert.equal(0, diff);
    }


    @test
    public function max_changed_barSizeAdjusted () : Void
    {
        var progress = new ProgressBar();
        progress.orientation = Horizontal;
        progress.min        = 0;
        progress.max        = 100;
        progress.width.dip  = 100;
        progress.padding    = 10;
        progress.value      = 30;
        progress.initialize();

        progress.max = 90;

        var expected = (progress.width.dip - progress.padding.sumDip(Horizontal)) * progress.value / (progress.max - progress.min);
        var actual   = progress.bar.width.dip;
        var diff     = Math.round(Math.abs(actual - expected));
        assert.equal(0, diff);
    }


    @test
    public function min_changed_barSizeAdjusted () : Void
    {
        var progress = new ProgressBar();
        progress.orientation = Horizontal;
        progress.min        = 0;
        progress.max        = 100;
        progress.width.dip  = 100;
        progress.padding    = 10;
        progress.value      = 30;
        progress.initialize();

        progress.min = 20;

        var expected = (progress.width.dip - progress.padding.sumDip(Horizontal)) * progress.value / (progress.max - progress.min);
        var actual   = progress.bar.width.dip;
        var diff     = Math.round(Math.abs(actual - expected));
        assert.equal(0, diff);
    }


    @test
    public function value_setLessThanMin_valueConstrainedToMin () : Void
    {
        var progress = new ProgressBar();
        progress.min = 0;

        progress.value = -100;

        assert.equal(0., progress.value);
    }


    @test
    public function value_setGreaterThanMax_valueConstrainedToMax () : Void
    {
        var progress = new ProgressBar();
        progress.max = 100;

        progress.value = 200;

        assert.equal(100., progress.value);
    }

}//class ProgressBarTest