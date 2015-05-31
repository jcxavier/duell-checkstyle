package duell.build.plugin.library.checkstyle;

import sys.io.File;
import haxe.xml.Fast;
import duell.defines.DuellDefines;
import haxe.io.Path;
import duell.helpers.CommandHelper;

/**
    @author jxav
 */
class LibraryBuild
{
    public function new()
    {}

    public function postParse(): Void
    {
        var duellProjectPath: String = Path.join([Sys.getCwd(), DuellDefines.PROJECT_CONFIG_FILENAME]);
        var xml: Xml = Xml.parse(File.getContent(duellProjectPath));
        var fast: Fast = new Fast(xml.firstElement());

        var args: Array<String> =
        [
            "run",
            "checkstyle"
        ];

        for (element in fast.elements)
        {
            if (element.name == "source")
            {
                args = args.concat(["-s", element.att.path]);
            }
        }

        CommandHelper.runHaxelib(null, args, { errorMessage: "error running checkstyle" });
    }
}
