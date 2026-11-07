package poc;

import org.citydb.core.database.schema.mapping.SchemaMapping;
import org.citydb.core.database.schema.util.SchemaMappingUtil;
import org.citydb.core.operation.importer.database.TableHelper;

import java.io.File;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.*;

/**
 * Re-runs the weight computation of the Importer/Exporter's TableHelper (impexp 5.5.0) on the dependency map it builds
 * from the 3DCityDB schema mapping merged with an ADE schema mapping, once with int arithmetic (as the tool does) and
 * once with long arithmetic, to show where the int weights overflow and whether the commit order still puts the
 * referenced tables first. Usage: TableWeights <ade schema-mapping.xml> [table...]
 */
public class TableWeights {
    @SuppressWarnings("unchecked")
    public static void main(String[] args) throws Exception {
        SchemaMappingUtil util = SchemaMappingUtil.getInstance();
        SchemaMapping mapping;
        try (InputStream in = SchemaMapping.class.getResourceAsStream("/org/citydb/core/database/schema/3dcitydb-schema.xml")) {
            mapping = util.unmarshal(in);
        }
        mapping.merge(util.unmarshal(mapping, new File(args[0])));
        TableHelper helper = new TableHelper(mapping);
        Field field = TableHelper.class.getDeclaredField("dependencyMap");
        field.setAccessible(true);
        HashMap<String, Set<String>> deps = (HashMap<String, Set<String>>) field.get(helper);

        HashMap<String, Long> longWeights = new HashMap<>();
        HashMap<String, Integer> intWeights = new HashMap<>();
        long[] calls = {0};
        for (String table : deps.keySet())
            calc(table, deps, longWeights, intWeights, calls);
        List<Map.Entry<String, Long>> byLong = new ArrayList<>(longWeights.entrySet());
        byLong.sort(Map.Entry.<String, Long>comparingByValue().reversed());
        List<Map.Entry<String, Integer>> byInt = new ArrayList<>(intWeights.entrySet());
        byInt.sort(Map.Entry.<String, Integer>comparingByValue().reversed());
        long overflow = longWeights.values().stream().filter(w -> w > Integer.MAX_VALUE).count();
        System.out.println("tables: " + longWeights.size() + ", calcWeights calls: " + calls[0] + ", tables over Integer.MAX_VALUE: " + overflow
                + ", max: " + byLong.get(0));
        System.out.println("top 10 (long): " + byLong.subList(0, Math.min(10, byLong.size())));
        if (System.getProperty("dump") != null) {
            for (Map.Entry<String, Long> e : byLong.subList(0, Math.min(40, byLong.size()))) {
                List<String> dependents = new ArrayList<>();
                for (Map.Entry<String, Set<String>> d : deps.entrySet())
                    if (d.getValue().contains(e.getKey()))
                        dependents.add(d.getKey() + "=" + longWeights.get(d.getKey()));
                System.out.println(e.getKey() + " " + e.getValue() + " <- " + dependents);
            }
        }
        List<String> intOrder = new ArrayList<>();
        for (Map.Entry<String, Integer> e : byInt)
            intOrder.add(e.getKey());
        for (int i = 1; i < args.length; i++)
            System.out.println(args[i] + ": long=" + longWeights.get(args[i]) + " int rank=" + intOrder.indexOf(args[i]));
    }

    private static void calc(String table, HashMap<String, Set<String>> deps, HashMap<String, Long> lw, HashMap<String, Integer> iw, long[] calls) {
        calls[0]++;
        lw.putIfAbsent(table, 0L);
        iw.putIfAbsent(table, 0);
        long w = lw.get(table) + 1;
        int wi = iw.get(table) + 1;
        Set<String> d = deps.get(table);
        if (d == null)
            return;
        for (String dep : d) {
            lw.put(dep, lw.containsKey(dep) ? lw.get(dep) + w : w);
            iw.put(dep, iw.containsKey(dep) ? iw.get(dep) + wi : wi);
            calc(dep, deps, lw, iw, calls);
        }
    }
}
