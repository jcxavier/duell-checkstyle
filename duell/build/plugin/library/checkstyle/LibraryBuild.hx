package duell.build.plugin.library.checkstyle;

import sys.FileSystem;
import sys.io.File;
import duell.objects.DuellLib;
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

        var libPath: String = DuellLib.getDuellLib("checkstyle").getPath();
        var resourcesPath: String = Path.join([libPath, "resources"]);
        var configPath: String = Path.join([resourcesPath, "config.json"]);
        var outputPath: String = LibraryConfiguration.getData().OUTPUT_PATH;

        if (LibraryConfiguration.getData().CONFIG_PATH != "")
        {
            configPath = LibraryConfiguration.getData().CONFIG_PATH;
        }

        var args: Array<String> =
        [
            "run",
            "checkstyle",
            "-c",
            configPath,
            "-r",
            "xml",
            "-p",
            outputPath
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

    public function clean(): Void
    {
        if (FileSystem.exists(LibraryConfiguration.getData().OUTPUT_PATH))
        {
            FileSystem.deleteFile(LibraryConfiguration.getData().OUTPUT_PATH);
        }
    }
}
