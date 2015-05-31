package duell.build.plugin.library.checkstyle;

import duell.build.objects.DuellProjectXML;
import duell.build.objects.Configuration;
import duell.build.plugin.library.checkstyle.LibraryConfiguration;

import duell.helpers.XMLHelper;

import haxe.xml.Fast;

/**
    @author jxav
 */
class LibraryXMLParser
{
    public static function parse(xml: Fast): Void
    {
        Configuration.getData().LIBRARY.CHECKSTYLE = LibraryConfiguration.getData();

        for (element in xml.elements)
        {
            if (!XMLHelper.isValidElement(element, DuellProjectXML.getConfig().parsingConditions))
                continue;

            switch(element.name)
            {
                case 'config':
                    parseConfigElement(element);

                case 'output':
                    parseOutputElement(element);
            }
        }
    }

    private static function parseConfigElement(element: Fast): Void
    {
        if (element.has.path)
        {
            LibraryConfiguration.getData().CONFIG_PATH = DuellProjectXML.getConfig().resolvePath(element.att.path);
        }
    }

    private static function parseOutputElement(element: Fast): Void
    {
        if (element.has.path)
        {
            LibraryConfiguration.getData().OUTPUT_PATH = DuellProjectXML.getConfig().resolvePath(element.att.path);
        }
    }
}
