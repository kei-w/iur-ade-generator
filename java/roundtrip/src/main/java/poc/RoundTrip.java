package poc;

import org.citygml4j.CityGMLContext;
import org.citygml4j.ade.iur.UrbanRevitalizationADEContext;
import org.citygml4j.builder.jaxb.CityGMLBuilder;
import org.citygml4j.model.citygml.CityGML;
import org.citygml4j.model.citygml.ade.generic.ADEGenericElement;
import org.citygml4j.model.citygml.ade.ADEComponent;
import org.citygml4j.model.citygml.building.AbstractBuilding;
import org.citygml4j.model.citygml.core.AbstractCityObject;
import org.citygml4j.model.citygml.core.CityModel;
import org.citygml4j.model.citygml.core.CityObjectMember;
import org.citygml4j.model.gml.feature.AbstractFeature;
import org.citygml4j.model.module.ModuleContext;
import org.citygml4j.model.module.citygml.CityGMLVersion;
import org.citygml4j.util.walker.FeatureWalker;
import org.citygml4j.xml.io.CityGMLInputFactory;
import org.citygml4j.xml.io.CityGMLOutputFactory;
import org.citygml4j.xml.io.reader.CityGMLReader;
import org.citygml4j.xml.io.writer.CityGMLWriter;

import java.io.File;
import java.util.Map;
import java.util.TreeMap;

/**
 * Stage A harness: read a CityGML file with the i-UR ADE module, report what was
 * bound to typed ADE classes, and write it back out unchanged.
 */
public class RoundTrip {
    public static void main(String[] args) throws Exception {
        if (args.length != 2) {
            System.err.println("usage: RoundTrip <input.gml> <output.gml>");
            System.exit(2);
        }

        File input = new File(args[0]);
        File output = new File(args[1]);

        CityGMLContext context = CityGMLContext.getInstance();
        context.registerADEContext(new UrbanRevitalizationADEContext());
        CityGMLBuilder builder = context.createCityGMLBuilder();

        CityGMLInputFactory in = builder.createCityGMLInputFactory();
        CityGML cityGML;
        try (CityGMLReader reader = in.createCityGMLReader(input)) {
            cityGML = reader.nextFeature();
        }

        if (!(cityGML instanceof CityModel)) {
            System.err.println("root feature is not a CityModel: " + cityGML.getClass());
            System.exit(1);
        }

        CityModel cityModel = (CityModel) cityGML;
        Map<String, Integer> typed = new TreeMap<>();
        int[] generic = {0};
        int[] buildings = {0};

        cityModel.accept(new FeatureWalker() {
            @Override
            public void visit(AbstractCityObject cityObject) {
                if (cityObject instanceof AbstractBuilding) {
                    buildings[0]++;
                    for (ADEComponent ade : ((AbstractBuilding) cityObject).getGenericApplicationPropertyOfAbstractBuilding())
                        typed.merge(ade.getClass().getSimpleName(), 1, Integer::sum);
                }
                super.visit(cityObject);
            }

            @Override
            public void visit(ADEGenericElement adeGenericElement) {
                generic[0]++;
                System.out.println("  unbound ADE element: " + adeGenericElement.getContent().getNamespaceURI()
                        + " " + adeGenericElement.getContent().getLocalName());
                super.visit(adeGenericElement);
            }
        });

        System.out.println("buildings: " + buildings[0]);
        System.out.println("typed ADE properties on buildings:");
        typed.forEach((k, v) -> System.out.println("  " + k + ": " + v));
        System.out.println("generic (unbound) ADE elements: " + generic[0]);

        ModuleContext moduleContext = new ModuleContext(CityGMLVersion.v2_0_0);
        CityGMLOutputFactory out = builder.createCityGMLOutputFactory(moduleContext);
        try (CityGMLWriter writer = out.createCityGMLWriter(output, "UTF-8")) {
            writer.setPrefixes(moduleContext);
            writer.setPrefixes(context.getADEContexts());
            writer.setSchemaLocations(moduleContext);
            writer.setSchemaLocations(context.getADEContexts());
            writer.setIndentString("\t");
            writer.write((AbstractFeature) cityModel);
        }

        System.out.println("written: " + output);
    }
}
