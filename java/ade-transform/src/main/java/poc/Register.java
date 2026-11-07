package poc;

import org.citydb.config.project.database.DatabaseConnection;
import org.citydb.config.project.database.DatabaseType;
import org.citydb.core.database.connection.DatabaseConnectionPool;
import org.citydb.plugins.ade_manager.ADEManagerPlugin;
import org.citydb.plugins.ade_manager.config.ConfigImpl;
import org.citydb.plugins.ade_manager.registry.ADERegistrationController;
import org.citydb.plugins.ade_manager.registry.metadata.ADEMetadataInfo;

/**
 * Headless ADE registration: registers the ADE found in <extensionDir> (schema-mapping/ + 3dcitydb/)
 * in a 3DCityDB and installs the generated delete/envelope functions.
 * Usage: Register <extensionDir> <host> <port> <db> <user> <password>
 */
public class Register {
    public static void main(String[] args) throws Exception {
        if (args.length != 6) {
            System.err.println("usage: Register <extensionDir> <host> <port> <db> <user> <password>");
            System.exit(2);
        }

        DatabaseConnection connection = new DatabaseConnection();
        connection.setDatabaseType(DatabaseType.POSTGIS);
        connection.setServer(args[1]);
        connection.setPort(Integer.parseInt(args[2]));
        connection.setSid(args[3]);
        connection.setUser(args[4]);
        connection.setPassword(args[5]);

        DatabaseConnectionPool pool = DatabaseConnectionPool.getInstance();
        pool.connect(connection);
        System.out.println("connected: " + pool.getActiveDatabaseAdapter().getConnectionMetaData().getCityDBVersion());

        ConfigImpl config = new ConfigImpl();
        config.setAdeRegistryInputPath(args[0]);
        ADEManagerPlugin plugin = new ADEManagerPlugin();
        plugin.setConfig(config);

        ADERegistrationController controller = new ADERegistrationController(plugin);
        try {
            controller.initDBConneciton();
            boolean registered = controller.registerADE();
            System.out.println("registerADE: " + registered);
            org.citydb.plugins.ade_manager.registry.model.DBSQLScript deleteScript = controller.createDeleteScripts();
            java.nio.file.Files.writeString(java.nio.file.Path.of(System.getProperty("deleteScript", "delete_script.sql")), deleteScript.toString());
            controller.installDBScript(deleteScript);
            System.out.println("delete scripts installed");
            controller.installDBScript(controller.createEnvelopeScripts());
            System.out.println("envelope scripts installed");
            controller.commitTransactions();
            for (ADEMetadataInfo info : controller.queryRegisteredADEs())
                System.out.println("registered ADE: " + info.getName() + " " + info.getVersion() + " prefix=" + info.getDbPrefix());
        } catch (Exception e) {
            controller.rollbackTransactions();
            throw e;
        } finally {
            controller.closeDBConnection();
            pool.disconnect();
        }
    }
}
