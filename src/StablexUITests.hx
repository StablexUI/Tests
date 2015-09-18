package ;



/**
 * Test runner
 *
 */
class StablexUITests
{
    /**
     * Entry point
     */
    static public function main () : Void
    {
        run();
    }


    /**
     * Run tests
     */
    static public function run () : Void
    {
        var suite = new hunit.TestSuite();
        suite.addDirectory('sx');
        HUnit.addTestsFromHUnitFlag(suite);
        suite.run();
    }

}//class StablexUITests