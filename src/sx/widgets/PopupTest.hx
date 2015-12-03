package sx.widgets;

import sx.TestCase;
import sx.widgets.Popup;
import sx.widgets.Widget;



/**
 * sx.widgets.Popup
 *
 */
class PopupTest extends TestCase
{

    @test
    public function show_hasNoParent_addedOnTopOfSxRoot () : Void
    {
        var popup = new Popup();

        popup.show();

        var expected = Sx.root.numChildren - 1;
        var actual = Sx.root.getChildIndex(popup);
        assert.equal(expected, actual);
    }


    @test
    public function show_hasParent_movedToTopOfParentDisplayList () : Void
    {
        var parent = new Widget();
        var popup = new Popup();
        parent.addChild(popup);

        popup.show();

        var expected = parent.numChildren - 1;
        var actual = parent.getChildIndex(popup);
        assert.equal(expected, actual);
    }


    @test
    public function show_always_visibleAndShownChangedToTrue () : Void
    {
        var popup = new Popup();

        popup.show();

        assert.isTrue(popup.visible);
        assert.isTrue(popup.shown);
    }


    @test
    public function show_noShowEffect_immediatelyDispatchesOnShowSignal () : Void
    {
        var dispatched = false;
        var popup = new Popup();
        popup.onShow.add(function(p) dispatched = true);

        popup.show();

        assert.isTrue(dispatched);
    }


    @test
    public function show_hasShowEffect_dispatchesOnShowSignalAfterShowEffectFinished () : Void
    {
        var dispatched = false;
        var actuator = null;
        var popup = new Popup();
        popup.showEffect = function(p) return actuator = p.tween.linear(10, p.alpha = 1);
        popup.onShow.add(function(p) dispatched = true);

        popup.show();
        assert.isFalse(dispatched);

        actuator.complete();
        assert.isTrue(dispatched);
    }


    @test
    public function close_isChildOfSxRoot_removedFromSxRoot () : Void
    {
        var popup = new Popup();
        popup.show();

        popup.close();

        assert.isNull(popup.parent);
    }


    @test
    public function close_isChildOfAnyWidgetExceptSxRoot_doesNotGetRemovedFromParent () : Void
    {
        var parent = new Widget();
        var popup = new Popup();
        parent.addChild(popup);
        popup.show();

        popup.close();

        assert.equal(parent, popup.parent);
    }


    @test
    public function close_doesNotHaveCloseEffect_visibleAndShownChangedToFalse () : Void
    {
        var popup = new Popup();
        popup.show();

        popup.close();

        assert.isFalse(popup.visible);
        assert.isFalse(popup.shown);
    }


    @test
    public function close_notFinishedCloseEffect_visibleStaysTrueAndShownChangedToFalse () : Void
    {
        var popup = new Popup();
        popup.closeEffect = function(p) return p.tween.linear(10, p.alpha = 0);
        popup.show();

        popup.close();

        assert.isTrue(popup.visible);
        assert.isFalse(popup.shown);
    }


    @test
    public function close_finishedCloseEffect_visibleAndShownChangedToFalse () : Void
    {
        var actuator = null;
        var popup = new Popup();
        popup.closeEffect = function(p) return actuator = p.tween.linear(10, p.alpha = 0);
        popup.show();

        popup.close();
        //simulate finishing closing effect
        actuator.complete();

        assert.isFalse(popup.visible);
        assert.isFalse(popup.shown);
    }

}//class PopupTest