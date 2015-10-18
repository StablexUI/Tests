package sx.widgets;

import hunit.TestCase;
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

        var expected = (progress.width.dip - progress.padding.sum(Horizontal)) * progress.value / (progress.max - progress.min);
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

        var expected = (progress.width.dip - progress.padding.sum(Horizontal)) * progress.value / (progress.max - progress.min);
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

        var expected = (progress.width.dip - progress.padding.sum(Horizontal)) * progress.value / (progress.max - progress.min);
        var actual   = progress.bar.width.dip;
        var diff     = Math.round(Math.abs(actual - expected));
        assert.equal(0, diff);
    }

}//class ProgressBarTest