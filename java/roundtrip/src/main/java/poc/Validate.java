package poc;

import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import javax.xml.XMLConstants;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * XSD validation of a CityGML file against a set of local schema files.
 * Usage: Validate <file.gml> <schema.xsd>...
 * Schemas are loaded in the given order; imports inside them resolve relative to each file.
 */
public class Validate {
    public static void main(String[] args) throws Exception {
        if (args.length < 2) {
            System.err.println("usage: Validate <file.gml> <schema.xsd>...");
            System.exit(2);
        }

        List<Source> sources = new ArrayList<>();
        for (int i = 1; i < args.length; i++)
            sources.add(new StreamSource(new File(args[i])));

        SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        Schema schema = factory.newSchema(sources.toArray(new Source[0]));
        Validator validator = schema.newValidator();

        int[] errors = {0};
        validator.setErrorHandler(new ErrorHandler() {
            @Override
            public void warning(SAXParseException e) {
                System.out.println("WARNING line " + e.getLineNumber() + ": " + e.getMessage());
            }

            @Override
            public void error(SAXParseException e) {
                errors[0]++;
                System.out.println("ERROR line " + e.getLineNumber() + ": " + e.getMessage());
            }

            @Override
            public void fatalError(SAXParseException e) throws SAXException {
                errors[0]++;
                System.out.println("FATAL line " + e.getLineNumber() + ": " + e.getMessage());
                throw e;
            }
        });

        validator.validate(new StreamSource(new File(args[0])));
        System.out.println((errors[0] == 0 ? "VALID: " : "INVALID (" + errors[0] + " errors): ") + args[0]);
        System.exit(errors[0] == 0 ? 0 : 1);
    }
}
