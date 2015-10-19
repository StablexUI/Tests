package sx.widgets;

import hunit.TestCase;
import sx.input.Pointer;
import sx.layout.LineLayout;
import sx.skins.Skin;
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
    public function skin_assignSkinToActiveState_skinApplied () : Void
    {
        var button = new Button();
        button.setState(button.down);

        button.down.skin = new Skin();

        assert.equal(button.skin, button.down.skin);
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

        button.onPointerPress.dispatch(button, button, 0);

        assert.isTrue(button.pressed);
    }


    @test
    public function pressed_userPressedAndReleasedPointerOverButton_pressedIsFalse () : Void
    {
        var button = new Button();
        button.onPointerPress.dispatch(button, button, 0);

        button.onPointerRelease.dispatch(button, button, 0);

        assert.isFalse(button.pressed);
    }


    @test
    public function pressed_userPressedAndMovedPointerOutOfButton_pressedIsFalse () : Void
    {
        var button = new Button();
        button.onPointerPress.dispatch(button, button, 0);

        button.onPointerOut.dispatch(button, button, 0);

        assert.isFalse(button.pressed);
    }


    @test
    public function hovered_userMovedPointerOverButton_hoveredIsTrue () : Void
    {
        var button = new Button();

        button.onPointerOver.dispatch(button, button, 0);

        assert.isTrue(button.hovered);
    }


    @test
    public function hovered_userMovedPointerOverAndOutOfButton_hoveredIsFalse () : Void
    {
        var button = new Button();
        button.onPointerOver.dispatch(button, button, 0);

        button.onPointerOut.dispatch(button, button, 0);

        assert.isFalse(button.hovered);
    }


    @test
    public function onTrigger_userPressedAndReleasedPointerOverButton_dispatchesTriggerSignal () : Void
    {
        var dispatched = false;
        var button = new Button();
        button.onTrigger.add(function(b) dispatched = true);

        button.onPointerPress.dispatch(button, button, 0);
        button.onPointerRelease.dispatch(button, button, 0);

        assert.isTrue(dispatched);
    }


    @test
    public function onTrigger_userClickedWhileButtonDisabled_dispatchesTriggerSignal () : Void
    {
        var dispatched = false;
        var button = new Button();
        button.enabled = false;
        button.onTrigger.add(function(b) dispatched = true);

        button.onPointerPress.dispatch(button, button, 0);
        button.onPointerRelease.dispatch(button, button, 0);

        assert.isFalse(dispatched);
    }


    @test
    public function onTrigger_userPressedPointerMovedOutMovedOverAndReleased_doesNotDispatchTriggerSignal () : Void
    {
        var dispatched = false;
        var button = new Button();
        button.onTrigger.add(function(b) dispatched = true);

        button.onPointerPress.dispatch(button, button, 0);
        button.onPointerOut.dispatch(button, button, 0);
        button.onPointerOver.dispatch(button, button, 0);
        button.onPointerRelease.dispatch(button, button, 0);

        assert.isFalse(dispatched);
    }


    @test
    public function trigger_buttonDisabled_doesNotDispatchOnTriggerSignal () : Void
    {
        var dispatched = false;
        var button = new Button();
        button.enabled = false;
        button.onTrigger.add(function(b) dispatched = true);

        button.trigger();

        assert.isFalse(dispatched);
    }


    @test
    public function layoutAutoSize_buttonWidthSpecifiedBeforeLayoutAssigned_layoutInitializedWithAutoSizeFalse () : Void
    {
        var button = new Button();
        button.width.dip  = 100;
        button.height.dip = 50;

        var layout : LineLayout = cast button.layout;

        assert.isTrue(layout.autoSize.neither());
        assert.equal(100., button.width.dip);
        assert.equal(50., button.height.dip);
    }


    @test
    public function releaseOnPointerOut_isFalse_stayPressedAfterPointerRollOut () : Void
    {
        var button = new Button();
        button.releaseOnPointerOut = false;
        button.onPointerOver.dispatch(button, button, 0);
        button.onPointerPress.dispatch(button, button, 0);

        button.onPointerOut.dispatch(button, button, 0);

        assert.isTrue(button.pressed);
    }


    @test
    public function releaseOnPointerOut_isFalse_releasedAfterPointerReleaseOutsideButton () : Void
    {
        var button = new Button();
        button.releaseOnPointerOut = false;
        button.onPointerOver.dispatch(button, button, 0);
        button.onPointerPress.dispatch(button, button, 0);
        button.onPointerOut.dispatch(button, button, 0);

        Pointer.released(null, 0);

        assert.isFalse(button.pressed);
    }

}//class ButtonTest