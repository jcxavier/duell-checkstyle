package duell.build.plugin.library.checkstyle;

import duell.build.objects.Configuration;
import duell.helpers.CommandHelper;

/**
    @author jxav
 */
class LibraryBuild
{
    public function postParse(): Void
    {
        var args: Array<String> =
        [
            "run",
            "checkstyle"
        ];

        for (sourceDir in Configuration.getData().SOURCES)
        {
            args = args.concat(["-s", sourceDir]);
        }

        CommandHelper.runHaxelib(null, args);
    }
}
