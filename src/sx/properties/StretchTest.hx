package sx.properties;

import hunit.TestCase;
import sx.properties.Stretch;



/**
 * sx.properties.Stretch
 *
 */
class StretchTest extends TestCase
{

    @test
    public function keepAspect_changedWhileScaleIsFalse_doesNotDispatchOnChange () : Void
    {
        var dispatched = false;
        var stretch    = new Stretch();
        stretch.scale      = false;
        stretch.keepAspect = false;
        stretch.onChange.add(function() dispatched = true);

        stretch.keepAspect = true;

        assert.isFalse(dispatched);
    }


    @test
    public function keepAspect_changedWhileScaleIsTrue_dispatcheshOnChange () : Void
    {
        var dispatched = false;
        var stretch    = new Stretch();
        stretch.scale      = true;
        stretch.keepAspect = false;
        stretch.onChange.add(function() dispatched = true);

        stretch.keepAspect = true;

        assert.isTrue(dispatched);
    }

}//class StretchTest