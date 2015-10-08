package sx.themes;

import hunit.TestCase;
import sx.themes.Theme;


/**
 * sx.themes.Theme
 *
 */
class ThemeTest extends TestCase
{

    @test
    public function ready_onReadyListenerAddedWhenThemeIsReady_listenerCalledImmediately () : Void
    {
        var called = false;
        var theme = new CustomSynchronousTheme();
        var listener = function () called = true;

        theme.onReady.add(listener);

        assert.isTrue(called);
    }

}//class ThemeTest



private class CustomSynchronousTheme extends Theme
{
    override private function initialize () : Void
    {
        finalize();
    }
}