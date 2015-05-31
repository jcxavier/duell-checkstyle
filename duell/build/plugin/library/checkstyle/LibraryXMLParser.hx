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
                case 'config-id':
                    parseConfigIdElement(element);
            }
        }
    }

    private static function parseConfigIdElement(element: Fast): Void
    {
        if (element.has.value)
        {
            LibraryConfiguration.getData().CONFIG_ID = element.att.value;
        }
    }
}
