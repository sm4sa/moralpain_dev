package edu.uva.cs.moralpain.typedb;

import com.vaticle.typedb.common.test.TypeDBRunner;
import com.vaticle.typedb.common.test.Util;
import com.vaticle.typedb.common.test.core.TypeDBCoreRunner;
import edu.uva.cs.moralpain.utils.VariableManager;
import org.zeroturnaround.exec.ProcessExecutor;
import org.zeroturnaround.exec.StartedProcess;

import java.io.File;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.file.Path;
import java.util.List;
import java.util.concurrent.TimeoutException;

import static com.vaticle.typedb.common.test.Util.*;

public class TypeDBTestRunner implements TypeDBRunner {

    private final Path distribution;
    private final Path dataDir;
    private final Path logsDir;
    private final int port;
    private StartedProcess process;
    private final ProcessExecutor executor;

    public TypeDBTestRunner(VariableManager variableManager) throws InterruptedException, TimeoutException, IOException {
        String _port = variableManager.getOrDefault("typedb.port", "");
        port = _port.isEmpty() ? findUnusedPorts(1).get(0) : Integer.parseInt(_port);

        System.out.println(address() + ": Constructing " + name() + " runner");
        System.out.println(address() + ": Extracting distribution archive...");

        String _serverArchive = variableManager.getOrDefault("typedb.distribution", "");
        File serverArchive = _serverArchive.isEmpty() ? getServerArchiveFile() : new File(_serverArchive);
        distribution = unarchive(serverArchive);

        System.out.println(address() + ": Distribution archive extracted.");
        dataDir = distribution.resolve("server").resolve("data");
        logsDir = distribution.resolve("server").resolve("logs");
        executor = createProcessExecutor(distribution);
        System.out.println(address() + ": Runner constructed");
    }

    private String name() {
        return "TypeDB Test Runner";
    }

    @Override
    public String address() {
        return host() + ":" + port();
    }

    public String host() {
        return "127.0.0.1";
    }

    public int port() {
        return port;
    }

    @Override
    public void start() {
        System.out.println(address() + ": " +  name() + "is starting... ");
        System.out.println(address() + ": Distribution is located at " + distribution.toAbsolutePath());
        System.out.println(address() + ": Data directory is located at " + dataDir.toAbsolutePath());
        System.out.println(address() + ": Server bootup command = " + command());
        try {
            process = Util.startProcess(executor, command(), new InetSocketAddress(host(), port()));
        } catch (Throwable e) {
            printLogs();
            throw new RuntimeException(e);
        }
    }

    private List<String> command() {
        return typeDBCommand(
                "server",
                "--server.address",
                address(),
                "--storage.data",
                dataDir.toAbsolutePath().toString()
        );
    }

    @Override
    public boolean isStopped() {
        return !process.getProcess().isAlive();
    }

    @Override
    public void stop() {
        if (process != null) {
            try {
                System.out.println(address() + ": Stopping...");
                process.getProcess().destroyForcibly();
                System.out.println(address() + ": Stopped.");
            } catch (Exception e) {
                printLogs();
                throw e;
            }
        }
    }

    private void printLogs() {
        System.out.println(address() + ": ================");
        System.out.println(address() + ": Logs:");
        Path logPath = logsDir.resolve("typedb.log").toAbsolutePath();
        try {
            executor.command("cat", logPath.toString()).execute();
        } catch (IOException | InterruptedException | TimeoutException e) {
            System.out.println(address() + ": Unable to print '" + logPath + "'");
            e.printStackTrace();
        }
        System.out.println(address() + ": ================");
    }
}
