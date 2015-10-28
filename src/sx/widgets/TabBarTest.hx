package sx.widgets;

import hunit.TestCase;
import sx.widgets.TabBar;
import sx.widgets.TabButton;
import sx.widgets.ViewStack;




/**
 * sx.widgets.TabBar
 *
 */
class TabBarTest extends TestCase
{

    @test
    public function getTabs_hasAddedTabsAndOtherWidgets_returnsOnlyTabs () : Void
    {
        var bar = new TabBar();
        var tab1 = bar.createTab('Tab 1');
        var tab2 = bar.createTab('Tab 2');
        bar.addChild(new Widget());

        var tabs = bar.getTabs();

        var expected = [match.equal(tab1), match.equal(tab2)];
        assert.similar(expected, tabs);
    }


    @test
    public function selected_afterCreation_firstTabSelected () : Void
    {
        var bar = new TabBar();
        var tab1 = bar.createTab('Tab 1');
        var tab2 = bar.createTab('Tab 2');

        assert.equal(tab1, bar.selected);
    }


    @test
    public function selected_anotherTabSelected_selectedPointsToThatTab () : Void
    {
        var bar = new TabBar();
        var tab1 = bar.createTab('Tab 1');
        var tab2 = bar.createTab('Tab 2');

        tab2.selected = true;

        assert.equal(tab2, bar.selected);
    }


    @test
    public function onChange_anotherTabSelected_onChangeDispatched () : Void
    {
        var dispatched = false;
        var bar = new TabBar();
        var tab1 = bar.createTab('Tab 1');
        var tab2 = bar.createTab('Tab 2');
        bar.onChange.add(function(b) dispatched = true);

        tab2.selected = true;

        assert.isTrue(dispatched);
    }


    @test
    public function viewStack_viewStackIsSet_changingSelectedTabChangesCurrentView () : Void
    {
        var pages = new ViewStack();
        var view1 = pages.addChild(new Widget());
        var view2 = pages.addChild(new Widget());

        var tabs = new TabBar();
        var tab1 = tabs.createTab('Tab 1');
        var tab2 = tabs.createTab('Tab 2');
        tabs.viewStack = pages;

        tab2.selected = true;

        assert.equal(view2, pages.current);
    }

}//class TabBarTest