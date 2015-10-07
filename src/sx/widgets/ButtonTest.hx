package sx.widgets;

import hunit.TestCase;
import sx.layout.LineLayout;
import sx.widgets.Button;
import sx.widgets.Text;



/**
 * sx.widgets.Button
 *
 */
class ButtonTest extends TestCase
{

    @test
    public function ico_assignIconToActiveState_iconAddedToDisplayList () : Void
    {
        var button = new Button();
        button.setState(button.down);

        button.down.ico = new Widget();

        assert.equal((button:Widget), button.down.ico.parent);
    }


    @test
    public function ico_assignNewIconToActiveState_oldIconRemovedFromDisplayList () : Void
    {
        var button = new Button();
        button.setState(button.down);
        var oldIco = new Widget();
        button.down.ico = oldIco;

        button.down.ico = new Widget();

        assert.isNull(oldIco.parent);
    }


    @test
    public function label_assignLabelnToActiveState_LabelnAddedToDisplayList () : Void
    {
        var button = new Button();
        button.setState(button.down);

        button.down.label = new Text();

        assert.equal((button:Widget), button.down.label.parent);
    }


    @test
    public function label_assignNewLabelnToActiveState_oldLabelnRemovedFromDisplayList () : Void
    {
        var button = new Button();
        button.setState(button.down);
        var oldLabel = new Text();
        button.down.label = oldLabel;

        button.down.label = new Text();

        assert.isNull(oldLabel.parent);
    }


    @test
    public function text_assignTextToActiveStateWithoutLabel_defaultLabelReceivesNewText () : Void
    {
        var button = new Button();
        button.setState(button.down);

        //own state has no label, so doefault label should be used (which is label of up state)
        button.down.text = 'Hello';

        assert.equal(button.down.text, button.up.label.text);
    }


    @test
    public function layout_notAddedDisplayListYet_layoutIsNotCreated () : Void
    {
        var button = new Button();
        var child1 = button.addChild(new Widget());
        var child2 = button.addChild(new Widget());

        child1.width = 30;
        child2.width = 20;

        assert.equal(0.0, child1.left);
        assert.equal(0.0, child1.top);
        assert.equal(0.0, child2.left);
        assert.equal(0.0, child2.top);
    }


    @test
    public function layout_buttonAddedToDisplayListWithoutUserDefinedLayout_createsDefaultLayout () : Void
    {
        var button = new Button();

        new Widget().addChild(button);

        assert.type(LineLayout, button.layout);
    }


    @test
    public function pressed_userPressedPointerOverButton_pressedIsTrue () : Void
    {
        var button = new Button();

        button.onPointerPress.dispatch(button, button);

        assert.isTrue(button.pressed);
    }


    @test
    public function pressed_userPressedAndReleasedPointerOverButton_pressedIsFalse () : Void
    {
        var button = new Button();
        button.onPointerPress.dispatch(button, button);

        button.onPointerRelease.dispatch(button, button);

        assert.isFalse(button.pressed);
    }


    @test
    public function pressed_userPressedAndMovedPointerOutOfButton_pressedIsFalse () : Void
    {
        var button = new Button();
        button.onPointerPress.dispatch(button, button);

        button.onPointerOut.dispatch(button, button);

        assert.isFalse(button.pressed);
    }


    @test
    public function hovered_userMovedPointerOverButton_hoveredIsTrue () : Void
    {
        var button = new Button();

        button.onPointerOver.dispatch(button, button);

        assert.isTrue(button.hovered);
    }


    @test
    public function hovered_userMovedPointerOverAndOutOfButton_hoveredIsFalse () : Void
    {
        var button = new Button();
        button.onPointerOver.dispatch(button, button);

        button.onPointerOut.dispatch(button, button);

        assert.isFalse(button.hovered);
    }


    @test
    public function onTrigger_userPressedAndReleasedPointerOverButton_dispatchesTriggerSignal () : Void
    {
        var dispatched = false;
        var button = new Button();
        button.onTrigger.add(function(b) dispatched = true);

        button.onPointerPress.dispatch(button, button);
        button.onPointerRelease.dispatch(button, button);

        assert.isTrue(dispatched);
    }


    @test
    public function onTrigger_userPressedPointerMovedOutMovedOverAndReleased_doesNotDispatchTriggerSignal () : Void
    {
        var dispatched = false;
        var button = new Button();
        button.onTrigger.add(function(b) dispatched = true);

        button.onPointerPress.dispatch(button, button);
        button.onPointerOut.dispatch(button, button);
        button.onPointerOver.dispatch(button, button);
        button.onPointerRelease.dispatch(button, button);

        assert.isFalse(dispatched);
    }

}//class ButtonTest