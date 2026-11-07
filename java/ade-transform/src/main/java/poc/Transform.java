package poc;

import org.citydb.plugins.ade_manager.ADEManagerPlugin;
import org.citydb.plugins.ade_manager.config.ConfigImpl;
import org.citydb.plugins.ade_manager.transformation.TransformationController;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

/**
 * Headless ADE Manager transformation: XSD -> 3DCityDB schema mapping + DDL.
 * Usage: Transform <ade.xsd> <outputDir> <name> <version> <dbPrefix> <initialObjectClassId> [excludedNamespace...]
 */
public class Transform {
    public static void main(String[] args) throws Exception {
        if (args.length < 6) {
            System.err.println("usage: Transform <ade.xsd> <outputDir> <name> <version> <dbPrefix> <initialObjectClassId> [excludedNamespace...]");
            System.exit(2);
        }

        Files.createDirectories(Paths.get(args[1]));

        ConfigImpl config = new ConfigImpl();
        config.setXMLschemaInputPath(args[0]);
        config.setTransformationOutputPath(args[1]);
        config.setAdeName(args[2]);
        config.setAdeDescription(args[2]);
        config.setAdeVersion(args[3]);
        config.setAdeDbPrefix(args[4]);
        config.setInitialObjectclassId(Integer.parseInt(args[5]));

        ADEManagerPlugin plugin = new ADEManagerPlugin();
        plugin.setConfig(config);

        TransformationController controller = new TransformationController(plugin);
        List<String> namespaces = new ArrayList<>(controller.getADENamespacesFromXMLSchema(args[0]));
        for (int i = 6; i < args.length; i++)
            namespaces.remove(args[i]);
        System.out.println("ADE namespaces: " + namespaces);
        controller.doProcess(namespaces);
        System.out.println("transformation written to " + args[1]);
    }
}
