package sx.properties;

import hunit.TestCase;
import sx.properties.ButtonState;
import sx.widgets.Text;
import sx.widgets.Widget;



/**
 * sx.properties.ButtonState
 *
 */
class ButtonStateTest extends TestCase
{

    @test
    public function hasText_rightAfterCreation_returnsFalse () : Void
    {
        var state = new ButtonState();

        var has = state.hasText();

        assert.isFalse(has);
    }


    @test
    public function hasText_afterAccessingText_returnsTrue () : Void
    {
        var state = new ButtonState();
        var text = state.text;

        var has = state.hasText();

        assert.isTrue(has);
    }


    @test
    public function hasText_afterAssigningText_returnsTrue () : Void
    {
        var state = new ButtonState();
        state.text = 'hello';

        var has = state.hasText();

        assert.isTrue(has);
    }


    @test
    public function hasText_afterAssigningNullText_returnsFalse () : Void
    {
        var state = new ButtonState();
        state.text = 'hello';
        state.text = null;

        var has = state.hasText();

        assert.isFalse(has);
    }


    @test
    public function hasLabel_rightAfterCreation_returnsFalse () : Void
    {
        var state = new ButtonState();

        var has = state.hasLabel();

        assert.isFalse(has);
    }


    @test
    public function hasLabel_afterAccessingLabel_returnsTrue () : Void
    {
        var state = new ButtonState();
        var label = state.label;

        var has = state.hasLabel();

        assert.isTrue(has);
    }


    @test
    public function hasLabel_afterAssigningLabel_returnsTrue () : Void
    {
        var state = new ButtonState();
        state.label = new Text();

        var has = state.hasLabel();

        assert.isTrue(has);
    }


    @test
    public function hasLabel_afterAssigningNullLabel_returnsFalse () : Void
    {
        var state = new ButtonState();
        state.label = new Text();
        state.label = null;

        var has = state.hasLabel();

        assert.isFalse(has);
    }


    @test
    public function hasIco_rightAfterCreation_returnsFalse () : Void
    {
        var state = new ButtonState();

        var has = state.hasIco();

        assert.isFalse(has);
    }


    @test
    public function hasIco_afterAccessingIcon_returnsTrue () : Void
    {
        var state = new ButtonState();
        var ico = state.ico;

        var has = state.hasIco();

        assert.isTrue(has);
    }


    @test
    public function hasIco_afterAssigningIcon_returnsTrue () : Void
    {
        var state = new ButtonState();
        state.ico = new Widget();

        var has = state.hasIco();

        assert.isTrue(has);
    }


    @test
    public function hasIco_afterAssigningNullIcon_returnsFalse () : Void
    {
        var state = new ButtonState();
        state.ico = new Widget();
        state.ico = null;

        var has = state.hasIco();

        assert.isFalse(has);
    }


}//class ButtonStateTest