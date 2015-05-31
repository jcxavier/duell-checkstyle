package duell.build.plugin.library.checkstyle;

import haxe.io.Path;
import duell.build.objects.Configuration;
typedef LibraryConfigurationData =
{
    CONFIG_PATH: String,
    OUTPUT_PATH: String
}

/**
    @author jxav
 */
class LibraryConfiguration
{
    private static var configuration: LibraryConfigurationData = null;
    private static var parsingDefines: Array<String> = ["checkstyle"];

    public static function getData(): LibraryConfigurationData
    {
        if (configuration == null)
        {
            initConfig();
        }

        return configuration;
    }

    public static function getConfigParsingDefines(): Array<String>
    {
        return parsingDefines;
    }

    public static function addParsingDefine(str: String): Void
    {
        parsingDefines.push(str);
    }

    private static function initConfig(): Void
    {
        configuration =
        {
            CONFIG_PATH : "",
            OUTPUT_PATH : Path.join([Configuration.getData().OUTPUT, "checkstyle.xml"])
        };
    }
}
