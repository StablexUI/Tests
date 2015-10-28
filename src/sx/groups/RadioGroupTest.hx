package sx.groups;

import hunit.TestCase;
import sx.groups.RadioGroup;
import sx.widgets.Radio;



/**
 * sx.groups.RadioGroup
 *
 */
class RadioGroupTest extends TestCase
{

    @test
    public function selected_addSelectedRadio_groupSelectedChangedToNewRadio () : Void
    {
        var group = new RadioGroup();
        var radio1 = new Radio();
        radio1.selected = true;
        radio1.group = group;
        var radio2 = new Radio();
        radio2.selected = true;

        radio2.group = group;

        assert.isFalse(radio1.selected);
    }


    @test
    public function selected_selectedAnotherRadio_previousOneDeselected () : Void
    {
        var group = new RadioGroup();
        var radio1 = new Radio();
        radio1.selected = true;
        radio1.group = group;
        var radio2 = new Radio();
        radio2.group = group;

        radio2.selected = true;

        assert.isFalse(radio1.selected);
    }


    @test
    public function selected_selectedAnotherRadio_selectedPointToThatRadio () : Void
    {
        var group = new RadioGroup();
        var radio1 = new Radio();
        radio1.selected = true;
        radio1.group = group;
        var radio2 = new Radio();
        radio2.group = group;

        radio2.selected = true;

        assert.equal(radio2, group.selected);
    }


    @test
    public function selected_removeSelectedRadio_groupSelectionBecomesNull () : Void
    {
        var group = new RadioGroup();
        var radio1 = new Radio();
        radio1.selected = true;
        radio1.group = group;
        var radio2 = new Radio();
        radio2.group = group;

        radio1.group = null;

        assert.isNull(group.selected);
    }


}//class RadioGroupTest