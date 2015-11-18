package sx.widgets;

import sx.TestCase;
import sx.groups.RadioGroup;
import sx.widgets.Radio;



/**
 * sx.widgets.Radio
 *
 */
class RadioTest extends TestCase
{

    @test
    public function selected_deselectWhileIsSelectedInGroup_selectedStaysTrue () : Void
    {
        var group = new RadioGroup();
        var radio = new Radio();
        radio.selected = true;
        radio.group = group;

        radio.selected = false;

        assert.isTrue(radio.selected);
    }

}//class RadioTest