package sx.widgets;

import hunit.TestCase;
import sx.widgets.ToggleButton;



/**
 * sx.widgets.ToggleButton
 *
 */
class ToggleButtonTest extends TestCase
{

    @test
    public function selected_setTrueDirectly_stateChangedToDown () : Void
    {
        var button = new ToggleButton();
        button.up.text = 'Up';
        button.down.text = 'Down';
        button.initialize();

        button.selected = true;

        assert.equal(button.down, button.getState(), 'toggleButton state should be `down`');
    }


    @test
    public function selected_setFalseDirectly_stateChangedToUp () : Void
    {
        var button = new ToggleButton();
        button.up.text   = 'Up';
        button.down.text = 'Down';
        button.selected  = true;
        button.initialize();

        button.selected = false;

        assert.equal(button.up, button.getState(), 'toggleButton state should be `up`');
    }


    @test
    public function selected_setFalseDirectlyWhileHovered_stateChangedToHover () : Void
    {
        var button = new ToggleButton();
        button.up.text    = 'Up';
        button.down.text  = 'Down';
        button.hover.text = 'Hover';
        button.selected  = true;
        button.initialize();

        button.onPointerOver.dispatch(button, button, 0);
        button.selected = false;

        assert.equal(button.hover, button.getState(), 'toggleButton state should be `hover`');
    }


    @test
    public function trigger_always_togglesSelected () : Void
    {
        var btn1 = new ToggleButton();
        btn1.selected = false;
        var btn2 = new ToggleButton();
        btn2.selected = true;

        btn1.trigger();
        btn2.trigger();

        assert.isTrue(btn1.selected);
        assert.isFalse(btn2.selected);
    }

    @test
    public function selected_changed_dispatchOnToggle () : Void
    {
        var dispatched = 0;
        var button = new ToggleButton();
        button.selected = false;
        button.onToggle.add(function(b) dispatched ++);

        button.selected = true;
        button.selected = false;
        button.selected = false;

        assert.equal(2, dispatched);
    }

}//class ToggleButtonTest