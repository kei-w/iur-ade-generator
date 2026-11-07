package poc;

import org.citydb.core.database.schema.mapping.SchemaMapping;
import org.citydb.core.database.schema.util.SchemaMappingUtil;
import org.citydb.core.operation.importer.database.TableHelper;

import java.io.File;
import java.io.InputStream;
import java.util.List;

/**
 * Prints the batch commit order the Importer/Exporter derives from the 3DCityDB schema mapping merged with an ADE
 * schema mapping (TableHelper), to check that referenced tables are flushed before the tables referencing them.
 * Usage: CommitOrder <ade schema-mapping.xml> [table...]
 */
public class CommitOrder {
    public static void main(String[] args) throws Exception {
        SchemaMappingUtil util = SchemaMappingUtil.getInstance();
        SchemaMapping mapping;
        try (InputStream in = SchemaMapping.class.getResourceAsStream("/org/citydb/core/database/schema/3dcitydb-schema.xml")) {
            mapping = util.unmarshal(in);
        }
        SchemaMapping ade = util.unmarshal(mapping, new File(args[0]));
        mapping.merge(ade);
        List<String> order = new TableHelper(mapping).getCommitOrder();
        System.out.println("tables in commit order: " + order.size());
        if (args.length > 1) {
            for (int i = 1; i < args.length; i++)
                System.out.println(order.indexOf(args[i]) + "\t" + args[i]);
        } else {
            for (int i = 0; i < order.size(); i++)
                System.out.println(i + "\t" + order.get(i));
        }
    }
}
