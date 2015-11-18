package sx;

import sx.Sx;


/**
 * Base case for StablexUI tests
 *
 */
class TestCase extends hunit.TestCase
{

    /**
     * Setup new environment before each test
     *
     */
    override public function setup () : Void
    {
        super.setup();
        Sx.dipFactor = 2;
    }


    /**
     * Perform some cleaning after each test
     *
     */
    override public function tearDown () : Void
    {
        super.tearDown();
        Sx.dipFactor = 1;
    }

}//class TestCase
